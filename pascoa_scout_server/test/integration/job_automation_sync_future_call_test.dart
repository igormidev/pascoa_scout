import 'package:pascoa_scout_server/src/core/job_automation_constants.dart';
import 'package:pascoa_scout_server/src/core/pascoa_result.dart';
import 'package:pascoa_scout_server/src/future_calls/job_automation_sync_future_call.dart';
import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:pascoa_scout_server/src/services/job_automation_loop_scheduler.dart';
import 'package:pascoa_scout_server/src/services/job_automation_service.dart';
import 'package:pascoa_scout_server/src/services/job_upwork_sync_service.dart';
import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('JobAutomationSyncFutureCall', (sessionBuilder, _) {
    test('requeues the next sync cycle when fetching jobs fails', () async {
      final session = sessionBuilder.build();
      final now = DateTime.utc(2026, 4, 18, 0, 40);
      final settings = JobAutomationSettings(
        singletonKey: jobAutomationSingletonKey,
        jobFilter: JobFilter(searchQueryTerm: 'flutter'),
        isJobFetchingPaused: false,
        scoreBatchSize: defaultScoreBatchSize,
        proposalBatchSize: defaultProposalBatchSize,
        upworkSyncResultsPerPage: 5,
        proposalMinimumScorePercentage: defaultProposalMinimumScorePercentage,
        loopDelayMinutes: 7,
        aiModel: JobAutomationAiModel.gpt54,
        aiThinkingEffort: JobAutomationAiThinkingEffort.xhigh,
        updatedAt: now,
      );
      final runtime = JobAutomationRuntime(
        singletonKey: jobAutomationSingletonKey,
        currentStep: JobAutomationStep.idle,
        currentStepStartedAt: now,
        updatedAt: now,
      );
      final automationService = _FakeJobAutomationService(
        settings: settings,
        runtime: runtime,
      );
      final scheduler = _CapturingJobAutomationLoopScheduler();
      final futureCall = JobAutomationSyncFutureCall(
        automationService: automationService,
        scheduler: scheduler,
        syncService: const _FailingJobUpworkSyncService(),
      );

      await futureCall.invoke(session, null);

      expect(
        automationService.stepUpdates,
        <JobAutomationStep>[JobAutomationStep.fetchingJobs],
      );
      expect(
        automationService.markedError?.message,
        'Failed to fetch Upwork jobs from Apify',
      );
      expect(automationService.publishOverviewCallCount, 1);
      expect(automationService.runtime.currentStep, JobAutomationStep.error);
      expect(scheduler.rescheduleCallCount, 1);
      expect(scheduler.callName, jobAutomationSyncFutureCallName);
      expect(scheduler.identifier, jobAutomationSyncFutureCallIdentifier);
      expect(scheduler.delay, const Duration(minutes: 7));
    });
  });
}

class _FailingJobUpworkSyncService extends JobUpworkSyncService {
  const _FailingJobUpworkSyncService();

  @override
  Future<PascoaResult<int>> syncLatestJobs(
    Session session, {
    required JobFilter filter,
    required int resultsPerPage,
  }) async {
    return Failure(
      PascoaException(
        message: 'Failed to fetch Upwork jobs from Apify',
        description:
            'The provider request failed and the automation loop should retry later.',
      ),
    );
  }
}

class _CapturingJobAutomationLoopScheduler extends JobAutomationLoopScheduler {
  int rescheduleCallCount = 0;
  String? callName;
  String? identifier;
  Duration? delay;

  @override
  Future<void> reschedule(
    Session session, {
    required String callName,
    required String identifier,
    required Duration delay,
  }) async {
    rescheduleCallCount += 1;
    this.callName = callName;
    this.identifier = identifier;
    this.delay = delay;
  }
}

class _FakeJobAutomationService extends JobAutomationService {
  _FakeJobAutomationService({
    required this.settings,
    required this.runtime,
  });

  final JobAutomationSettings settings;
  JobAutomationRuntime runtime;

  final List<JobAutomationStep> stepUpdates = [];
  PascoaException? markedError;
  int publishOverviewCallCount = 0;

  @override
  Future<PascoaResult<JobAutomationSettings>> getOrCreateSettings(
    Session session,
  ) async {
    return Success(settings);
  }

  @override
  Future<PascoaResult<JobAutomationRuntime>> setCurrentStep(
    Session session,
    JobAutomationStep step,
  ) async {
    stepUpdates.add(step);
    final now = DateTime.now().toUtc();
    runtime = runtime.copyWith(
      currentStep: step,
      currentStepStartedAt: now,
      updatedAt: now,
    );
    return Success(runtime);
  }

  @override
  Future<PascoaResult<JobAutomationRuntime>> markError(
    Session session, {
    required PascoaException error,
  }) async {
    markedError = error;
    final now = DateTime.now().toUtc();
    runtime = runtime.copyWith(
      currentStep: JobAutomationStep.error,
      currentStepStartedAt: now,
      updatedAt: now,
      lastErrorMessage: error.message,
      lastError: error,
      lastErrorAt: now,
    );
    return Success(runtime);
  }

  @override
  Future<PascoaResult<JobAutomationOverview>> publishCurrentOverview(
    Session session,
  ) async {
    publishOverviewCallCount += 1;
    return Success(
      JobAutomationOverview(
        settings: settings,
        runtime: runtime,
        isLoopActive: true,
      ),
    );
  }
}
