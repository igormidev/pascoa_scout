import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import 'job_analysis_query_service.dart';
import 'job_automation_service.dart';

class JobAnalysisAiGenerationContext {
  const JobAnalysisAiGenerationContext({
    required this.analysis,
    required this.aiModel,
    required this.aiThinkingEffort,
  });

  final JobAnalysisState analysis;
  final JobAutomationAiModel aiModel;
  final JobAutomationAiThinkingEffort aiThinkingEffort;
}

mixin JobAnalysisAiGenerationContextMixin {
  JobAnalysisQueryService get queryService;
  JobAutomationService get automationService;

  Future<PascoaResult<JobAnalysisAiGenerationContext>> loadAiGenerationContext(
    Session session, {
    required int jobAnalysisStateId,
  }) async {
    final settingsResult = await automationService.getOrCreateSettings(session);
    final settings = settingsResult.fold<JobAutomationSettings?>(
      (value) => value,
      (_) => null,
    );
    if (settings == null) {
      final error = settingsResult.fold<PascoaException?>(
        (_) => null,
        (failure) => failure,
      );
      return Failure(error!);
    }

    final analysisResult = await queryService.getById(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    final analysis = analysisResult.fold<JobAnalysisState?>(
      (value) => value,
      (_) => null,
    );
    if (analysis == null) {
      final error = analysisResult.fold<PascoaException?>(
        (_) => null,
        (failure) => failure,
      );
      return Failure(error!);
    }

    return Success(
      JobAnalysisAiGenerationContext(
        analysis: analysis,
        aiModel: settings.aiModel ?? JobAutomationAiModel.gpt54,
        aiThinkingEffort:
            settings.aiThinkingEffort ?? JobAutomationAiThinkingEffort.xhigh,
      ),
    );
  }

  Future<PascoaResult<JobAnalysisState>> reloadAnalysisAfterGeneration(
    Session session, {
    required int jobAnalysisStateId,
    required String missingMessage,
    required String missingDescription,
  }) async {
    final result = await queryService.getById(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    final analysis = result.fold<JobAnalysisState?>(
      (value) => value,
      (_) => null,
    );
    if (analysis == null) {
      return Failure(
        PascoaException(
          message: missingMessage,
          description: missingDescription,
        ),
      );
    }

    return Success(analysis);
  }

  Future<PascoaResult<JobAnalysisState>>
  runGenerationAndReload<T extends Object>(
    Session session, {
    required int jobAnalysisStateId,
    required Future<PascoaResult<T>> Function(
      JobAnalysisAiGenerationContext context,
    )
    runGeneration,
    required String missingMessage,
    required String missingDescription,
  }) async {
    final contextResult = await loadAiGenerationContext(
      session,
      jobAnalysisStateId: jobAnalysisStateId,
    );
    return await contextResult.fold(
      (context) async {
        final generationResult = await runGeneration(context);
        return await generationResult.fold(
          (_) async => reloadAnalysisAfterGeneration(
            session,
            jobAnalysisStateId: jobAnalysisStateId,
            missingMessage: missingMessage,
            missingDescription: missingDescription,
          ),
          (error) async => Failure(error),
        );
      },
      (error) async => Failure(error),
    );
  }
}
