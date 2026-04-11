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
      logAutomationDone(
        session,
        AutomationLogScope.proposal,
        'step proposal skipped | reason=paused',
      );
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
    logAutomationStart(
      session,
      AutomationLogScope.proposal,
      'step proposal started | limit=${settings.proposalBatchSize} minScore=${settings.proposalMinimumScorePercentage} concurrency=$maxConcurrentAiExecutions model=${(settings.aiModel ?? JobAutomationAiModel.gpt54).name} effort=${(settings.aiThinkingEffort ?? JobAutomationAiThinkingEffort.xhigh).name}',
    );
    final generationResult = await _generationService.generateMissingProposals(
      session,
      limit: settings.proposalBatchSize,
      minimumScorePercentage: settings.proposalMinimumScorePercentage,
      aiModel: settings.aiModel ?? JobAutomationAiModel.gpt54,
      aiThinkingEffort:
          settings.aiThinkingEffort ?? JobAutomationAiThinkingEffort.xhigh,
    );
    final generatedCount = await generationResult.fold(
      (count) async {
        await _automationService.markProposalSuccess(session);
        return count;
      },
      (error) async {
        logAutomationFail(
          session,
          AutomationLogScope.proposal,
          'step proposal failed | ${error.message}',
        );
        await _automationService.markError(session, message: error.message);
        return null;
      },
    );
    if (generatedCount == null) {
      return;
    }

    final latestSettingsResult = await _automationService.getOrCreateSettings(
      session,
    );
    final latestSettings = latestSettingsResult.fold(
      (value) => value,
      (error) => throw error,
    );
    if (latestSettings.isJobFetchingPaused) {
      logAutomationDone(
        session,
        AutomationLogScope.proposal,
        'step proposal finished | generated=$generatedCount next=none reason=paused',
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
    logAutomationDone(
      session,
      AutomationLogScope.proposal,
      'step proposal finished | generated=$generatedCount next=sync delay=${latestSettings.loopDelayMinutes}m',
    );
    logAutomationStart(
      session,
      AutomationLogScope.loop,
      'sync step queued | delay=${latestSettings.loopDelayMinutes}m',
    );
  }
}
