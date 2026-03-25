import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout/core/global_providers.dart';
import 'package:pascoa_scout/interactor/app_notification/app_notification_providers.dart';
import 'package:pascoa_scout/interactor/job_filter/job_filter_providers.dart';
import 'package:pascoa_scout/interactor/job_sync/job_sync_state.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

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
    resultsPerPage: 20,
    searchSortOrder: SearchSortOrder.newest,
  );
}

class JobSyncController extends Notifier<JobSyncState> {
  StreamSubscription<JobAutomationOverview>? _overviewSubscription;

  @override
  JobSyncState build() {
    ref.onDispose(_dispose);
    unawaited(_initialize());
    return JobSyncState.initial();
  }

  Future<void> _initialize() async {
    try {
      var overview = await ref.read(clientProvider).jobAutomation.getOverview();
      final localFilter = _readLocalSavedFilter();

      if (!_hasUsableSearchQuery(overview.settings.jobFilter) &&
          localFilter != null) {
        overview = await ref
            .read(clientProvider)
            .jobAutomation
            .updateSettings(
              update: JobAutomationSettingsUpdate(
                jobFilter: localFilter,
                scoreBatchSize: overview.settings.scoreBatchSize,
                proposalBatchSize: overview.settings.proposalBatchSize,
                upworkSyncResultsPerPage:
                    overview.settings.upworkSyncResultsPerPage,
                proposalMinimumScorePercentage:
                    overview.settings.proposalMinimumScorePercentage,
                loopDelayMinutes: overview.settings.loopDelayMinutes,
              ),
            );
      }

      if (!overview.settings.isJobFetchingPaused) {
        await _setPaused(true);
      } else {
        _applyOverview(overview);
      }

      await _subscribeToOverview();
    } catch (error, stackTrace) {
      state = state.copyWith(
        isBusy: false,
        errors: [
          JobSyncErrorLog(
            happenedAt: DateTime.now(),
            type: error.runtimeType.toString(),
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
        ],
      );
    }
  }

  Future<void> _subscribeToOverview() async {
    await _overviewSubscription?.cancel();
    _overviewSubscription = ref
        .read(clientProvider)
        .jobAutomation
        .watchOverview()
        .listen(
          _applyOverview,
          onError: (Object error, StackTrace stackTrace) {
            state = state.copyWith(
              isBusy: false,
              errors: [
                JobSyncErrorLog(
                  happenedAt: DateTime.now(),
                  type: error.runtimeType.toString(),
                  message: error.toString(),
                  stackTrace: stackTrace.toString(),
                ),
              ],
            );
          },
        );
  }

  Future<void> syncFilterToServer(JobFilter jobFilter) async {
    await _updateSettings(
      jobFilter: jobFilter,
      scoreBatchSize: state.scoreBatchSize,
      proposalBatchSize: state.proposalBatchSize,
      upworkSyncResultsPerPage: state.upworkSyncResultsPerPage,
      proposalMinimumScorePercentage: state.proposalMinimumScorePercentage,
      loopDelayMinutes: state.intervalMinutes,
      successMessage: 'Server-side automation settings saved.',
    );
  }

  Future<void> setIntervalMinutes(int value) async {
    final normalizedValue = value < 1 ? 1 : value;
    final jobFilter = _resolveJobFilter();
    if (jobFilter == null) {
      return;
    }

    await _updateSettings(
      jobFilter: jobFilter,
      scoreBatchSize: state.scoreBatchSize,
      proposalBatchSize: state.proposalBatchSize,
      upworkSyncResultsPerPage: state.upworkSyncResultsPerPage,
      proposalMinimumScorePercentage: state.proposalMinimumScorePercentage,
      loopDelayMinutes: normalizedValue,
      successMessage: 'Loop delay updated.',
    );
  }

  Future<void> setScoreBatchSize(int value) async {
    final normalizedValue = value < 1 ? 1 : value;
    final jobFilter = _resolveJobFilter();
    if (jobFilter == null) {
      return;
    }

    await _updateSettings(
      jobFilter: jobFilter,
      scoreBatchSize: normalizedValue,
      proposalBatchSize: state.proposalBatchSize,
      upworkSyncResultsPerPage: state.upworkSyncResultsPerPage,
      proposalMinimumScorePercentage: state.proposalMinimumScorePercentage,
      loopDelayMinutes: state.intervalMinutes,
      successMessage: 'Score batch size updated.',
    );
  }

  Future<void> setProposalBatchSize(int value) async {
    final normalizedValue = value < 1 ? 1 : value;
    final jobFilter = _resolveJobFilter();
    if (jobFilter == null) {
      return;
    }

    await _updateSettings(
      jobFilter: jobFilter,
      scoreBatchSize: state.scoreBatchSize,
      proposalBatchSize: normalizedValue,
      upworkSyncResultsPerPage: state.upworkSyncResultsPerPage,
      proposalMinimumScorePercentage: state.proposalMinimumScorePercentage,
      loopDelayMinutes: state.intervalMinutes,
      successMessage: 'Proposal batch size updated.',
    );
  }

  Future<void> setUpworkSyncResultsPerPage(int value) async {
    final normalizedValue = value < 1 ? 1 : value;
    final jobFilter = _resolveJobFilter();
    if (jobFilter == null) {
      return;
    }

    await _updateSettings(
      jobFilter: jobFilter,
      scoreBatchSize: state.scoreBatchSize,
      proposalBatchSize: state.proposalBatchSize,
      upworkSyncResultsPerPage: normalizedValue,
      proposalMinimumScorePercentage: state.proposalMinimumScorePercentage,
      loopDelayMinutes: state.intervalMinutes,
      successMessage: 'Upwork sync batch size updated.',
    );
  }

  Future<void> setProposalMinimumScorePercentage(int value) async {
    final normalizedValue = value.clamp(0, 100);
    final jobFilter = _resolveJobFilter();
    if (jobFilter == null) {
      return;
    }

    await _updateSettings(
      jobFilter: jobFilter,
      scoreBatchSize: state.scoreBatchSize,
      proposalBatchSize: state.proposalBatchSize,
      upworkSyncResultsPerPage: state.upworkSyncResultsPerPage,
      proposalMinimumScorePercentage: normalizedValue,
      loopDelayMinutes: state.intervalMinutes,
      successMessage: 'Minimum proposal score updated.',
    );
  }

  Future<void> startSync() async {
    await _setPaused(false, successMessage: 'Job fetching resumed.');
  }

  Future<void> stopSync() async {
    await _setPaused(true, successMessage: 'Job fetching paused.');
  }

  Future<void> _setPaused(bool isPaused, {String? successMessage}) async {
    state = state.copyWith(isBusy: true);
    try {
      final overview = await ref
          .read(clientProvider)
          .jobAutomation
          .setJobFetchingPaused(isPaused: isPaused);
      _applyOverview(overview);
      if (successMessage != null) {
        ref.notifySnackbar(successMessage);
      }
    } catch (error, stackTrace) {
      state = state.copyWith(
        isBusy: false,
        errors: [
          JobSyncErrorLog(
            happenedAt: DateTime.now(),
            type: error.runtimeType.toString(),
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
          ...state.errors,
        ],
      );
    }
  }

  Future<void> _updateSettings({
    required JobFilter jobFilter,
    required int scoreBatchSize,
    required int proposalBatchSize,
    required int upworkSyncResultsPerPage,
    required int proposalMinimumScorePercentage,
    required int loopDelayMinutes,
    required String successMessage,
  }) async {
    try {
      final overview = await ref
          .read(clientProvider)
          .jobAutomation
          .updateSettings(
            update: JobAutomationSettingsUpdate(
              jobFilter: jobFilter,
              scoreBatchSize: scoreBatchSize,
              proposalBatchSize: proposalBatchSize,
              upworkSyncResultsPerPage: upworkSyncResultsPerPage,
              proposalMinimumScorePercentage: proposalMinimumScorePercentage,
              loopDelayMinutes: loopDelayMinutes,
            ),
          );
      _applyOverview(overview);
      ref.notifySnackbar(successMessage);
    } catch (error, stackTrace) {
      state = state.copyWith(
        errors: [
          JobSyncErrorLog(
            happenedAt: DateTime.now(),
            type: error.runtimeType.toString(),
            message: error.toString(),
            stackTrace: stackTrace.toString(),
          ),
          ...state.errors,
        ],
      );
    }
  }

  void resetForNewFilter() {}

  void clearError(JobSyncErrorLog error) {
    state = state.copyWith(
      errors: state.errors.where((candidate) => candidate != error).toList(),
    );
  }

  void _applyOverview(JobAutomationOverview overview) {
    final runtime = overview.runtime;
    final errors = runtime.lastErrorMessage == null
        ? const <JobSyncErrorLog>[]
        : [
            JobSyncErrorLog(
              happenedAt: runtime.lastErrorAt ?? DateTime.now(),
              type: runtime.currentStep.name,
              message: runtime.lastErrorMessage!,
              stackTrace: '',
            ),
          ];
    state = state.copyWith(isBusy: false, overview: overview, errors: errors);
  }

  JobFilter? _resolveJobFilter() {
    final serverFilter = state.settings?.jobFilter;
    if (_hasUsableSearchQuery(serverFilter)) {
      return serverFilter;
    }

    return _readLocalSavedFilter();
  }

  JobFilter? _readLocalSavedFilter() {
    return ref.read(currentFilterNotifier.notifier).currentFilter;
  }

  bool _hasUsableSearchQuery(JobFilter? filter) {
    return filter != null && filter.searchQueryTerm.trim().isNotEmpty;
  }

  Future<void> _dispose() async {
    await _overviewSubscription?.cancel();
  }
}
