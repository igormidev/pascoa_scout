import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/job_automation_logging.dart';
import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import 'job_ai_generation_service.dart';
import 'job_analysis_ai_generation_context_mixin.dart';
import 'job_analysis_query_service.dart';
import 'job_automation_service.dart';

typedef JobAnalysisForceSyncProgressCallback =
    Future<void> Function(JobAnalysisForceSyncProgress progress);

class JobAnalysisForceSyncService with JobAnalysisAiGenerationContextMixin {
  const JobAnalysisForceSyncService({
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

  Future<PascoaResult<JobAnalysisState>> forceSync(
    Session session, {
    required int jobAnalysisStateId,
    required JobAnalysisForceSyncProgressCallback onProgress,
  }) async {
    var progress = _buildDefaultProgress(jobAnalysisStateId);

    Future<void> emit(JobAnalysisForceSyncProgress nextProgress) async {
      progress = nextProgress;
      await onProgress(nextProgress);
    }

    Future<PascoaResult<JobAnalysisState>> fail(
      PascoaException error, {
      JobAnalysisForceSyncProgress? nextProgress,
    }) async {
      final latestAnalysis = await _tryLoadAnalysis(
        session,
        jobAnalysisStateId: jobAnalysisStateId,
      );
      await emit(
        (nextProgress ?? progress).copyWith(
          currentStage: JobAnalysisForceSyncStage.failed,
          errorMessage: error.message,
          analysis: latestAnalysis,
        ),
      );
      return Failure(error);
    }

    final contextResult = await loadAiGenerationContext(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    final context = contextResult.fold<JobAnalysisAiGenerationContext?>(
      (value) => value,
      (_) => null,
    );
    if (context == null) {
      final error = contextResult.fold<PascoaException?>(
        (_) => null,
        (failure) => failure,
      );
      return fail(error!);
    }
    final initialAnalysis = context.analysis;

    final analysisLabel = formatAutomationAnalysisLabel(initialAnalysis);
    final isFixedPriceJob = initialAnalysis.jobInfo?.jobType == JobType.fixed;
    progress = progress.copyWith(
      isFixedPriceJob: isFixedPriceJob,
      milestonesStatus: isFixedPriceJob
          ? JobAnalysisForceSyncStageStatus.pending
          : JobAnalysisForceSyncStageStatus.skipped,
    );

    logAutomationStart(
      session,
      AutomationLogScope.control,
      '$analysisLabel force sync started',
    );
    await emit(progress);

    final aiModel = context.aiModel;
    final aiThinkingEffort = context.aiThinkingEffort;

    await emit(
      progress.copyWith(
        currentStage: JobAnalysisForceSyncStage.score,
        scoreStatus: JobAnalysisForceSyncStageStatus.running,
      ),
    );

    final scoreResult = await _generationService.generateScoreForAnalysis(
      session,
      analysis: initialAnalysis,
      aiModel: aiModel,
      aiThinkingEffort: aiThinkingEffort,
    );
    final scoreFailure = scoreResult.fold<PascoaException?>(
      (_) => null,
      (error) => error,
    );
    if (scoreFailure != null) {
      logAutomationFail(
        session,
        AutomationLogScope.control,
        '$analysisLabel force sync failed | ${scoreFailure.message}',
      );
      return fail(
        scoreFailure,
        nextProgress: progress.copyWith(
          currentStage: JobAnalysisForceSyncStage.score,
          scoreStatus: JobAnalysisForceSyncStageStatus.failed,
        ),
      );
    }

    final scoredAnalysis = await _tryLoadAnalysis(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    if (scoredAnalysis == null) {
      final error = PascoaException(
        message: 'Unable to reload the scored job analysis',
        description:
            'The force-sync flow generated a score, but the updated job analysis row could not be reloaded afterwards.',
      );
      logAutomationFail(
        session,
        AutomationLogScope.control,
        '$analysisLabel force sync failed | ${error.message}',
      );
      return fail(
        error,
        nextProgress: progress.copyWith(
          currentStage: JobAnalysisForceSyncStage.reloadingCard,
          scoreStatus: JobAnalysisForceSyncStageStatus.completed,
        ),
      );
    }

    await emit(
      progress.copyWith(
        currentStage: JobAnalysisForceSyncStage.proposal,
        scoreStatus: JobAnalysisForceSyncStageStatus.completed,
        proposalStatus: JobAnalysisForceSyncStageStatus.running,
        answersStatus: JobAnalysisForceSyncStageStatus.running,
        milestonesStatus: isFixedPriceJob
            ? JobAnalysisForceSyncStageStatus.running
            : JobAnalysisForceSyncStageStatus.skipped,
      ),
    );

    final proposalResult = await _generationService.generateProposalForAnalysis(
      session,
      analysis: scoredAnalysis,
      aiModel: aiModel,
      aiThinkingEffort: aiThinkingEffort,
    );
    final proposalFailure = proposalResult.fold<PascoaException?>(
      (_) => null,
      (error) => error,
    );
    if (proposalFailure != null) {
      logAutomationFail(
        session,
        AutomationLogScope.control,
        '$analysisLabel force sync failed | ${proposalFailure.message}',
      );
      return fail(
        proposalFailure,
        nextProgress: progress.copyWith(
          currentStage: JobAnalysisForceSyncStage.proposal,
          proposalStatus: JobAnalysisForceSyncStageStatus.failed,
          answersStatus: JobAnalysisForceSyncStageStatus.failed,
          milestonesStatus: isFixedPriceJob
              ? JobAnalysisForceSyncStageStatus.failed
              : JobAnalysisForceSyncStageStatus.skipped,
        ),
      );
    }

    await emit(
      progress.copyWith(
        currentStage: JobAnalysisForceSyncStage.reloadingCard,
        proposalStatus: JobAnalysisForceSyncStageStatus.completed,
        answersStatus: JobAnalysisForceSyncStageStatus.completed,
        milestonesStatus: isFixedPriceJob
            ? JobAnalysisForceSyncStageStatus.completed
            : JobAnalysisForceSyncStageStatus.skipped,
      ),
    );

    final finalAnalysis = await _tryLoadAnalysis(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    if (finalAnalysis == null) {
      final error = PascoaException(
        message: 'Unable to reload the completed job analysis',
        description:
            'The force-sync flow finished, but the latest persisted job analysis row could not be loaded afterwards.',
      );
      logAutomationFail(
        session,
        AutomationLogScope.control,
        '$analysisLabel force sync failed | ${error.message}',
      );
      return fail(error);
    }

    await emit(
      progress.copyWith(
        currentStage: JobAnalysisForceSyncStage.completed,
        analysis: finalAnalysis,
        errorMessage: null,
      ),
    );
    logAutomationDone(
      session,
      AutomationLogScope.control,
      '$analysisLabel force sync finished',
    );
    return Success(finalAnalysis);
  }

  JobAnalysisForceSyncProgress _buildDefaultProgress(int jobAnalysisStateId) {
    return JobAnalysisForceSyncProgress(
      jobAnalysisStateId: jobAnalysisStateId,
      currentStage: JobAnalysisForceSyncStage.preparing,
      isFixedPriceJob: false,
      scoreStatus: JobAnalysisForceSyncStageStatus.pending,
      proposalStatus: JobAnalysisForceSyncStageStatus.pending,
      answersStatus: JobAnalysisForceSyncStageStatus.pending,
      milestonesStatus: JobAnalysisForceSyncStageStatus.pending,
    );
  }

  Future<JobAnalysisState?> _tryLoadAnalysis(
    Session session, {
    required int jobAnalysisStateId,
  }) async {
    final result = await _queryService.getById(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    return result.fold((analysis) => analysis, (_) => null);
  }
}
