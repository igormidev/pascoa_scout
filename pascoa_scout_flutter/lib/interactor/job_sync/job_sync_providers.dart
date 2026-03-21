import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/interactor/job_filter/job_filter_providers.dart';
import 'package:pascoa_scout/interactor/job_sync/job_sync_state.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

const _jobSyncIntervalPreferenceKey = 'job_sync_interval_minutes';

final jobSyncControllerProvider =
    NotifierProvider<JobSyncController, JobSyncState>(JobSyncController.new);

final jobSyncClockProvider = StreamProvider<DateTime>((ref) async* {
  yield DateTime.now();
  while (true) {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield DateTime.now();
  }
});

Pagination buildJobSyncPagination() {
  return Pagination(
    pageNumber: 1,
    pagesToScrape: 1,
    resultsPerPage: 10,
    searchSortOrder: SearchSortOrder.newest,
  );
}

class JobSyncController extends Notifier<JobSyncState> {
  Timer? _nextPullTimer;
  Timer? _successBannerTimer;
  int _sessionId = 0;

  @override
  JobSyncState build() {
    ref.onDispose(_disposeTimers);

    final sharedPreferences = ref.read(sharedPreferencesProvider);
    final intervalMinutes =
        sharedPreferences.getInt(_jobSyncIntervalPreferenceKey) ?? 10;

    return JobSyncState.initial(intervalMinutes: intervalMinutes);
  }

  Future<void> setIntervalMinutes(int value) async {
    final normalizedValue = value < 1 ? 1 : value;
    await ref
        .read(sharedPreferencesProvider)
        .setInt(_jobSyncIntervalPreferenceKey, normalizedValue);

    state = state.copyWith(intervalMinutes: normalizedValue);

    if (state.isRunning) {
      _scheduleNextPull(DateTime.now().add(Duration(minutes: normalizedValue)));
    }
  }

  void startSync() {
    final currentFilter = ref
        .read(currentFilterNotifier.notifier)
        .currentFilter;
    if (currentFilter == null || state.isRunning) {
      return;
    }

    _sessionId += 1;
    _disposePullTimer();
    final startedAt = DateTime.now();

    state = state.copyWith(
      isRunning: true,
      isPulling: true,
      nextPullAt: null,
      lastPullStartedAt: startedAt,
      successBanner: null,
    );

    unawaited(_runPull(sessionId: _sessionId, rescheduleAfterwards: true));
  }

  void stopSync() {
    _sessionId += 1;
    _disposePullTimer();
    state = state.copyWith(
      isRunning: false,
      isPulling: false,
      nextPullAt: null,
    );
  }

  void resetForNewFilter() {
    _sessionId += 1;
    _disposeTimers();
    state = JobSyncState.initial(intervalMinutes: state.intervalMinutes);
  }

  Future<void> pullNow() async {
    if (state.isPulling) {
      return;
    }

    _sessionId += 1;
    final sessionId = _sessionId;
    await _runPull(sessionId: sessionId, rescheduleAfterwards: state.isRunning);
  }

  void clearError(JobSyncErrorLog error) {
    state = state.copyWith(
      errors: state.errors.where((candidate) => candidate != error).toList(),
    );
  }

  void clearSuccessBanner() {
    _disposeSuccessTimer();
    state = state.copyWith(successBanner: null);
  }

  void _scheduleNextPull(DateTime nextPullAt) {
    _disposePullTimer();

    state = state.copyWith(nextPullAt: nextPullAt);
    final durationUntilNextPull = nextPullAt.difference(DateTime.now());
    _nextPullTimer = Timer(
      durationUntilNextPull.isNegative ? Duration.zero : durationUntilNextPull,
      () {
        final sessionId = _sessionId;
        unawaited(_runPull(sessionId: sessionId, rescheduleAfterwards: true));
      },
    );
  }

  Future<void> _runPull({
    required int sessionId,
    required bool rescheduleAfterwards,
  }) async {
    final currentFilter = ref
        .read(currentFilterNotifier.notifier)
        .currentFilter;
    if (currentFilter == null) {
      stopSync();
      return;
    }

    state = state.copyWith(
      isPulling: true,
      lastPullStartedAt: DateTime.now(),
      nextPullAt: null,
      successBanner: null,
    );

    try {
      final jobs = await ref
          .read(clientProvider)
          .upworkJobs
          .getJobs(
            filter: currentFilter,
            pagination: _fixedPollingPagination(),
          );

      if (sessionId != _sessionId) {
        return;
      }

      final now = DateTime.now();
      state = state.copyWith(
        isPulling: false,
        lastPullSucceededAt: now,
        jobs: _mergeJobs(
          previousJobs: state.jobs,
          incomingJobs: jobs,
          now: now,
        ),
        successBanner: JobSyncSuccessBanner(
          message: 'Everything has been fetched as expected.',
          shownAt: now,
        ),
      );

      _scheduleSuccessBannerRemoval();

      if (rescheduleAfterwards && state.isRunning) {
        _scheduleNextPull(now.add(Duration(minutes: state.intervalMinutes)));
      }
    } catch (error, stackTrace) {
      if (sessionId != _sessionId) {
        return;
      }

      final now = DateTime.now();
      state = state.copyWith(
        isPulling: false,
        errors: [
          JobSyncErrorLog(
            happenedAt: now,
            type: error.runtimeType.toString(),
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
          ...state.errors,
        ],
      );

      if (rescheduleAfterwards && state.isRunning) {
        _scheduleNextPull(now.add(Duration(minutes: state.intervalMinutes)));
      }
    }
  }

  List<TrackedJob> _mergeJobs({
    required List<TrackedJob> previousJobs,
    required List<JobInfo> incomingJobs,
    required DateTime now,
  }) {
    final mergedJobs = <String, TrackedJob>{
      for (final trackedJob in previousJobs) trackedJob.uniqueKey: trackedJob,
    };

    for (final job in incomingJobs) {
      final candidate = _trackedJobFrom(job, now);
      final existing = mergedJobs[candidate.uniqueKey];
      if (existing == null) {
        mergedJobs[candidate.uniqueKey] = candidate;
        continue;
      }

      mergedJobs[candidate.uniqueKey] = existing.copyWith(
        job: job,
        estimatedPostedAt:
            candidate.estimatedPostedAt.isBefore(existing.estimatedPostedAt)
            ? candidate.estimatedPostedAt
            : existing.estimatedPostedAt,
        lastSeenAt: now,
      );
    }

    final jobs = mergedJobs.values.toList()
      ..sort(
        (left, right) =>
            right.estimatedPostedAt.compareTo(left.estimatedPostedAt),
      );

    return jobs;
  }

  TrackedJob _trackedJobFrom(JobInfo job, DateTime now) {
    final estimatedPostedAt = _estimatePostedAt(job, now);
    return TrackedJob(
      job: job,
      firstSeenAt: now,
      estimatedPostedAt: estimatedPostedAt,
      lastSeenAt: now,
    );
  }

  DateTime _estimatePostedAt(JobInfo job, DateTime now) {
    final absoluteDate = DateTime.tryParse(job.absoluteDate ?? '');
    if (absoluteDate != null) {
      return absoluteDate;
    }

    final relativeAge = _parseRelativeAge(job.relativeDate);
    if (relativeAge != null) {
      return now.subtract(relativeAge);
    }

    return now;
  }

  Duration? _parseRelativeAge(String? relativeDate) {
    if (relativeDate == null || relativeDate.trim().isEmpty) {
      return null;
    }

    final normalized = relativeDate.trim().toLowerCase();
    if (normalized == 'just now') {
      return Duration.zero;
    }

    final match = RegExp(r'(\d+)\s+([a-z]+)').firstMatch(normalized);
    if (match == null) {
      return null;
    }

    final value = int.tryParse(match.group(1) ?? '');
    final unit = match.group(2) ?? '';
    if (value == null) {
      return null;
    }

    if (unit.startsWith('sec')) {
      return Duration(seconds: value);
    }
    if (unit.startsWith('min')) {
      return Duration(minutes: value);
    }
    if (unit.startsWith('hour') || unit == 'hr' || unit == 'hrs') {
      return Duration(hours: value);
    }
    if (unit.startsWith('day')) {
      return Duration(days: value);
    }
    if (unit.startsWith('week')) {
      return Duration(days: value * 7);
    }

    return null;
  }

  void _scheduleSuccessBannerRemoval() {
    _disposeSuccessTimer();
    _successBannerTimer = Timer(const Duration(seconds: 3), () {
      state = state.copyWith(successBanner: null);
    });
  }

  void _disposePullTimer() {
    _nextPullTimer?.cancel();
    _nextPullTimer = null;
  }

  void _disposeSuccessTimer() {
    _successBannerTimer?.cancel();
    _successBannerTimer = null;
  }

  void _disposeTimers() {
    _disposePullTimer();
    _disposeSuccessTimer();
  }

  Pagination _fixedPollingPagination() {
    return buildJobSyncPagination();
  }
}
