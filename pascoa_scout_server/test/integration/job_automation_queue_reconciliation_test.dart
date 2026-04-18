import 'package:pascoa_scout_server/src/core/job_automation_constants.dart';
import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:pascoa_scout_server/src/services/job_automation_loop_scheduler.dart';
import 'package:pascoa_scout_server/src/services/job_automation_service.dart';
import 'package:pascoa_scout_server/src/services/job_automation_startup_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('JobAutomation queue reconciliation', (
    sessionBuilder,
    endpoints,
  ) {
    test('pausing removes every scheduled automation future call', () async {
      final session = sessionBuilder.build();
      final service = JobAutomationService();
      final scheduler = JobAutomationLoopScheduler();
      final settingsResult = await service.getOrCreateSettings(session);
      final settings = settingsResult.fold(
        (value) => value,
        (error) => throw error,
      );

      await JobAutomationSettings.db.updateRow(
        session,
        settings.copyWith(isJobFetchingPaused: false),
      );
      await _scheduleAllAutomationFutureCalls(scheduler, session);

      final overview = await endpoints.jobAutomation.setJobFetchingPaused(
        sessionBuilder,
        isPaused: true,
      );

      expect(await _countAutomationFutureCalls(session), 0);
      expect(overview.settings.isJobFetchingPaused, isTrue);
      expect(overview.runtime.currentStep, JobAutomationStep.pausedWaiting);
      expect(overview.isLoopActive, isFalse);
    });

    test(
      'startup reconciliation keeps the queue empty when automation is paused',
      () async {
        final session = sessionBuilder.build();
        final service = JobAutomationService();
        final scheduler = JobAutomationLoopScheduler();
        final startupService = JobAutomationStartupService();
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

        await JobAutomationSettings.db.updateRow(
          session,
          settings.copyWith(isJobFetchingPaused: true),
        );
        await JobAutomationRuntime.db.updateRow(
          session,
          runtime.copyWith(
            currentStep: JobAutomationStep.generatingProposals,
            currentStepStartedAt: DateTime.utc(2026, 4, 17, 23),
            updatedAt: DateTime.utc(2026, 4, 17, 23),
          ),
        );
        await _scheduleAllAutomationFutureCalls(scheduler, session);

        final result = await startupService.reconcileAfterStartup(session);
        final overview = result.fold((value) => value, (error) => throw error);

        expect(await _countAutomationFutureCalls(session), 0);
        expect(overview.settings.isJobFetchingPaused, isTrue);
        expect(overview.runtime.currentStep, JobAutomationStep.pausedWaiting);
        expect(overview.isLoopActive, isFalse);
      },
    );

    test(
      'startup reconciliation replaces stale queued work with a single sync step when automation is unpaused',
      () async {
        final session = sessionBuilder.build();
        final service = JobAutomationService();
        final scheduler = JobAutomationLoopScheduler();
        final startupService = JobAutomationStartupService();
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

        await JobAutomationSettings.db.updateRow(
          session,
          settings.copyWith(isJobFetchingPaused: false),
        );
        await JobAutomationRuntime.db.updateRow(
          session,
          runtime.copyWith(
            currentStep: JobAutomationStep.generatingScores,
            currentStepStartedAt: DateTime.utc(2026, 4, 17, 23),
            updatedAt: DateTime.utc(2026, 4, 17, 23),
          ),
        );
        await _scheduleAllAutomationFutureCalls(scheduler, session);

        final result = await startupService.reconcileAfterStartup(session);
        final overview = result.fold((value) => value, (error) => throw error);

        expect(await _countAutomationFutureCalls(session), 1);
        expect(
          await _scheduledAutomationIdentifiers(session),
          <String>[jobAutomationSyncFutureCallIdentifier],
        );
        expect(overview.settings.isJobFetchingPaused, isFalse);
        expect(overview.runtime.currentStep, JobAutomationStep.idle);
        expect(overview.isLoopActive, isTrue);
      },
    );
  });
}

Future<void> _scheduleAllAutomationFutureCalls(
  JobAutomationLoopScheduler scheduler,
  Session session,
) async {
  await scheduler.reschedule(
    session,
    callName: jobAutomationSyncFutureCallName,
    identifier: jobAutomationSyncFutureCallIdentifier,
    delay: const Duration(minutes: 5),
  );
  await scheduler.reschedule(
    session,
    callName: jobAutomationScoreFutureCallName,
    identifier: jobAutomationScoreFutureCallIdentifier,
    delay: const Duration(minutes: 5),
  );
  await scheduler.reschedule(
    session,
    callName: jobAutomationProposalFutureCallName,
    identifier: jobAutomationProposalFutureCallIdentifier,
    delay: const Duration(minutes: 5),
  );
}

Future<int> _countAutomationFutureCalls(Session session) async {
  final rows = await session.db.unsafeQuery(
    '''
    SELECT COUNT(*)::int
    FROM serverpod_future_call
    WHERE identifier IN (
      @syncIdentifier,
      @scoreIdentifier,
      @proposalIdentifier
    )
    ''',
    parameters: QueryParameters.named({
      'syncIdentifier': jobAutomationSyncFutureCallIdentifier,
      'scoreIdentifier': jobAutomationScoreFutureCallIdentifier,
      'proposalIdentifier': jobAutomationProposalFutureCallIdentifier,
    }),
  );

  return rows.first[0] as int;
}

Future<List<String>> _scheduledAutomationIdentifiers(Session session) async {
  final rows = await session.db.unsafeQuery(
    '''
    SELECT identifier
    FROM serverpod_future_call
    WHERE identifier IN (
      @syncIdentifier,
      @scoreIdentifier,
      @proposalIdentifier
    )
    ORDER BY identifier ASC
    ''',
    parameters: QueryParameters.named({
      'syncIdentifier': jobAutomationSyncFutureCallIdentifier,
      'scoreIdentifier': jobAutomationScoreFutureCallIdentifier,
      'proposalIdentifier': jobAutomationProposalFutureCallIdentifier,
    }),
  );

  return [
    for (final row in rows) row[0] as String,
  ];
}
