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
            logAutomation(
              session,
              'score',
              'no jobs are waiting for score generation',
            );
            return Success(0);
          }
          logAutomation(
            session,
            'score',
            'processing ${candidates.length} job(s) that are missing scores',
          );

          final results = await _orchestrator.runQueued(
            candidates.map(
              (candidate) =>
                  () => _withTaskSession<int>(
                    session,
                    (taskSession) => _generateScoreForAnalysis(
                      taskSession,
                      session,
                      candidate,
                      knowledge,
                      aiModel,
                      aiThinkingEffort,
                    ),
                  ),
            ),
            concurrency: maxConcurrentAiExecutions,
          );

          var successCount = 0;
          for (final result in results) {
            result.fold((_) => successCount += 1, (_) {});
          }
          logAutomation(
            session,
            'score',
            'completed $successCount/${results.length} score generation(s)',
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
            logAutomation(
              session,
              'proposal',
              'no jobs are waiting for proposal generation',
            );
            return Success(0);
          }
          logAutomation(
            session,
            'proposal',
            'processing ${candidates.length} job(s) that are missing proposals',
          );

          final results = await _orchestrator.runQueued(
            candidates.map(
              (candidate) =>
                  () => _withTaskSession<int>(
                    session,
                    (taskSession) => _generateProposalForAnalysis(
                      taskSession,
                      session,
                      candidate,
                      knowledge,
                      aiModel,
                      aiThinkingEffort,
                    ),
                  ),
            ),
            concurrency: maxConcurrentAiExecutions,
          );

          var successCount = 0;
          for (final result in results) {
            result.fold((_) => successCount += 1, (_) {});
          }
          logAutomation(
            session,
            'proposal',
            'completed $successCount/${results.length} proposal generation(s)',
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

  Future<PascoaResult<int>> _generateScoreForAnalysis(
    Session session,
    Session logSession,
    JobAnalysisState analysis,
    JobKnowledgeBundle knowledge,
    JobAutomationAiModel aiModel,
    JobAutomationAiThinkingEffort aiThinkingEffort,
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

The job file is the canonical human-formatted overview of the opportunity. It contains the full persisted job context, not just the description. Use the whole overview when scoring.

Return only structured JSON that matches the provided schema.
Scoring rules:
- scorePercentage must be an integer between 0 and 100 inclusive.
- Higher means a better match for skills, experience, and opportunity quality.
- aiScoreJustificationText must be concise, specific, and reference the strongest deciding factors from the job overview.
''';

      final generationResult = await _codexService.runStructuredJson(
        workingDirectory: workDirectory.path,
        prompt: prompt,
        schema: _scoreSchema,
        aiModel: aiModel,
        aiThinkingEffort: aiThinkingEffort,
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
              logAutomation(
                logSession,
                'score',
                '${formatAutomationAnalysisLabel(analysis)} score=${parsed.scorePercentage}',
              );

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
    Session logSession,
    JobAnalysisState analysis,
    JobKnowledgeBundle knowledge,
    JobAutomationAiModel aiModel,
    JobAutomationAiThinkingEffort aiThinkingEffort,
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
You are writing a tailored Upwork cover letter, question answers, and milestone suggestions for the freelancer.

Before responding, read these files completely and do not continue until you have read them all:
- @${curriculumFile.path.split('/').last}
- @${proposalStyleFile.path.split('/').last}
- @${jobFile.path.split('/').last}

The job file is the canonical source for the contract type and compensation details.
If the project is fixed-price, you may do focused web research when it materially improves the milestone breakdown, such as validating sensible delivery phases, dependencies, or domain-specific implementation checkpoints. Keep any research tight and relevant to the actual job.

Return only structured JSON that matches the provided schema.
Rules:
- aiGeneratedCoverLetterText must sound like the freelancer described in the files.
- answers must contain one entry for each job question listed in the job file.
- Each answer entry must use the exact relatedQuestionId from the job file.
- milestones must be null when the job type is hourly.
- For fixed-price jobs, milestones must be a non-empty ordered list of concrete payment checkpoints that break the work into sensible delivery phases.
- Each milestone must contain a concise title, a specific description of the deliverable or outcome, and a numeric suggestedPrice.
- When the job file provides a fixed price amount, the sum of all milestone suggestedPrice values must equal that amount exactly to the cent.
- If the fixed price amount is unavailable but the raw budget text still implies a range or target, infer a single reasonable bid total from the job context and make the milestone prices add up to that inferred total.
- Milestones should be tailored to the scope, reduce delivery risk, and avoid vague placeholders.
- If the scope is small, a single milestone is acceptable, but the pricing still must add up to the total bid.
''';

      final generationResult = await _codexService.runStructuredJson(
        workingDirectory: workDirectory.path,
        prompt: prompt,
        schema: _proposalSchema,
        aiModel: aiModel,
        aiThinkingEffort: aiThinkingEffort,
        enableWebSearch: true,
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
            analysis.jobInfo!,
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

                await JobAnalysisState.db.updateRow(
                  session,
                  analysis.copyWith(createdJobAiResponsesAt: now),
                  columns: (table) => [table.createdJobAiResponsesAt],
                  transaction: transaction,
                );
              });
              logAutomation(
                logSession,
                'proposal',
                '${formatAutomationAnalysisLabel(analysis)} answers=${parsed.answers.length} milestones=${parsed.milestones.length}',
              );

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
