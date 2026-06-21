import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import 'job_ai_generation_service.dart';
import 'job_automation_service.dart';

class JobAnalysisManualProposalService {
  const JobAnalysisManualProposalService({
    JobAiGenerationService? generationService,
    JobAutomationService? automationService,
  }) : _generationService = generationService ?? const JobAiGenerationService(),
       _automationService = automationService ?? const JobAutomationService();

  final JobAiGenerationService _generationService;
  final JobAutomationService _automationService;

  Future<PascoaResult<ManualJobProposalResult>> generateManualProposal(
    Session session, {
    required ManualJobProposalRequest request,
  }) async {
    final settingsResult = await _automationService.getOrCreateSettings(
      session,
    );

    return await settingsResult.fold(
      (settings) => _generationService.generateManualProposal(
        session,
        request: request,
        aiModel: settings.aiModel ?? JobAutomationAiModel.gpt54,
        aiThinkingEffort:
            settings.aiThinkingEffort ?? JobAutomationAiThinkingEffort.xhigh,
      ),
      (error) async => Failure(error),
    );
  }
}
