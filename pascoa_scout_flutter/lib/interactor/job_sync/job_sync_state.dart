import 'package:pascoa_scout_client/pascoa_scout_client.dart';

class JobSyncState {
  const JobSyncState({
    required this.isBusy,
    required this.overview,
    required this.errors,
    required this.jobs,
  });

  factory JobSyncState.initial() {
    return const JobSyncState(
      isBusy: true,
      overview: null,
      errors: <JobSyncErrorLog>[],
      jobs: <TrackedJob>[],
    );
  }

  final bool isBusy;
  final JobAutomationOverview? overview;
  final List<JobSyncErrorLog> errors;
  final List<TrackedJob> jobs;

  JobAutomationSettings? get settings => overview?.settings;
  JobAutomationRuntime? get runtime => overview?.runtime;

  bool get isRunning => overview?.isLoopActive ?? false;
  bool get isPulling => currentStep == JobAutomationStep.fetchingJobs;
  bool get isLocked => isBusy || isRunning;

  int get intervalMinutes => settings?.loopDelayMinutes ?? 5;
  int get scoreBatchSize => settings?.scoreBatchSize ?? 20;
  int get proposalBatchSize => settings?.proposalBatchSize ?? 20;
  int get upworkSyncResultsPerPage => settings?.upworkSyncResultsPerPage ?? 20;
  int get proposalMinimumScorePercentage =>
      settings?.proposalMinimumScorePercentage ?? 70;
  JobAutomationAiModel get aiModel =>
      settings?.aiModel ?? JobAutomationAiModel.gpt54;
  JobAutomationAiThinkingEffort get aiThinkingEffort =>
      settings?.aiThinkingEffort ?? JobAutomationAiThinkingEffort.xhigh;

  JobAutomationStep get currentStep =>
      runtime?.currentStep ?? JobAutomationStep.idle;
  DateTime? get currentStepStartedAt => runtime?.currentStepStartedAt;
  DateTime? get nextPullAt => null;
  DateTime? get lastPullStartedAt =>
      isPulling ? runtime?.currentStepStartedAt : null;
  DateTime? get lastPullSucceededAt => runtime?.lastSuccessfulJobSyncAt;

  JobSyncState copyWith({
    bool? isBusy,
    Object? overview = _sentinel,
    List<JobSyncErrorLog>? errors,
    List<TrackedJob>? jobs,
  }) {
    return JobSyncState(
      isBusy: isBusy ?? this.isBusy,
      overview: overview == _sentinel
          ? this.overview
          : overview as JobAutomationOverview?,
      errors: errors ?? this.errors,
      jobs: jobs ?? this.jobs,
    );
  }
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

  String get uniqueKey => '${job.upworkId}::${job.subId ?? ''}';

  Duration ageAt(DateTime now) {
    final duration = now.difference(estimatedPostedAt);
    return duration.isNegative ? Duration.zero : duration;
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
