import 'dart:convert';
import 'dart:io';

import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';

import '../core/job_automation_constants.dart';
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

  Future<PascoaResult<int>> generateMissingScores(
    Session session, {
    required int limit,
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
            return Success(0);
          }

          final results = await _orchestrator.runQueued(
            candidates.map(
              (candidate) =>
                  () => _withTaskSession<int>(
                    session,
                    (taskSession) => _generateScoreForAnalysis(
                      taskSession,
                      candidate,
                      knowledge,
                    ),
                  ),
            ),
            concurrency: maxConcurrentAiExecutions,
          );

          var successCount = 0;
          for (final result in results) {
            result.fold((_) => successCount += 1, (_) {});
          }
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
            return Success(0);
          }

          final results = await _orchestrator.runQueued(
            candidates.map(
              (candidate) =>
                  () => _withTaskSession<int>(
                    session,
                    (taskSession) => _generateProposalForAnalysis(
                      taskSession,
                      candidate,
                      knowledge,
                    ),
                  ),
            ),
            concurrency: maxConcurrentAiExecutions,
          );

          var successCount = 0;
          for (final result in results) {
            result.fold((_) => successCount += 1, (_) {});
          }
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

  Future<PascoaResult<int>> _generateScoreForAnalysis(
    Session session,
    JobAnalysisState analysis,
    JobKnowledgeBundle knowledge,
  ) async {
    final validationError = _validateAnalysis(analysis);
    if (validationError != null) {
      return Failure(validationError);
    }

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

Return only structured JSON that matches the provided schema.
Scoring rules:
- scorePercentage must be an integer between 0 and 100 inclusive.
- Higher means a better match for skills, experience, and opportunity quality.
- aiScoreJustificationText must be concise, specific, and reference the strongest deciding factors.
''';

      final generationResult = await _codexService.runStructuredJson(
        workingDirectory: workDirectory.path,
        prompt: prompt,
        schema: _scoreSchema,
      );

      return await generationResult.fold(
        (payload) async {
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

              return Success(1);
            },
            (error) async => Failure(error),
          );
        },
        (error) async => Failure(error),
      );
    } catch (error, stackTrace) {
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

  Future<PascoaResult<int>> _generateProposalForAnalysis(
    Session session,
    JobAnalysisState analysis,
    JobKnowledgeBundle knowledge,
  ) async {
    final validationError = _validateAnalysis(analysis);
    if (validationError != null) {
      return Failure(validationError);
    }

    try {
      final workDirectory = await _prepareWorkDirectory(
        analysisId: analysis.id!,
        stageDirectoryName: 'proposal',
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

      final prompt =
          '''
You are writing a tailored Upwork cover letter and question answers for the freelancer.

Before responding, read these files completely and do not continue until you have read them all:
- @${curriculumFile.path.split('/').last}
- @${proposalStyleFile.path.split('/').last}
- @${jobFile.path.split('/').last}

Return only structured JSON that matches the provided schema.
Rules:
- aiGeneratedCoverLetterText must sound like the freelancer described in the files.
- answers must contain one entry for each job question listed in the job file.
- Each answer entry must use the exact relatedQuestionId from the job file.
''';

      final generationResult = await _codexService.runStructuredJson(
        workingDirectory: workDirectory.path,
        prompt: prompt,
        schema: _proposalSchema,
      );

      return await generationResult.fold(
        (payload) async {
          await _writeJsonPayload(
            workDirectory,
            'proposal-result.json',
            payload,
          );
          final parsedResult = _parseProposalPayload(
            payload,
            analysis.jobInfo?.questions ?? const <Question>[],
          );

          return await parsedResult.fold(
            (parsed) async {
              final now = DateTime.now().toUtc();
              await session.db.transaction((transaction) async {
                final currentProposal = await JobProposal.db.findFirstRow(
                  session,
                  where: (table) =>
                      table.jobAnalysisStateId.equals(analysis.id),
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

                await JobAnalysisState.db.updateRow(
                  session,
                  analysis.copyWith(createdJobAiResponsesAt: now),
                  columns: (table) => [table.createdJobAiResponsesAt],
                  transaction: transaction,
                );
              });

              return Success(1);
            },
            (error) async => Failure(error),
          );
        },
        (error) async => Failure(error),
      );
    } catch (error, stackTrace) {
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
    final buffer = StringBuffer()
      ..writeln('# Job context')
      ..writeln()
      ..writeln('- Job analysis id: ${analysis.id}')
      ..writeln('- Upwork id: ${job.upworkId}')
      ..writeln('- Title: ${job.title}')
      ..writeln('- URL: ${job.url}')
      ..writeln('- Relative date: ${job.relativeDate ?? '-'}')
      ..writeln('- Absolute date: ${job.absoluteDate ?? '-'}')
      ..writeln('- Job type: ${job.jobType.name}')
      ..writeln('- Experience level: ${job.experienceLevel.name}')
      ..writeln('- Budget: ${job.budget ?? '-'}')
      ..writeln('- Fixed price amount: ${job.fixedPriceAmount ?? '-'}')
      ..writeln('- Hourly min rate: ${job.hourlyMinRate ?? '-'}')
      ..writeln('- Hourly max rate: ${job.hourlyMaxRate ?? '-'}')
      ..writeln('- Client name: ${job.clientName ?? '-'}')
      ..writeln('- Client rating: ${job.clientRating ?? '-'}')
      ..writeln(
        '- Client hire rate percent: ${job.clientHireRatePercent ?? '-'}',
      )
      ..writeln('- Client avg hourly rate: ${job.clientAvgHourlyRate ?? '-'}')
      ..writeln('- Client total spent: ${job.clientTotalSpent ?? '-'}')
      ..writeln('- Tags: ${job.tags.join(', ')}')
      ..writeln('- Has hired before: ${job.hasHired}')
      ..writeln()
      ..writeln('## Description')
      ..writeln(job.description)
      ..writeln();

    if (includeScore && analysis.score != null) {
      buffer
        ..writeln('## Existing score')
        ..writeln('- Score percentage: ${analysis.score!.scorePercentage}')
        ..writeln(
          '- Justification: ${analysis.score!.aiScoreJustificationText}',
        )
        ..writeln();
    }

    buffer.writeln('## Questions');
    final questions = [
      ...?job.questions,
    ]..sort((left, right) => left.positionIndex.compareTo(right.positionIndex));
    if (questions.isEmpty) {
      buffer.writeln('No application questions.');
    } else {
      for (final question in questions) {
        buffer.writeln('- [${question.id}] ${question.question}');
      }
    }

    return _writeFile(workDirectory, 'job.md', buffer.toString());
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
    List<Question> questions,
  ) {
    final coverLetter = payload['aiGeneratedCoverLetterText'];
    final answersRaw = payload['answers'];
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
      ),
    );
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

class _ParsedProposalPayload {
  const _ParsedProposalPayload({
    required this.coverLetter,
    required this.answers,
  });

  final String coverLetter;
  final List<_ParsedProposalAnswer> answers;
}

class _ParsedProposalAnswer {
  const _ParsedProposalAnswer({
    required this.relatedQuestionId,
    required this.answerText,
  });

  final int relatedQuestionId;
  final String answerText;
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
  },
  'required': ['aiGeneratedCoverLetterText', 'answers'],
  'additionalProperties': false,
};
