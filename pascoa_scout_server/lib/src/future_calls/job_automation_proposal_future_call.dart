import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../core/job_automation_logging.dart';
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
      logAutomation(session, 'proposal', 'skipped: job fetching is paused');
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
    logAutomation(
      session,
      'proposal',
      'starting batch (limit=${settings.proposalBatchSize}, minScore=${settings.proposalMinimumScorePercentage}, model=${(settings.aiModel ?? JobAutomationAiModel.gpt54).name}, effort=${(settings.aiThinkingEffort ?? JobAutomationAiThinkingEffort.xhigh).name})',
    );
    final generationResult = await _generationService.generateMissingProposals(
      session,
      limit: settings.proposalBatchSize,
      minimumScorePercentage: settings.proposalMinimumScorePercentage,
      aiModel: settings.aiModel ?? JobAutomationAiModel.gpt54,
      aiThinkingEffort:
          settings.aiThinkingEffort ?? JobAutomationAiThinkingEffort.xhigh,
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
      logAutomation(
        session,
        'proposal',
        'paused after proposal generation; next step not queued',
      );
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
    logAutomation(
      session,
      'loop',
      'queued sync step in ${latestSettings.loopDelayMinutes} minute(s)',
    );
  }
}
