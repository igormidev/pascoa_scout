import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../generated/protocol.dart';
import '../services/job_ai_generation_service.dart';
import '../services/job_automation_loop_scheduler.dart';
import '../services/job_automation_service.dart';

class JobAutomationScoreFutureCall extends FutureCall {
  JobAutomationScoreFutureCall({
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

    await _automationService.setCurrentStep(
      session,
      JobAutomationStep.generatingScores,
    );
    final generationResult = await _generationService.generateMissingScores(
      session,
      limit: settings.scoreBatchSize,
    );
    await generationResult.fold(
      (_) => _automationService.markScoringSuccess(session),
      (error) => _automationService.markError(session, message: error.message),
    );

    await _scheduler.reschedule(
      session,
      callName: jobAutomationProposalFutureCallName,
      identifier: jobAutomationProposalFutureCallIdentifier,
      delay: Duration(minutes: settings.loopDelayMinutes),
    );
  }
}
