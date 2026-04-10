import 'package:flutter_test/flutter_test.dart';
import 'package:pascoa_scout/interactor/job_sync/job_sync_state.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';

void main() {
  group('JobSyncState automation semantics', () {
    test(
      'treats paused waiting without a queued loop as idle when the pause flag is false',
      () {
        final state = _buildState(
          isJobFetchingPaused: false,
          currentStep: JobAutomationStep.pausedWaiting,
          isLoopActive: false,
        );

        expect(state.isPaused, isFalse);
        expect(state.shouldShowPauseAction, isFalse);
        expect(state.statusKind, JobAutomationStatusKind.idle);
      },
    );

    test('treats paused waiting as paused when the pause flag is true', () {
      final state = _buildState(
        isJobFetchingPaused: true,
        currentStep: JobAutomationStep.pausedWaiting,
        isLoopActive: false,
      );

      expect(state.isPaused, isTrue);
      expect(state.shouldShowPauseAction, isFalse);
      expect(state.statusKind, JobAutomationStatusKind.paused);
    });

    test('treats paused waiting as queued when the loop is active', () {
      final state = _buildState(
        isJobFetchingPaused: false,
        currentStep: JobAutomationStep.pausedWaiting,
        isLoopActive: true,
      );

      expect(state.isPaused, isFalse);
      expect(state.shouldShowPauseAction, isTrue);
      expect(state.statusKind, JobAutomationStatusKind.waitingNextCycle);
    });
  });
}

JobSyncState _buildState({
  required bool isJobFetchingPaused,
  required JobAutomationStep currentStep,
  required bool isLoopActive,
}) {
  final timestamp = DateTime.utc(2026, 4, 9, 15, 22);
  final filter = JobFilter(searchQueryTerm: 'flutter');
  final settings = JobAutomationSettings(
    singletonKey: 'singleton',
    jobFilter: filter,
    isJobFetchingPaused: isJobFetchingPaused,
    scoreBatchSize: 20,
    proposalBatchSize: 20,
    upworkSyncResultsPerPage: 20,
    proposalMinimumScorePercentage: 70,
    loopDelayMinutes: 5,
    aiModel: JobAutomationAiModel.gpt54,
    aiThinkingEffort: JobAutomationAiThinkingEffort.xhigh,
    updatedAt: timestamp,
  );
  final runtime = JobAutomationRuntime(
    singletonKey: 'singleton',
    currentStep: currentStep,
    currentStepStartedAt: timestamp,
    updatedAt: timestamp,
  );
  final overview = JobAutomationOverview(
    settings: settings,
    runtime: runtime,
    isLoopActive: isLoopActive,
  );

  return JobSyncState(
    isBusy: false,
    overview: overview,
    errors: const <JobSyncErrorLog>[],
    jobs: const <TrackedJob>[],
  );
}
