import 'package:pascoa_scout_server/src/core/job_automation_constants.dart';
import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:pascoa_scout_server/src/services/job_automation_loop_scheduler.dart';
import 'package:pascoa_scout_server/src/services/job_automation_service.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('JobAutomationService', (sessionBuilder, _) {
    test(
      'reports the loop as inactive when it is unpaused but no work is queued',
      () async {
        final session = sessionBuilder.build();
        final service = JobAutomationService();
        final settingsResult = await service.getOrCreateSettings(session);
        final settings = settingsResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final runtimeResult = await service.getOrCreateRuntime(session);
        final runtime = runtimeResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final now = DateTime.utc(2026, 4, 8, 12);

        await JobAutomationSettings.db.updateRow(
          session,
          settings.copyWith(isJobFetchingPaused: false),
        );
        await JobAutomationRuntime.db.updateRow(
          session,
          runtime.copyWith(
            currentStep: JobAutomationStep.pausedWaiting,
            currentStepStartedAt: now,
            updatedAt: now,
          ),
        );

        final overviewResult = await service.getOverview(session);
        final overview = overviewResult.fold(
          (value) => value,
          (error) => throw error,
        );

        expect(overview.isLoopActive, isFalse);
      },
    );

    test(
      'reports the loop as active when a future call is queued for the next cycle',
      () async {
        final session = sessionBuilder.build();
        final service = JobAutomationService();
        final scheduler = JobAutomationLoopScheduler();
        final settingsResult = await service.getOrCreateSettings(session);
        final settings = settingsResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final runtimeResult = await service.getOrCreateRuntime(session);
        final runtime = runtimeResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final now = DateTime.utc(2026, 4, 8, 12);

        await JobAutomationSettings.db.updateRow(
          session,
          settings.copyWith(isJobFetchingPaused: false),
        );
        await JobAutomationRuntime.db.updateRow(
          session,
          runtime.copyWith(
            currentStep: JobAutomationStep.pausedWaiting,
            currentStepStartedAt: now,
            updatedAt: now,
          ),
        );
        await scheduler.reschedule(
          session,
          callName: jobAutomationSyncFutureCallName,
          identifier: jobAutomationSyncFutureCallIdentifier,
          delay: const Duration(minutes: 10),
        );

        final overviewResult = await service.getOverview(session);
        final overview = overviewResult.fold(
          (value) => value,
          (error) => throw error,
        );

        expect(overview.isLoopActive, isTrue);
      },
    );

    test(
      'reports the loop as active while a step is running even without a queued future call',
      () async {
        final session = sessionBuilder.build();
        final service = JobAutomationService();
        final settingsResult = await service.getOrCreateSettings(session);
        final settings = settingsResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final runtimeResult = await service.getOrCreateRuntime(session);
        final runtime = runtimeResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final now = DateTime.utc(2026, 4, 8, 12);

        await JobAutomationSettings.db.updateRow(
          session,
          settings.copyWith(isJobFetchingPaused: false),
        );
        await JobAutomationRuntime.db.updateRow(
          session,
          runtime.copyWith(
            currentStep: JobAutomationStep.generatingScores,
            currentStepStartedAt: now,
            updatedAt: now,
          ),
        );

        final overviewResult = await service.getOverview(session);
        final overview = overviewResult.fold(
          (value) => value,
          (error) => throw error,
        );

        expect(overview.isLoopActive, isTrue);
      },
    );
  });
}
