import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobSyncState {
  const JobSyncState({
    required this.isRunning,
    required this.isPulling,
    required this.intervalMinutes,
    required this.nextPullAt,
    required this.lastPullStartedAt,
    required this.lastPullSucceededAt,
    required this.successBanner,
    required this.errors,
    required this.jobs,
  });

  factory JobSyncState.initial({required int intervalMinutes}) {
    return JobSyncState(
      isRunning: false,
      isPulling: false,
      intervalMinutes: intervalMinutes,
      nextPullAt: null,
      lastPullStartedAt: null,
      lastPullSucceededAt: null,
      successBanner: null,
      errors: const <JobSyncErrorLog>[],
      jobs: const <TrackedJob>[],
    );
  }

  final bool isRunning;
  final bool isPulling;
  final int intervalMinutes;
  final DateTime? nextPullAt;
  final DateTime? lastPullStartedAt;
  final DateTime? lastPullSucceededAt;
  final JobSyncSuccessBanner? successBanner;
  final List<JobSyncErrorLog> errors;
  final List<TrackedJob> jobs;

  bool get isLocked => isRunning || isPulling;

  JobSyncState copyWith({
    bool? isRunning,
    bool? isPulling,
    int? intervalMinutes,
    Object? nextPullAt = _sentinel,
    Object? lastPullStartedAt = _sentinel,
    Object? lastPullSucceededAt = _sentinel,
    Object? successBanner = _sentinel,
    List<JobSyncErrorLog>? errors,
    List<TrackedJob>? jobs,
  }) {
    return JobSyncState(
      isRunning: isRunning ?? this.isRunning,
      isPulling: isPulling ?? this.isPulling,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
      nextPullAt: nextPullAt == _sentinel
          ? this.nextPullAt
          : nextPullAt as DateTime?,
      lastPullStartedAt: lastPullStartedAt == _sentinel
          ? this.lastPullStartedAt
          : lastPullStartedAt as DateTime?,
      lastPullSucceededAt: lastPullSucceededAt == _sentinel
          ? this.lastPullSucceededAt
          : lastPullSucceededAt as DateTime?,
      successBanner: successBanner == _sentinel
          ? this.successBanner
          : successBanner as JobSyncSuccessBanner?,
      errors: errors ?? this.errors,
      jobs: jobs ?? this.jobs,
    );
  }
}

class JobSyncSuccessBanner {
  const JobSyncSuccessBanner({required this.message, required this.shownAt});

  final String message;
  final DateTime shownAt;
}

class JobSyncErrorLog {
  const JobSyncErrorLog({
    required this.happenedAt,
    required this.type,
    required this.message,
    required this.stackTrace,
  });

  final DateTime happenedAt;
  final String type;
  final String message;
  final String stackTrace;
}

class TrackedJob {
  const TrackedJob({
    required this.job,
    required this.firstSeenAt,
    required this.estimatedPostedAt,
    required this.lastSeenAt,
  });

  final JobInfo job;
  final DateTime firstSeenAt;
  final DateTime estimatedPostedAt;
  final DateTime lastSeenAt;

  String get uniqueKey => '${job.id}::${job.subId ?? ''}';

  Duration ageAt(DateTime now) {
    final duration = now.difference(estimatedPostedAt);
    if (duration.isNegative) {
      return Duration.zero;
    }

    return duration;
  }

  TrackedJob copyWith({
    JobInfo? job,
    DateTime? firstSeenAt,
    DateTime? estimatedPostedAt,
    DateTime? lastSeenAt,
  }) {
    return TrackedJob(
      job: job ?? this.job,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      estimatedPostedAt: estimatedPostedAt ?? this.estimatedPostedAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}

const Object _sentinel = Object();
