import 'package:serverpod/serverpod.dart';

import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import 'job_ai_generation_service.dart';
import 'job_analysis_ai_generation_context_mixin.dart';
import 'job_analysis_query_service.dart';
import 'job_automation_service.dart';

class JobAnalysisAiRefreshService with JobAnalysisAiGenerationContextMixin {
  const JobAnalysisAiRefreshService({
    JobAnalysisQueryService? queryService,
    JobAiGenerationService? generationService,
    JobAutomationService? automationService,
  }) : _queryService = queryService ?? const JobAnalysisQueryService(),
       _generationService = generationService ?? const JobAiGenerationService(),
       _automationService = automationService ?? const JobAutomationService();

  final JobAnalysisQueryService _queryService;
  final JobAiGenerationService _generationService;
  final JobAutomationService _automationService;

  @override
  JobAnalysisQueryService get queryService => _queryService;

  @override
  JobAutomationService get automationService => _automationService;

  Future<PascoaResult<JobAnalysisState>> regenerateCoverLetter(
    Session session, {
    required int jobAnalysisStateId,
  }) {
    return runGenerationAndReload(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
      runGeneration: (context) =>
          _generationService.generateProposalCoverLetterForAnalysis(
            session,
            analysis: context.analysis,
            aiModel: context.aiModel,
            aiThinkingEffort: context.aiThinkingEffort,
            runLabel: 'mode=refresh section=cover-letter',
          ),
      missingMessage: 'Unable to reload the regenerated cover letter',
      missingDescription:
          'The server refreshed the cover letter, but the updated job analysis row could not be reloaded afterwards.',
    );
  }

  Future<PascoaResult<JobAnalysisState>> regenerateAnswer(
    Session session, {
    required int jobAnalysisStateId,
    required int relatedQuestionId,
  }) {
    return runGenerationAndReload(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
      runGeneration: (context) =>
          _generationService.generateProposalAnswerForAnalysis(
            session,
            analysis: context.analysis,
            relatedQuestionId: relatedQuestionId,
            aiModel: context.aiModel,
            aiThinkingEffort: context.aiThinkingEffort,
            runLabel: 'mode=refresh section=answer question=$relatedQuestionId',
          ),
      missingMessage: 'Unable to reload the regenerated answer',
      missingDescription:
          'The server refreshed the question answer, but the updated job analysis row could not be reloaded afterwards.',
    );
  }
}
