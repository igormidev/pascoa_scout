import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../generated/protocol.dart';
import '../services/job_ai_generation_service.dart';
import '../services/job_automation_loop_scheduler.dart';
import '../services/job_automation_service.dart';

class JobAutomationProposalFutureCall extends FutureCall {
  JobAutomationProposalFutureCall({
    JobAutomationService? automationService,
    JobAutomationLoopScheduler? scheduler,
    JobAiGenerationService? generationService,
  }) : _automationService = automationService ?? const JobAutomationService(),
       _scheduler = scheduler ?? const JobAutomationLoopScheduler(),
       _generationService = generationService ?? const JobAiGenerationService();

  final JobAutomationService _automationService;
  final JobAutomationLoopScheduler _scheduler;
  final JobAiGenerationService _generationService;

  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    final settingsResult = await _automationService.getOrCreateSettings(
      session,
    );
    final settings = settingsResult.fold(
      (value) => value,
      (error) => throw error,
    );

    if (settings.isJobFetchingPaused) {
      await _automationService.setCurrentStep(
        session,
        JobAutomationStep.pausedWaiting,
      );
      return;
    }

    await _automationService.setCurrentStep(
      session,
      JobAutomationStep.generatingProposals,
    );
    final generationResult = await _generationService.generateMissingProposals(
      session,
      limit: settings.proposalBatchSize,
      minimumScorePercentage: settings.proposalMinimumScorePercentage,
    );
    await generationResult.fold(
      (_) => _automationService.markProposalSuccess(session),
      (error) => _automationService.markError(session, message: error.message),
    );

    final latestSettingsResult = await _automationService.getOrCreateSettings(
      session,
    );
    final latestSettings = latestSettingsResult.fold(
      (value) => value,
      (error) => throw error,
    );
    if (latestSettings.isJobFetchingPaused) {
      await _automationService.setCurrentStep(
        session,
        JobAutomationStep.pausedWaiting,
      );
      return;
    }

    await _scheduler.reschedule(
      session,
      callName: jobAutomationSyncFutureCallName,
      identifier: jobAutomationSyncFutureCallIdentifier,
      delay: Duration(minutes: latestSettings.loopDelayMinutes),
    );
  }
}
