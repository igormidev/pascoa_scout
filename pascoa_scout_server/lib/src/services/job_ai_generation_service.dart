import 'dart:convert';
import 'dart:io';

import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
import '../core/job_automation_logging.dart';
import '../core/pascoa_result.dart';
import '../generated/protocol.dart';
import 'job_ai_orchestrator.dart';
import 'job_analysis_include.dart';
import 'job_codex_service.dart';
import 'job_knowledge_service.dart';

class JobAiGenerationService {
  const JobAiGenerationService({
    JobCodexService? codexService,
    JobKnowledgeService? knowledgeService,
    JobAiOrchestrator? orchestrator,
  }) : _codexService = codexService ?? const JobCodexService(),
       _knowledgeService = knowledgeService ?? const JobKnowledgeService(),
       _orchestrator = orchestrator ?? const JobAiOrchestrator();

  final JobCodexService _codexService;
  final JobKnowledgeService _knowledgeService;
  final JobAiOrchestrator _orchestrator;

  Future<PascoaResult<JobScoreGenerationSummary>> generateScoreForAnalysis(
    Session session, {
    required JobAnalysisState analysis,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
    String runLabel = 'mode=force',
  }) async {
    final knowledgeResult = await _knowledgeService.getKnowledgeBundle(session);
    return await knowledgeResult.fold(
      (knowledge) async => _generateScoreForAnalysis(
        session,
        session,
        analysis,
        knowledge,
        aiModel,
        aiThinkingEffort,
        runLabel: runLabel,
      ),
      (error) async => Failure(error),
    );
  }

  Future<PascoaResult<JobProposalGenerationSummary>>
  generateProposalForAnalysis(
    Session session, {
    required JobAnalysisState analysis,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
    String runLabel = 'mode=force',
  }) async {
    final knowledgeResult = await _knowledgeService.getKnowledgeBundle(session);
    return await knowledgeResult.fold(
      (knowledge) async => _generateProposalForAnalysis(
        session,
        session,
        analysis,
        knowledge,
        aiModel,
        aiThinkingEffort,
        runLabel: runLabel,
      ),
      (error) async => Failure(error),
    );
  }

  Future<PascoaResult<JobProposalGenerationSummary>>
  generateProposalCoverLetterForAnalysis(
    Session session, {
    required JobAnalysisState analysis,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
    String runLabel = 'mode=force section=cover-letter',
  }) async {
    final knowledgeResult = await _knowledgeService.getKnowledgeBundle(session);
    return await knowledgeResult.fold(
      (knowledge) async => _generateProposalCoverLetterForAnalysis(
        session,
        session,
        analysis,
        knowledge,
        aiModel,
        aiThinkingEffort,
        runLabel: runLabel,
      ),
      (error) async => Failure(error),
    );
  }

  Future<PascoaResult<JobProposalGenerationSummary>>
  generateProposalAnswerForAnalysis(
    Session session, {
    required JobAnalysisState analysis,
    required int relatedQuestionId,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
    String runLabel = 'mode=force section=answer',
  }) async {
    final knowledgeResult = await _knowledgeService.getKnowledgeBundle(session);
    return await knowledgeResult.fold(
      (knowledge) async => _generateProposalAnswerForAnalysis(
        session,
        session,
        analysis,
        knowledge,
        relatedQuestionId,
        aiModel,
        aiThinkingEffort,
        runLabel: runLabel,
      ),
      (error) async => Failure(error),
    );
  }

  Future<PascoaResult<int>> generateMissingScores(
    Session session, {
    required int limit,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
  }) async {
    if (limit < 1) {
      return Success(0);
    }

    final knowledgeResult = await _knowledgeService.getKnowledgeBundle(session);
    return await knowledgeResult.fold(
      (knowledge) async {
        try {
          final candidates = await JobAnalysisState.db.find(
            session,
            where: (table) => table.score.id.equals(null),
            orderBy: (table) => table.createdJobInfoAt,
            orderDescending: true,
            limit: limit,
            include: buildJobAnalysisStateInclude(),
          );
          if (candidates.isEmpty) {
            logAutomationDone(
              session,
              AutomationLogScope.score,
              'batch skipped | no score candidates',
            );
            return Success(0);
          }
          logAutomationStart(
            session,
            AutomationLogScope.score,
            'batch queued | jobs=${candidates.length} concurrency=$maxConcurrentAiExecutions',
          );

          final results = await _orchestrator.runQueued(
            [
              for (var index = 0; index < candidates.length; index++)
                () => _withTaskSession<JobScoreGenerationSummary>(
                  session,
                  (taskSession) => _generateScoreForAnalysis(
                    taskSession,
                    session,
                    candidates[index],
                    knowledge,
                    aiModel,
                    aiThinkingEffort,
                    runLabel: 'queue=${index + 1}/${candidates.length}',
                  ),
                ),
            ],
            concurrency: maxConcurrentAiExecutions,
          );

          var successCount = 0;
          for (final result in results) {
            result.fold((_) => successCount += 1, (_) {});
          }
          logAutomationDone(
            session,
            AutomationLogScope.score,
            'batch finished | generated=$successCount/${results.length}',
          );
          return Success(successCount);
        } catch (error, stackTrace) {
          return Failure(
            PascoaException(
              message: 'Unable to generate missing job scores',
              description:
                  'The server could not process the batch of score generations.',
              error: error.toString(),
              stackTrace: stackTrace.toString(),
            ),
          );
        }
      },
      (error) async => Failure(error),
    );
  }

  Future<PascoaResult<int>> generateMissingProposals(
    Session session, {
    required int limit,
    required int minimumScorePercentage,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
  }) async {
    if (limit < 1) {
      return Success(0);
    }

    final knowledgeResult = await _knowledgeService.getKnowledgeBundle(session);
    return await knowledgeResult.fold(
      (knowledge) async {
        try {
          final candidates = await JobAnalysisState.db.find(
            session,
            where: (table) =>
                table.proposal.id.equals(null) &
                table.score.id.notEquals(null) &
                (table.score.scorePercentage >= minimumScorePercentage),
            orderBy: (table) => table.score.scorePercentage,
            orderDescending: true,
            limit: limit,
            include: buildJobAnalysisStateInclude(),
          );
          if (candidates.isEmpty) {
            logAutomationDone(
              session,
              AutomationLogScope.proposal,
              'batch skipped | no proposal candidates',
            );
            return Success(0);
          }
          logAutomationStart(
            session,
            AutomationLogScope.proposal,
            'batch queued | jobs=${candidates.length} concurrency=$maxConcurrentAiExecutions minScore=$minimumScorePercentage',
          );

          final results = await _orchestrator.runQueued(
            [
              for (var index = 0; index < candidates.length; index++)
                () => _withTaskSession<JobProposalGenerationSummary>(
                  session,
                  (taskSession) => _generateProposalForAnalysis(
                    taskSession,
                    session,
                    candidates[index],
                    knowledge,
                    aiModel,
                    aiThinkingEffort,
                    runLabel: 'queue=${index + 1}/${candidates.length}',
                  ),
                ),
            ],
            concurrency: maxConcurrentAiExecutions,
          );

          var successCount = 0;
          for (final result in results) {
            result.fold((_) => successCount += 1, (_) {});
          }
          logAutomationDone(
            session,
            AutomationLogScope.proposal,
            'batch finished | generated=$successCount/${results.length}',
          );
          return Success(successCount);
        } catch (error, stackTrace) {
          return Failure(
            PascoaException(
              message: 'Unable to generate missing proposals',
              description:
                  'The server could not process the batch of proposal generations.',
              error: error.toString(),
              stackTrace: stackTrace.toString(),
            ),
          );
        }
      },
      (error) async => Failure(error),
    );
  }

  Future<PascoaResult<JobScoreGenerationSummary>> _generateScoreForAnalysis(
    Session session,
    Session logSession,
    JobAnalysisState analysis,
    JobKnowledgeBundle knowledge,
    JobAutomationAiModel aiModel,
    JobAutomationAiThinkingEffort aiThinkingEffort, {
    required String runLabel,
  }) async {
    final validationError = _validateAnalysis(analysis);
    final analysisLabel = formatAutomationAnalysisLabel(analysis);
    if (validationError != null) {
      logAutomationFail(
        logSession,
        AutomationLogScope.score,
        '$analysisLabel $runLabel failed | ${validationError.message}',
      );
      return Failure(validationError);
    }

    logAutomationStart(
      logSession,
      AutomationLogScope.score,
      '$analysisLabel $runLabel started',
    );

    try {
      final workDirectory = await _prepareWorkDirectory(
        analysisId: analysis.id!,
        stageDirectoryName: 'score',
      );
      final jobFile = await _writeJobContextFile(
        workDirectory: workDirectory,
        analysis: analysis,
        includeScore: false,
      );
      final curriculumFile = await _writeFile(
        workDirectory,
        'curriculum.md',
        knowledge.curriculum.markdownText,
      );
      final opportunityFile = await _writeFile(
        workDirectory,
        'job-opportunity-preference.md',
        knowledge.opportunityPreference.markdownText,
      );

      final prompt =
          '''
You are evaluating whether an Upwork job is a strong fit for the freelancer.

Before responding, read these files completely and do not continue until you have read them all:
- @${curriculumFile.path.split('/').last}
- @${opportunityFile.path.split('/').last}
- @${jobFile.path.split('/').last}

The job file is the canonical human-formatted overview of the opportunity. It contains the full persisted job context, not just the description. Use the whole overview when scoring.

Return only structured JSON that matches the provided schema.
Scoring rules:
- scorePercentage must be an integer between 0 and 100 inclusive.
- Higher means a better match for skills, experience, and opportunity quality.
- aiScoreJustificationText must be concise, specific, and reference the strongest deciding factors from the job overview.
''';

      final codexStopwatch = Stopwatch()..start();
      logAutomationStart(
        logSession,
        AutomationLogScope.score,
        '$analysisLabel $runLabel codex exec started | model=${aiModel.name} effort=${aiThinkingEffort.name} timeout=${_formatCodexTimeout(_scoreCodexTimeout)}',
      );
      final generationResult = await _codexService.runStructuredJson(
        workingDirectory: workDirectory.path,
        prompt: prompt,
        schema: _scoreSchema,
        aiModel: aiModel,
        aiThinkingEffort: aiThinkingEffort,
        timeout: _scoreCodexTimeout,
      );
      codexStopwatch.stop();

      return await generationResult.fold(
        (payload) async {
          logAutomationDone(
            logSession,
            AutomationLogScope.score,
            '$analysisLabel $runLabel codex exec finished | duration=${_formatCodexElapsed(codexStopwatch.elapsed)}',
          );
          await _writeJsonPayload(workDirectory, 'score-result.json', payload);
          final parsedResult = _parseScorePayload(payload);
          return await parsedResult.fold(
            (parsed) async {
              final now = DateTime.now().toUtc();
              await session.db.transaction((transaction) async {
                final currentScore = await JobScore.db.findFirstRow(
                  session,
                  where: (table) =>
                      table.jobAnalysisStateId.equals(analysis.id),
                  transaction: transaction,
                  lockMode: LockMode.forUpdate,
                );

                if (currentScore == null) {
                  await JobScore.db.insertRow(
                    session,
                    JobScore(
                      jobAnalysisStateId: analysis.id!,
                      scorePercentage: parsed.scorePercentage,
                      aiScoreJustificationText: parsed.justification,
                    ),
                    transaction: transaction,
                  );
                } else {
                  await JobScore.db.updateRow(
                    session,
                    currentScore.copyWith(
                      scorePercentage: parsed.scorePercentage,
                      aiScoreJustificationText: parsed.justification,
                    ),
                    transaction: transaction,
                  );
                }

                await JobAnalysisState.db.updateRow(
                  session,
                  analysis.copyWith(createdJobScoringAt: now),
                  columns: (table) => [table.createdJobScoringAt],
                  transaction: transaction,
                );
              });
              logAutomationDone(
                logSession,
                AutomationLogScope.score,
                '$analysisLabel $runLabel finished | score=${parsed.scorePercentage}',
              );

              return Success(
                JobScoreGenerationSummary(
                  scorePercentage: parsed.scorePercentage,
                ),
              );
            },
            (error) async {
              logAutomationFail(
                logSession,
                AutomationLogScope.score,
                '$analysisLabel $runLabel failed | ${error.message}',
              );
              return Failure(error);
            },
          );
        },
        (error) async {
          logAutomationFail(
            logSession,
            AutomationLogScope.score,
            '$analysisLabel $runLabel codex exec failed | duration=${_formatCodexElapsed(codexStopwatch.elapsed)} reason=${error.message}',
          );
          logAutomationFail(
            logSession,
            AutomationLogScope.score,
            '$analysisLabel $runLabel failed | ${error.message}',
          );
          return Failure(error);
        },
      );
    } catch (error, stackTrace) {
      logAutomationFail(
        logSession,
        AutomationLogScope.score,
        '$analysisLabel $runLabel failed | ${error.runtimeType}',
      );
      return Failure(
        PascoaException(
          message: 'Unable to score the job',
          description:
              'The AI pipeline failed while generating a compatibility score for one job.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }

  Future<PascoaResult<JobProposalGenerationSummary>>
  _generateProposalForAnalysis(
    Session session,
    Session logSession,
    JobAnalysisState analysis,
    JobKnowledgeBundle knowledge,
    JobAutomationAiModel aiModel,
    JobAutomationAiThinkingEffort aiThinkingEffort, {
    required String runLabel,
  }) async {
    final validationError = _validateAnalysis(analysis);
    final analysisLabel = formatAutomationAnalysisLabel(analysis);
    if (validationError != null) {
      _logProposalFailure(
        logSession,
        analysisLabel: analysisLabel,
        runLabel: runLabel,
        message: validationError.message,
      );
      return Failure(validationError);
    }

    final questionCount = analysis.jobInfo?.questions?.length ?? 0;
    final isFixedPriceJob = analysis.jobInfo?.jobType == JobType.fixed;
    final contractType = analysis.jobInfo?.jobType.name ?? 'unknown';
    logAutomationStart(
      logSession,
      AutomationLogScope.proposal,
      '$analysisLabel $runLabel started | questions=$questionCount contract=$contractType',
    );
    logAutomationStart(
      logSession,
      AutomationLogScope.answers,
      '$analysisLabel $runLabel started | expectedQuestions=$questionCount',
    );
    logAutomationStart(
      logSession,
      AutomationLogScope.milestones,
      isFixedPriceJob
          ? '$analysisLabel $runLabel started | fixed-price milestone plan requested'
          : '$analysisLabel $runLabel started | hourly contract so milestones may be skipped',
    );

    try {
      final files = await _prepareProposalGenerationFiles(
        analysis: analysis,
        knowledge: knowledge,
        stageDirectoryName: 'proposal',
      );
      final generationResult = await _runProposalStructuredGeneration(
        logSession,
        scope: AutomationLogScope.proposal,
        analysisLabel: analysisLabel,
        runLabel: runLabel,
        workDirectory: files.workDirectory,
        payloadFileName: 'proposal-result.json',
        prompt: _buildFullProposalPrompt(files),
        schema: _proposalSchema,
        aiModel: aiModel,
        aiThinkingEffort: aiThinkingEffort,
        enableWebSearch: true,
      );

      return await generationResult.fold(
        (payload) async {
          final parsedResult = _parseProposalPayload(
            payload,
            analysis.jobInfo!,
          );

          return await parsedResult.fold(
            (parsed) async {
              await _persistFullProposal(
                session,
                analysis: analysis,
                parsed: parsed,
              );
              final milestoneTotal = parsed.milestones.fold<double>(
                0,
                (total, milestone) => total + milestone.suggestedPrice,
              );
              logAutomationDone(
                logSession,
                AutomationLogScope.proposal,
                '$analysisLabel $runLabel finished | coverLetter=yes',
              );
              logAutomationDone(
                logSession,
                AutomationLogScope.answers,
                '$analysisLabel $runLabel finished | generated=${parsed.answers.length}/$questionCount',
              );
              logAutomationDone(
                logSession,
                AutomationLogScope.milestones,
                isFixedPriceJob
                    ? '$analysisLabel $runLabel finished | generated=${parsed.milestones.length} total=${_formatCurrency(milestoneTotal)}'
                    : '$analysisLabel $runLabel finished | skipped=hourly-contract',
              );

              return Success(
                JobProposalGenerationSummary(
                  answerCount: parsed.answers.length,
                  milestoneCount: parsed.milestones.length,
                  isFixedPriceJob: isFixedPriceJob,
                ),
              );
            },
            (error) async {
              _logProposalFailure(
                logSession,
                analysisLabel: analysisLabel,
                runLabel: runLabel,
                message: error.message,
              );
              return Failure(error);
            },
          );
        },
        (error) async {
          _logProposalFailure(
            logSession,
            analysisLabel: analysisLabel,
            runLabel: runLabel,
            message: error.message,
          );
          return Failure(error);
        },
      );
    } catch (error, stackTrace) {
      _logProposalFailure(
        logSession,
        analysisLabel: analysisLabel,
        runLabel: runLabel,
        message: error.runtimeType.toString(),
      );
      return Failure(
        PascoaException(
          message: 'Unable to generate the job proposal',
          description:
              'The AI pipeline failed while generating the cover letter and question answers for one job.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }

  Future<PascoaResult<JobProposalGenerationSummary>>
  _generateProposalCoverLetterForAnalysis(
    Session session,
    Session logSession,
    JobAnalysisState analysis,
    JobKnowledgeBundle knowledge,
    JobAutomationAiModel aiModel,
    JobAutomationAiThinkingEffort aiThinkingEffort, {
    required String runLabel,
  }) async {
    final validationError = _validateAnalysis(analysis);
    final analysisLabel = formatAutomationAnalysisLabel(analysis);
    if (validationError != null) {
      logAutomationFail(
        logSession,
        AutomationLogScope.proposal,
        '$analysisLabel $runLabel failed | ${validationError.message}',
      );
      return Failure(validationError);
    }

    if (analysis.proposal == null) {
      return _generateProposalForAnalysis(
        session,
        logSession,
        analysis,
        knowledge,
        aiModel,
        aiThinkingEffort,
        runLabel: '$runLabel fallback=full-proposal',
      );
    }

    logAutomationStart(
      logSession,
      AutomationLogScope.proposal,
      '$analysisLabel $runLabel started | section=cover-letter',
    );

    try {
      final files = await _prepareProposalGenerationFiles(
        analysis: analysis,
        knowledge: knowledge,
        stageDirectoryName: 'proposal_cover_letter',
      );
      final generationResult = await _runProposalStructuredGeneration(
        logSession,
        scope: AutomationLogScope.proposal,
        analysisLabel: analysisLabel,
        runLabel: runLabel,
        workDirectory: files.workDirectory,
        payloadFileName: 'proposal-cover-letter-result.json',
        prompt: _buildCoverLetterPrompt(files),
        schema: _coverLetterSchema,
        aiModel: aiModel,
        aiThinkingEffort: aiThinkingEffort,
      );

      return await generationResult.fold(
        (payload) async {
          final parsedResult = _parseCoverLetterPayload(payload);
          return await parsedResult.fold(
            (coverLetter) async {
              await _persistProposalCoverLetter(
                session,
                analysis: analysis,
                coverLetter: coverLetter,
              );
              logAutomationDone(
                logSession,
                AutomationLogScope.proposal,
                '$analysisLabel $runLabel finished | section=cover-letter',
              );
              return Success(
                JobProposalGenerationSummary(
                  answerCount: analysis.proposal?.answers?.length ?? 0,
                  milestoneCount: analysis.proposal?.milestones?.length ?? 0,
                  isFixedPriceJob: analysis.jobInfo?.jobType == JobType.fixed,
                ),
              );
            },
            (error) async {
              logAutomationFail(
                logSession,
                AutomationLogScope.proposal,
                '$analysisLabel $runLabel failed | ${error.message}',
              );
              return Failure(error);
            },
          );
        },
        (error) async {
          logAutomationFail(
            logSession,
            AutomationLogScope.proposal,
            '$analysisLabel $runLabel failed | ${error.message}',
          );
          return Failure(error);
        },
      );
    } catch (error, stackTrace) {
      logAutomationFail(
        logSession,
        AutomationLogScope.proposal,
        '$analysisLabel $runLabel failed | ${error.runtimeType}',
      );
      return Failure(
        PascoaException(
          message: 'Unable to regenerate the cover letter',
          description:
              'The AI pipeline failed while regenerating the cover letter for one job.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }

  Future<PascoaResult<JobProposalGenerationSummary>>
  _generateProposalAnswerForAnalysis(
    Session session,
    Session logSession,
    JobAnalysisState analysis,
    JobKnowledgeBundle knowledge,
    int relatedQuestionId,
    JobAutomationAiModel aiModel,
    JobAutomationAiThinkingEffort aiThinkingEffort, {
    required String runLabel,
  }) async {
    final validationError = _validateAnalysis(analysis);
    final analysisLabel = formatAutomationAnalysisLabel(analysis);
    if (validationError != null) {
      logAutomationFail(
        logSession,
        AutomationLogScope.answers,
        '$analysisLabel $runLabel failed | ${validationError.message}',
      );
      return Failure(validationError);
    }

    final targetQuestion = _findQuestionById(
      analysis.jobInfo?.questions ?? const <Question>[],
      relatedQuestionId,
    );
    if (targetQuestion == null) {
      final error = PascoaException(
        message: 'Question not found',
        description:
            'The requested relatedQuestionId does not belong to the selected job analysis.',
      );
      logAutomationFail(
        logSession,
        AutomationLogScope.answers,
        '$analysisLabel $runLabel failed | ${error.message}',
      );
      return Failure(error);
    }

    if (analysis.proposal == null) {
      return _generateProposalForAnalysis(
        session,
        logSession,
        analysis,
        knowledge,
        aiModel,
        aiThinkingEffort,
        runLabel: '$runLabel fallback=full-proposal',
      );
    }

    logAutomationStart(
      logSession,
      AutomationLogScope.answers,
      '$analysisLabel $runLabel started | targetQuestion=${targetQuestion.positionIndex + 1}',
    );

    try {
      final files = await _prepareProposalGenerationFiles(
        analysis: analysis,
        knowledge: knowledge,
        stageDirectoryName: 'proposal_answer_$relatedQuestionId',
      );
      final generationResult = await _runProposalStructuredGeneration(
        logSession,
        scope: AutomationLogScope.answers,
        analysisLabel: analysisLabel,
        runLabel: runLabel,
        workDirectory: files.workDirectory,
        payloadFileName: 'proposal-answer-result.json',
        prompt: _buildSingleAnswerPrompt(
          files,
          question: targetQuestion,
        ),
        schema: _singleAnswerSchema,
        aiModel: aiModel,
        aiThinkingEffort: aiThinkingEffort,
      );

      return await generationResult.fold(
        (payload) async {
          final parsedResult = _parseSingleAnswerPayload(
            payload,
            relatedQuestionId: relatedQuestionId,
          );
          return await parsedResult.fold(
            (answer) async {
              await _persistProposalAnswer(
                session,
                analysis: analysis,
                answer: answer,
              );
              logAutomationDone(
                logSession,
                AutomationLogScope.answers,
                '$analysisLabel $runLabel finished | targetQuestion=${targetQuestion.positionIndex + 1}',
              );
              return Success(
                JobProposalGenerationSummary(
                  answerCount: 1,
                  milestoneCount: analysis.proposal?.milestones?.length ?? 0,
                  isFixedPriceJob: analysis.jobInfo?.jobType == JobType.fixed,
                ),
              );
            },
            (error) async {
              logAutomationFail(
                logSession,
                AutomationLogScope.answers,
                '$analysisLabel $runLabel failed | ${error.message}',
              );
              return Failure(error);
            },
          );
        },
        (error) async {
          logAutomationFail(
            logSession,
            AutomationLogScope.answers,
            '$analysisLabel $runLabel failed | ${error.message}',
          );
          return Failure(error);
        },
      );
    } catch (error, stackTrace) {
      logAutomationFail(
        logSession,
        AutomationLogScope.answers,
        '$analysisLabel $runLabel failed | ${error.runtimeType}',
      );
      return Failure(
        PascoaException(
          message: 'Unable to regenerate the answer',
          description:
              'The AI pipeline failed while regenerating one answer for the selected job question.',
          error: error.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
  }

  Future<_ProposalGenerationFiles> _prepareProposalGenerationFiles({
    required JobAnalysisState analysis,
    required JobKnowledgeBundle knowledge,
    required String stageDirectoryName,
  }) async {
    final workDirectory = await _prepareWorkDirectory(
      analysisId: analysis.id!,
      stageDirectoryName: stageDirectoryName,
    );
    final jobFile = await _writeJobContextFile(
      workDirectory: workDirectory,
      analysis: analysis,
      includeScore: true,
    );
    final curriculumFile = await _writeFile(
      workDirectory,
      'curriculum.md',
      knowledge.curriculum.markdownText,
    );
    final proposalStyleFile = await _writeFile(
      workDirectory,
      'proposal-style-preference.md',
      knowledge.proposalStyle.markdownText,
    );
    final opportunityPreferenceFile = await _writeFile(
      workDirectory,
      'job-opportunity-preference.md',
      knowledge.opportunityPreference.markdownText,
    );

    return _ProposalGenerationFiles(
      workDirectory: workDirectory,
      jobFile: jobFile,
      curriculumFile: curriculumFile,
      proposalStyleFile: proposalStyleFile,
      opportunityPreferenceFile: opportunityPreferenceFile,
    );
  }

  String _buildProposalReadInstructions(_ProposalGenerationFiles files) {
    return '''
Before responding, read these files completely and do not continue until you have read them all:
- @${files.curriculumFile.path.split('/').last}
- @${files.proposalStyleFile.path.split('/').last}
- @${files.opportunityPreferenceFile.path.split('/').last}
- @${files.jobFile.path.split('/').last}
''';
  }

  String _buildEvidenceGroundingRules() {
    return '''
- Base every statement on the freelancer files and the persisted job context.
- Reuse concrete facts from the freelancer files whenever relevant, such as shipped products, role scope, technologies, industries, outcomes, and links.
- Do not say information is unavailable, can be shared later, or can be provided on request when the freelancer files already contain usable evidence.
- If the freelancer files truly do not contain the requested fact, answer truthfully with the closest supported detail and do not invent credentials, years, metrics, or links.
''';
  }

  String _buildQuestionAnswerGroundingRules() {
    return '''
- Every answer must be written from the freelancer's real background in the curriculum file, not as a generic template.
- If a question asks for a GitHub profile, portfolio, website, case study, or similar link, include the actual link present in the freelancer files when available.
- Each answer should be directly usable in the Upwork form, concise, specific, and should not repeat the raw question.
''';
  }

  String _buildFullProposalPrompt(_ProposalGenerationFiles files) {
    return '''
You are writing a tailored Upwork cover letter, question answers, and milestone suggestions for the freelancer.

${_buildProposalReadInstructions(files)}

The job file is the canonical source for the contract type and compensation details.
If the project is fixed-price, you may do focused web research when it materially improves the milestone breakdown, such as validating sensible delivery phases, dependencies, or domain-specific implementation checkpoints. Keep any research tight and relevant to the actual job.

Return only structured JSON that matches the provided schema.
Rules:
- aiGeneratedCoverLetterText must sound like the freelancer described in the files.
${_buildEvidenceGroundingRules()}${_buildQuestionAnswerGroundingRules()}- answers must contain one entry for each job question listed in the job file.
- Each answer entry must use the exact relatedQuestionId from the job file.
- milestones must be null when the job type is hourly.
- For fixed-price jobs, milestones must be a non-empty ordered list of concrete payment checkpoints that break the work into sensible delivery phases.
- Each milestone must contain a concise title, a specific description of the deliverable or outcome, and a numeric suggestedPrice.
- When the job file provides a fixed price amount, the sum of all milestone suggestedPrice values must equal that amount exactly to the cent.
- If the fixed price amount is unavailable but the raw budget text still implies a range or target, infer a single reasonable bid total from the job context and make the milestone prices add up to that inferred total.
- Milestones should be tailored to the scope, reduce delivery risk, and avoid vague placeholders.
- If the scope is small, a single milestone is acceptable, but the pricing still must add up to the total bid.
''';
  }

  String _buildCoverLetterPrompt(_ProposalGenerationFiles files) {
    return '''
You are writing a tailored Upwork cover letter for the freelancer.

${_buildProposalReadInstructions(files)}

The job file is the canonical source for the project scope, contract type, and compensation details.

Return only structured JSON that matches the provided schema.
Rules:
- aiGeneratedCoverLetterText must sound like the freelancer described in the files.
${_buildEvidenceGroundingRules()}- The cover letter should be directly usable in Upwork, concise, specific, and tailored to this exact job.
''';
  }

  String _buildSingleAnswerPrompt(
    _ProposalGenerationFiles files, {
    required Question question,
  }) {
    return '''
You are writing one tailored Upwork question answer for the freelancer.

${_buildProposalReadInstructions(files)}

Return only structured JSON that matches the provided schema.
Rules:
${_buildEvidenceGroundingRules()}${_buildQuestionAnswerGroundingRules()}- Return exactly one answer for the target question below.
- relatedQuestionId must be ${question.id}.

Target question:
- Question ${question.positionIndex + 1} (relatedQuestionId: ${question.id}): ${question.question.trim()}
''';
  }

  Future<PascoaResult<Map<String, dynamic>>> _runProposalStructuredGeneration(
    Session logSession, {
    required AutomationLogScope scope,
    required String analysisLabel,
    required String runLabel,
    required Directory workDirectory,
    required String payloadFileName,
    required String prompt,
    required Map<String, Object?> schema,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
    bool enableWebSearch = false,
  }) async {
    final codexStopwatch = Stopwatch()..start();
    logAutomationStart(
      logSession,
      scope,
      '$analysisLabel $runLabel codex exec started | model=${aiModel.name} effort=${aiThinkingEffort.name} timeout=${_formatCodexTimeout(_proposalCodexTimeout)}${enableWebSearch ? ' webSearch=live' : ''}',
    );
    final generationResult = await _codexService.runStructuredJson(
      workingDirectory: workDirectory.path,
      prompt: prompt,
      schema: schema,
      aiModel: aiModel,
      aiThinkingEffort: aiThinkingEffort,
      enableWebSearch: enableWebSearch,
      timeout: _proposalCodexTimeout,
    );
    codexStopwatch.stop();

    return await generationResult.fold(
      (payload) async {
        logAutomationDone(
          logSession,
          scope,
          '$analysisLabel $runLabel codex exec finished | duration=${_formatCodexElapsed(codexStopwatch.elapsed)}',
        );
        await _writeJsonPayload(workDirectory, payloadFileName, payload);
        return Success(payload);
      },
      (error) async {
        logAutomationFail(
          logSession,
          scope,
          '$analysisLabel $runLabel codex exec failed | duration=${_formatCodexElapsed(codexStopwatch.elapsed)} reason=${error.message}',
        );
        return Failure(error);
      },
    );
  }

  Future<void> _persistFullProposal(
    Session session, {
    required JobAnalysisState analysis,
    required _ParsedProposalPayload parsed,
  }) async {
    final now = DateTime.now().toUtc();
    await session.db.transaction((transaction) async {
      final currentProposal = await JobProposal.db.findFirstRow(
        session,
        where: (table) => table.jobAnalysisStateId.equals(analysis.id),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );

      final proposal = currentProposal == null
          ? await JobProposal.db.insertRow(
              session,
              JobProposal(
                jobAnalysisStateId: analysis.id!,
                aiGeneratedCoverLetterText: parsed.coverLetter,
              ),
              transaction: transaction,
            )
          : await JobProposal.db.updateRow(
              session,
              currentProposal.copyWith(
                aiGeneratedCoverLetterText: parsed.coverLetter,
              ),
              transaction: transaction,
            );

      await JobProposalAnswerToQuestion.db.deleteWhere(
        session,
        where: (table) => table.jobProposalId.equals(proposal.id),
        transaction: transaction,
      );
      await JobProposalMilestone.db.deleteWhere(
        session,
        where: (table) => table.jobProposalId.equals(proposal.id),
        transaction: transaction,
      );

      if (parsed.answers.isNotEmpty) {
        await JobProposalAnswerToQuestion.db.insert(
          session,
          [
            for (final answer in parsed.answers)
              JobProposalAnswerToQuestion(
                jobProposalId: proposal.id!,
                relatedQuestionId: answer.relatedQuestionId,
                aiGeneratedAnswerText: answer.answerText,
              ),
          ],
          transaction: transaction,
        );
      }

      if (parsed.milestones.isNotEmpty) {
        await JobProposalMilestone.db.insert(
          session,
          [
            for (final milestone in parsed.milestones)
              JobProposalMilestone(
                jobProposalId: proposal.id!,
                positionIndex: milestone.positionIndex,
                title: milestone.title,
                description: milestone.description,
                suggestedPrice: milestone.suggestedPrice,
              ),
          ],
          transaction: transaction,
        );
      }

      await _touchAiResponsesGeneratedAt(
        session,
        analysis: analysis,
        now: now,
        transaction: transaction,
      );
    });
  }

  Future<void> _persistProposalCoverLetter(
    Session session, {
    required JobAnalysisState analysis,
    required String coverLetter,
  }) async {
    final now = DateTime.now().toUtc();
    await session.db.transaction((transaction) async {
      final currentProposal = await JobProposal.db.findFirstRow(
        session,
        where: (table) => table.jobAnalysisStateId.equals(analysis.id),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );

      if (currentProposal == null) {
        await JobProposal.db.insertRow(
          session,
          JobProposal(
            jobAnalysisStateId: analysis.id!,
            aiGeneratedCoverLetterText: coverLetter,
          ),
          transaction: transaction,
        );
      } else {
        await JobProposal.db.updateRow(
          session,
          currentProposal.copyWith(aiGeneratedCoverLetterText: coverLetter),
          transaction: transaction,
        );
      }

      await _touchAiResponsesGeneratedAt(
        session,
        analysis: analysis,
        now: now,
        transaction: transaction,
      );
    });
  }

  Future<void> _persistProposalAnswer(
    Session session, {
    required JobAnalysisState analysis,
    required _ParsedProposalAnswer answer,
  }) async {
    final now = DateTime.now().toUtc();
    await session.db.transaction((transaction) async {
      final currentProposal = await JobProposal.db.findFirstRow(
        session,
        where: (table) => table.jobAnalysisStateId.equals(analysis.id),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (currentProposal == null) {
        throw StateError(
          'Cannot persist a regenerated answer without an existing proposal row.',
        );
      }

      final currentAnswer = await JobProposalAnswerToQuestion.db.findFirstRow(
        session,
        where: (table) =>
            table.jobProposalId.equals(currentProposal.id) &
            table.relatedQuestionId.equals(answer.relatedQuestionId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );

      if (currentAnswer == null) {
        await JobProposalAnswerToQuestion.db.insertRow(
          session,
          JobProposalAnswerToQuestion(
            jobProposalId: currentProposal.id!,
            relatedQuestionId: answer.relatedQuestionId,
            aiGeneratedAnswerText: answer.answerText,
          ),
          transaction: transaction,
        );
      } else {
        await JobProposalAnswerToQuestion.db.updateRow(
          session,
          currentAnswer.copyWith(aiGeneratedAnswerText: answer.answerText),
          transaction: transaction,
        );
      }

      await _touchAiResponsesGeneratedAt(
        session,
        analysis: analysis,
        now: now,
        transaction: transaction,
      );
    });
  }

  Future<void> _touchAiResponsesGeneratedAt(
    Session session, {
    required JobAnalysisState analysis,
    required DateTime now,
    required Transaction transaction,
  }) {
    return JobAnalysisState.db.updateRow(
      session,
      analysis.copyWith(createdJobAiResponsesAt: now),
      columns: (table) => [table.createdJobAiResponsesAt],
      transaction: transaction,
    );
  }

  Question? _findQuestionById(
    Iterable<Question> questions,
    int relatedQuestionId,
  ) {
    for (final question in questions) {
      if (question.id == relatedQuestionId) {
        return question;
      }
    }
    return null;
  }

  PascoaResult<String> _parseCoverLetterPayload(Map<String, dynamic> payload) {
    final coverLetter = payload['aiGeneratedCoverLetterText'];
    if (coverLetter is! String || coverLetter.trim().isEmpty) {
      return Failure(
        PascoaException(
          message: 'Invalid AI proposal payload',
          description:
              'Codex returned an empty or missing aiGeneratedCoverLetterText field.',
          error: jsonEncode(payload),
        ),
      );
    }

    return Success(coverLetter.trim());
  }

  PascoaResult<_ParsedProposalAnswer> _parseSingleAnswerPayload(
    Map<String, dynamic> payload, {
    required int relatedQuestionId,
  }) {
    final returnedQuestionId = payload['relatedQuestionId'];
    final answerText = payload['aiGeneratedAnswerText'];
    if (returnedQuestionId is! int || returnedQuestionId != relatedQuestionId) {
      return Failure(
        PascoaException(
          message: 'Invalid AI proposal payload',
          description:
              'Codex must return the exact relatedQuestionId for the requested answer refresh.',
          error: jsonEncode(payload),
        ),
      );
    }
    if (answerText is! String || answerText.trim().isEmpty) {
      return Failure(
        PascoaException(
          message: 'Invalid AI proposal payload',
          description: 'Codex must return a non-empty regenerated answer.',
          error: jsonEncode(payload),
        ),
      );
    }

    return Success(
      _ParsedProposalAnswer(
        relatedQuestionId: relatedQuestionId,
        answerText: answerText.trim(),
      ),
    );
  }

  Future<PascoaResult<T>> _withTaskSession<T extends Object>(
    Session parentSession,
    Future<PascoaResult<T>> Function(Session session) run,
  ) async {
    final taskSession = await parentSession.serverpod.createSession(
      enableLogging: false,
    );
    try {
      return await run(taskSession);
    } finally {
      await taskSession.close();
    }
  }

  void _logProposalFailure(
    Session logSession, {
    required String analysisLabel,
    required String runLabel,
    required String message,
  }) {
    final normalizedMessage = message.trim();
    logAutomationFail(
      logSession,
      AutomationLogScope.proposal,
      '$analysisLabel $runLabel failed | $normalizedMessage',
    );
    logAutomationFail(
      logSession,
      AutomationLogScope.answers,
      '$analysisLabel $runLabel failed | proposal output missing',
    );
    logAutomationFail(
      logSession,
      AutomationLogScope.milestones,
      '$analysisLabel $runLabel failed | proposal output missing',
    );
  }

  PascoaException? _validateAnalysis(JobAnalysisState analysis) {
    if (analysis.id == null) {
      return PascoaException(
        message: 'Missing analysis id',
        description:
            'The AI generation pipeline received a job analysis row without a database id.',
      );
    }

    if (analysis.jobInfo == null) {
      return PascoaException(
        message: 'Missing job information',
        description:
            'The AI generation pipeline requires the related JobInfo row to be included before it can run.',
      );
    }

    return null;
  }

  Future<Directory> _prepareWorkDirectory({
    required int analysisId,
    required String stageDirectoryName,
  }) async {
    final directory = Directory(
      '${Directory.current.path}/$codexRunsDirectoryName/job_analysis_$analysisId/$stageDirectoryName',
    );
    if (directory.existsSync()) {
      await directory.delete(recursive: true);
    }
    await directory.create(recursive: true);
    return directory;
  }

  Future<File> _writeJobContextFile({
    required Directory workDirectory,
    required JobAnalysisState analysis,
    required bool includeScore,
  }) async {
    final job = analysis.jobInfo!;
    final questions = [
      ...?job.questions,
    ]..sort((left, right) => left.positionIndex.compareTo(right.positionIndex));

    final buffer = StringBuffer()
      ..writeln('# Upwork job overview')
      ..writeln()
      ..writeln(
        'This file is the canonical human-formatted overview of every persisted job field for this opportunity.',
      )
      ..writeln(
        'Use the whole overview when scoring or writing. Do not rely only on the description section.',
      )
      ..writeln();

    void writeField(String label, String value) {
      buffer.writeln('- **$label:** $value');
    }

    buffer.writeln('## Identifiers');
    writeField('Job analysis id', '${analysis.id}');
    writeField('Database job id', '${job.id ?? 'Not available'}');
    writeField('Upwork id', job.upworkId);
    writeField('Sub id', _formatText(job.subId));
    writeField('URL', job.url);
    buffer.writeln();

    buffer.writeln('## Posting timeline');
    writeField('Relative date text', _formatText(job.relativeDate));
    writeField(
      'Relative date minutes',
      job.relativeDateMinutes?.toString() ?? 'Not available',
    );
    writeField('Absolute date text', _formatText(job.absoluteDate));
    writeField(
      'Absolute date time (UTC)',
      _formatDateTime(job.absoluteDateTime),
    );
    buffer.writeln();

    buffer.writeln('## Compensation and contract');
    writeField('Job type', _formatEnumValue(job.jobType));
    writeField('Experience level', _formatEnumValue(job.experienceLevel));
    writeField(
      'Payment verified status',
      _formatEnumValue(job.paymentVerifiedStatus),
    );
    writeField('Budget text', _formatText(job.budget));
    writeField('Fixed price amount', _formatCurrency(job.fixedPriceAmount));
    writeField('Hourly min rate', _formatCurrency(job.hourlyMinRate));
    writeField('Hourly max rate', _formatCurrency(job.hourlyMaxRate));
    writeField('Client has hired before', _formatBool(job.hasHired));
    buffer.writeln();

    buffer.writeln('## Client');
    writeField('Client name', _formatText(job.clientName));
    writeField(
      'Client name confidence percent',
      _formatPercent(job.clientNameConfidencePercent),
    );
    writeField('Client rating', _formatNumber(job.clientRating));
    writeField(
      'Client hire rate percent',
      _formatPercent(job.clientHireRatePercent),
    );
    writeField(
      'Client average hourly rate',
      _formatCurrency(job.clientAvgHourlyRate),
    );
    writeField('Client total spent', _formatCurrency(job.clientTotalSpent));
    buffer.writeln();

    buffer.writeln('## Location and eligibility');
    writeField(
      'Client location summary',
      _formatClientLocation(job.clientLocation),
    );
    writeField(
      'Client location country',
      _formatEnumValue(job.clientLocation?.country),
    );
    writeField(
      'Client location region',
      _formatEnumValue(job.clientLocation?.region),
    );
    writeField(
      'Client location sub-region',
      _formatEnumValue(job.clientLocation?.subRegion),
    );
    writeField(
      'Allowed applicant countries',
      _formatAllowedCountries(job.allowedApplicantCountries),
    );
    buffer.writeln();

    buffer.writeln('## Classification');
    writeField(
      'Tags',
      job.tags.isEmpty ? 'No tags listed' : job.tags.join(', '),
    );
    buffer.writeln();

    if (includeScore && analysis.score != null) {
      buffer.writeln('## Existing score');
      writeField(
        'Score percentage',
        analysis.score!.scorePercentage.toString(),
      );
      writeField(
        'Justification',
        analysis.score!.aiScoreJustificationText.trim(),
      );
      buffer.writeln();
    }

    buffer
      ..writeln('## Description')
      ..writeln(job.description.trim())
      ..writeln();

    buffer.writeln('## Application questions');
    if (questions.isEmpty) {
      buffer.writeln('No application questions.');
    } else {
      for (final question in questions) {
        buffer.writeln(
          '- Question ${question.positionIndex + 1} (relatedQuestionId: ${question.id ?? 'Not available'}): ${question.question.trim()}',
        );
      }
    }

    return _writeFile(workDirectory, 'job.md', buffer.toString());
  }

  String _formatText(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return 'Not available';
    }
    return trimmed;
  }

  String _formatDateTime(DateTime? value) {
    return value == null ? 'Not available' : value.toUtc().toIso8601String();
  }

  String _formatNumber(num? value) {
    if (value == null) {
      return 'Not available';
    }

    final asString = value is int ? value.toString() : value.toStringAsFixed(2);
    return asString
        .replaceFirst(RegExp(r'\.00$'), '')
        .replaceFirst(
          RegExp(r'(\.\d*[1-9])0+$'),
          r'$1',
        );
  }

  String _formatCurrency(double? value) {
    if (value == null) {
      return 'Not available';
    }
    return '\$${_formatNumber(value)}';
  }

  String _formatPercent(double? value) {
    if (value == null) {
      return 'Not available';
    }
    return '${_formatNumber(value)}%';
  }

  String _formatBool(bool value) {
    return value ? 'Yes' : 'No';
  }

  String _formatEnumValue(Object? value) {
    if (value == null) {
      return 'Not available';
    }
    if (value is Enum) {
      return _humanizeIdentifier(value.name);
    }
    return _humanizeIdentifier(value.toString());
  }

  String _formatClientLocation(ClientLocation? location) {
    if (location == null) {
      return 'Not available';
    }

    final parts = [
      if (location.country != null) _formatEnumValue(location.country),
      if (location.region != null) _formatEnumValue(location.region),
      if (location.subRegion != null) _formatEnumValue(location.subRegion),
    ];
    return parts.isEmpty ? 'Not available' : parts.join(' • ');
  }

  String _formatAllowedCountries(List<Country> countries) {
    if (countries.isEmpty) {
      return 'No restrictions listed';
    }
    return countries.map(_formatEnumValue).join(', ');
  }

  String _humanizeIdentifier(String value) {
    final normalized = value
        .replaceAll('_', ' ')
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (match) => '${match.group(1)} ${match.group(2)}',
        )
        .trim();
    if (normalized.isEmpty) {
      return value;
    }

    return normalized
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .map(
          (part) =>
              '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  Future<File> _writeFile(
    Directory directory,
    String fileName,
    String contents,
  ) async {
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(contents);
    return file;
  }

  Future<void> _writeJsonPayload(
    Directory directory,
    String fileName,
    Map<String, dynamic> payload,
  ) async {
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(payload),
    );
  }

  PascoaResult<_ParsedScorePayload> _parseScorePayload(
    Map<String, dynamic> payload,
  ) {
    final scorePercentage = payload['scorePercentage'];
    final justification = payload['aiScoreJustificationText'];
    if (scorePercentage is! int ||
        scorePercentage < 0 ||
        scorePercentage > 100) {
      return Failure(
        PascoaException(
          message: 'Invalid AI score payload',
          description:
              'Codex returned an invalid scorePercentage value. It must be an integer between 0 and 100.',
          error: jsonEncode(payload),
        ),
      );
    }
    if (justification is! String || justification.trim().isEmpty) {
      return Failure(
        PascoaException(
          message: 'Invalid AI score payload',
          description:
              'Codex returned an empty or missing aiScoreJustificationText field.',
          error: jsonEncode(payload),
        ),
      );
    }

    return Success(
      _ParsedScorePayload(
        scorePercentage: scorePercentage,
        justification: justification.trim(),
      ),
    );
  }

  PascoaResult<_ParsedProposalPayload> _parseProposalPayload(
    Map<String, dynamic> payload,
    JobInfo job,
  ) {
    final questions = job.questions ?? const <Question>[];
    final coverLetter = payload['aiGeneratedCoverLetterText'];
    final answersRaw = payload['answers'];
    final milestonesRaw = payload['milestones'];
    if (coverLetter is! String || coverLetter.trim().isEmpty) {
      return Failure(
        PascoaException(
          message: 'Invalid AI proposal payload',
          description:
              'Codex returned an empty or missing aiGeneratedCoverLetterText field.',
          error: jsonEncode(payload),
        ),
      );
    }
    if (answersRaw is! List) {
      return Failure(
        PascoaException(
          message: 'Invalid AI proposal payload',
          description: 'Codex must return the answers field as a list.',
          error: jsonEncode(payload),
        ),
      );
    }

    final milestonesResult = _parseMilestonesPayload(
      milestonesRaw,
      job,
    );
    late final List<_ParsedProposalMilestone> parsedMilestones;
    final milestonesFailure = milestonesResult.fold<PascoaException?>(
      (value) {
        parsedMilestones = value;
        return null;
      },
      (error) => error,
    );
    if (milestonesFailure != null) {
      return Failure(milestonesFailure);
    }

    final validQuestionIds = {
      for (final question in questions)
        if (question.id != null) question.id!,
    };
    final parsedAnswers = <_ParsedProposalAnswer>[];
    final seenQuestionIds = <int>{};
    for (final item in answersRaw) {
      if (item is! Map) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description: 'Each answer must be returned as an object.',
            error: jsonEncode(payload),
          ),
        );
      }

      final answerJson = Map<String, dynamic>.from(item);
      final relatedQuestionId = answerJson['relatedQuestionId'];
      final answerText = answerJson['aiGeneratedAnswerText'];
      if (relatedQuestionId is! int ||
          !validQuestionIds.contains(relatedQuestionId)) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description:
                'Each generated answer must reference a valid relatedQuestionId from the job context.',
            error: jsonEncode(payload),
          ),
        );
      }
      if (answerText is! String || answerText.trim().isEmpty) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description: 'Each generated answer must contain non-empty text.',
            error: jsonEncode(payload),
          ),
        );
      }
      if (!seenQuestionIds.add(relatedQuestionId)) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description:
                'Codex returned the same relatedQuestionId more than once in the answers list.',
            error: jsonEncode(payload),
          ),
        );
      }

      parsedAnswers.add(
        _ParsedProposalAnswer(
          relatedQuestionId: relatedQuestionId,
          answerText: answerText.trim(),
        ),
      );
    }

    if (validQuestionIds.length != parsedAnswers.length) {
      return Failure(
        PascoaException(
          message: 'Incomplete AI proposal payload',
          description:
              'Codex must return one answer for each job question when questions exist.',
          error: jsonEncode(payload),
        ),
      );
    }

    return Success(
      _ParsedProposalPayload(
        coverLetter: coverLetter.trim(),
        answers: parsedAnswers,
        milestones: parsedMilestones,
      ),
    );
  }

  PascoaResult<List<_ParsedProposalMilestone>> _parseMilestonesPayload(
    dynamic milestonesRaw,
    JobInfo job,
  ) {
    if (job.jobType == JobType.hourly) {
      if (milestonesRaw != null) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description:
                'Codex must return milestones as null for hourly jobs.',
            error: jsonEncode({'milestones': milestonesRaw}),
          ),
        );
      }

      return const Success(<_ParsedProposalMilestone>[]);
    }

    if (milestonesRaw is! List || milestonesRaw.isEmpty) {
      return Failure(
        PascoaException(
          message: 'Incomplete AI proposal payload',
          description:
              'Codex must return at least one milestone for fixed-price jobs.',
          error: jsonEncode({'milestones': milestonesRaw}),
        ),
      );
    }

    final parsedMilestones = <_ParsedProposalMilestone>[];
    for (var index = 0; index < milestonesRaw.length; index++) {
      final item = milestonesRaw[index];
      if (item is! Map) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description: 'Each milestone must be returned as an object.',
            error: jsonEncode({'milestones': milestonesRaw}),
          ),
        );
      }

      final milestoneJson = Map<String, dynamic>.from(item);
      final title = milestoneJson['title'];
      final description = milestoneJson['description'];
      final suggestedPrice = milestoneJson['suggestedPrice'];

      if (title is! String || title.trim().isEmpty) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description: 'Each milestone must include a non-empty title.',
            error: jsonEncode({'milestones': milestonesRaw}),
          ),
        );
      }

      if (description is! String || description.trim().isEmpty) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description: 'Each milestone must include a non-empty description.',
            error: jsonEncode({'milestones': milestonesRaw}),
          ),
        );
      }

      if (suggestedPrice is! num || suggestedPrice <= 0) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description:
                'Each milestone must include a positive numeric suggestedPrice.',
            error: jsonEncode({'milestones': milestonesRaw}),
          ),
        );
      }

      parsedMilestones.add(
        _ParsedProposalMilestone(
          positionIndex: index,
          title: title.trim(),
          description: description.trim(),
          suggestedPrice: _roundCurrency(suggestedPrice.toDouble()),
        ),
      );
    }

    final expectedTotal = _resolveFixedPriceTotal(job);
    if (expectedTotal != null) {
      final actualTotal = _roundCurrency(
        parsedMilestones.fold<double>(
          0,
          (sum, milestone) => sum + milestone.suggestedPrice,
        ),
      );
      if ((actualTotal - expectedTotal).abs() > 0.01) {
        return Failure(
          PascoaException(
            message: 'Invalid AI proposal payload',
            description:
                'Milestone prices must add up to the fixed-price total from the job context.',
            error: jsonEncode({
              'expectedTotal': expectedTotal,
              'actualTotal': actualTotal,
              'milestones': milestonesRaw,
            }),
          ),
        );
      }
    }

    return Success(parsedMilestones);
  }

  double? _resolveFixedPriceTotal(JobInfo job) {
    final fixedPriceAmount = job.fixedPriceAmount;
    if (fixedPriceAmount != null && fixedPriceAmount > 0) {
      return _roundCurrency(fixedPriceAmount);
    }

    final budget = job.budget;
    if (budget == null || budget.trim().isEmpty) {
      return null;
    }

    final normalizedBudget = budget.replaceAll(',', '');
    final matches = RegExp(r'\d+(?:\.\d+)?').allMatches(normalizedBudget);
    final values = [
      for (final match in matches)
        double.tryParse(match.group(0) ?? '') ?? double.nan,
    ].where((value) => !value.isNaN && value > 0).toList(growable: false);
    if (values.isEmpty) {
      return null;
    }

    return _roundCurrency(values.first);
  }

  double _roundCurrency(double value) {
    return double.parse(value.toStringAsFixed(2));
  }
}

class _ParsedScorePayload {
  const _ParsedScorePayload({
    required this.scorePercentage,
    required this.justification,
  });

  final int scorePercentage;
  final String justification;
}

class JobScoreGenerationSummary {
  const JobScoreGenerationSummary({
    required this.scorePercentage,
  });

  final int scorePercentage;
}

class JobProposalGenerationSummary {
  const JobProposalGenerationSummary({
    required this.answerCount,
    required this.milestoneCount,
    required this.isFixedPriceJob,
  });

  final int answerCount;
  final int milestoneCount;
  final bool isFixedPriceJob;
}

class _ParsedProposalPayload {
  const _ParsedProposalPayload({
    required this.coverLetter,
    required this.answers,
    required this.milestones,
  });

  final String coverLetter;
  final List<_ParsedProposalAnswer> answers;
  final List<_ParsedProposalMilestone> milestones;
}

class _ParsedProposalAnswer {
  const _ParsedProposalAnswer({
    required this.relatedQuestionId,
    required this.answerText,
  });

  final int relatedQuestionId;
  final String answerText;
}

class _ParsedProposalMilestone {
  const _ParsedProposalMilestone({
    required this.positionIndex,
    required this.title,
    required this.description,
    required this.suggestedPrice,
  });

  final int positionIndex;
  final String title;
  final String description;
  final double suggestedPrice;
}

class _ProposalGenerationFiles {
  const _ProposalGenerationFiles({
    required this.workDirectory,
    required this.jobFile,
    required this.curriculumFile,
    required this.proposalStyleFile,
    required this.opportunityPreferenceFile,
  });

  final Directory workDirectory;
  final File jobFile;
  final File curriculumFile;
  final File proposalStyleFile;
  final File opportunityPreferenceFile;
}

const Duration _scoreCodexTimeout = Duration(minutes: 2);
const Duration _proposalCodexTimeout = Duration(minutes: 5);

String _formatCodexTimeout(Duration duration) {
  return '${duration.inSeconds}s';
}

String _formatCodexElapsed(Duration duration) {
  final totalMilliseconds = duration.inMilliseconds;
  final wholeSeconds = totalMilliseconds ~/ 1000;
  final fractionalMilliseconds = (totalMilliseconds % 1000) ~/ 100;
  return '$wholeSeconds.${fractionalMilliseconds}s';
}

const Map<String, Object?> _scoreSchema = {
  'type': 'object',
  'properties': {
    'scorePercentage': {
      'type': 'integer',
      'minimum': 0,
      'maximum': 100,
    },
    'aiScoreJustificationText': {
      'type': 'string',
    },
  },
  'required': ['scorePercentage', 'aiScoreJustificationText'],
  'additionalProperties': false,
};

const Map<String, Object?> _proposalSchema = {
  'type': 'object',
  'properties': {
    'aiGeneratedCoverLetterText': {
      'type': 'string',
    },
    'answers': {
      'type': 'array',
      'items': {
        'type': 'object',
        'properties': {
          'relatedQuestionId': {'type': 'integer'},
          'aiGeneratedAnswerText': {'type': 'string'},
        },
        'required': ['relatedQuestionId', 'aiGeneratedAnswerText'],
        'additionalProperties': false,
      },
    },
    'milestones': {
      'anyOf': [
        {'type': 'null'},
        {
          'type': 'array',
          'items': {
            'type': 'object',
            'properties': {
              'title': {'type': 'string'},
              'description': {'type': 'string'},
              'suggestedPrice': {'type': 'number', 'exclusiveMinimum': 0},
            },
            'required': ['title', 'description', 'suggestedPrice'],
            'additionalProperties': false,
          },
        },
      ],
    },
  },
  'required': ['aiGeneratedCoverLetterText', 'answers', 'milestones'],
  'additionalProperties': false,
};

const Map<String, Object?> _coverLetterSchema = {
  'type': 'object',
  'properties': {
    'aiGeneratedCoverLetterText': {
      'type': 'string',
    },
  },
  'required': ['aiGeneratedCoverLetterText'],
  'additionalProperties': false,
};

const Map<String, Object?> _singleAnswerSchema = {
  'type': 'object',
  'properties': {
    'relatedQuestionId': {'type': 'integer'},
    'aiGeneratedAnswerText': {'type': 'string'},
  },
  'required': ['relatedQuestionId', 'aiGeneratedAnswerText'],
  'additionalProperties': false,
};
