import 'package:pascoa_scout_server/src/core/job_automation_constants.dart';
import 'package:pascoa_scout_server/src/core/pascoa_result.dart';
import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:pascoa_scout_server/src/services/job_ai_generation_service.dart';
import 'package:pascoa_scout_server/src/services/job_analysis_query_service.dart';
import 'package:pascoa_scout_server/src/services/job_codex_service.dart';
import 'package:pascoa_scout_server/src/services/job_knowledge_service.dart';
import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('JobAiGeneration partial refresh', (sessionBuilder, _) {
    test(
      'regenerating the cover letter updates only the cover letter row',
      () async {
        final session = sessionBuilder.build();
        final scenario = await _insertScenario(session);
        final queryService = JobAnalysisQueryService();
        final initialAnalysisResult = await queryService.getById(
          session,
          jobAnalysisStateId: scenario.analysisId,
        );
        final initialAnalysis = initialAnalysisResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final service = JobAiGenerationService(
          codexService: const _PartialRefreshCodexService(),
          knowledgeService: _FakeJobKnowledgeService(),
        );

        final result = await service.generateProposalCoverLetterForAnalysis(
          session,
          analysis: initialAnalysis,
          aiModel: JobAutomationAiModel.gpt54,
          aiThinkingEffort: JobAutomationAiThinkingEffort.medium,
        );

        expect(result.isSuccess(), isTrue);

        final refreshedAnalysisResult = await queryService.getById(
          session,
          jobAnalysisStateId: scenario.analysisId,
        );
        final refreshedAnalysis = refreshedAnalysisResult.fold(
          (value) => value,
          (error) => throw error,
        );

        expect(
          refreshedAnalysis.proposal?.aiGeneratedCoverLetterText,
          'Updated cover letter from targeted refresh.',
        );
        expect(
          refreshedAnalysis.proposal?.answers?.length,
          2,
        );
        expect(
          refreshedAnalysis.proposal?.answers
              ?.firstWhere(
                (answer) => answer.relatedQuestionId == scenario.questionOneId,
              )
              .aiGeneratedAnswerText,
          'Original answer one.',
        );
        expect(refreshedAnalysis.createdJobAiResponsesAt, isNotNull);
      },
    );

    test(
      'regenerating one answer updates only the target answer row',
      () async {
        final session = sessionBuilder.build();
        final scenario = await _insertScenario(session);
        final queryService = JobAnalysisQueryService();
        final initialAnalysisResult = await queryService.getById(
          session,
          jobAnalysisStateId: scenario.analysisId,
        );
        final initialAnalysis = initialAnalysisResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final service = JobAiGenerationService(
          codexService: const _PartialRefreshCodexService(),
          knowledgeService: _FakeJobKnowledgeService(),
        );

        final result = await service.generateProposalAnswerForAnalysis(
          session,
          analysis: initialAnalysis,
          relatedQuestionId: scenario.questionOneId,
          aiModel: JobAutomationAiModel.gpt54,
          aiThinkingEffort: JobAutomationAiThinkingEffort.medium,
        );

        expect(result.isSuccess(), isTrue);

        final refreshedAnalysisResult = await queryService.getById(
          session,
          jobAnalysisStateId: scenario.analysisId,
        );
        final refreshedAnalysis = refreshedAnalysisResult.fold(
          (value) => value,
          (error) => throw error,
        );
        final refreshedAnswers =
            refreshedAnalysis.proposal?.answers ?? const [];

        expect(
          refreshedAnalysis.proposal?.aiGeneratedCoverLetterText,
          'Original cover letter.',
        );
        expect(
          refreshedAnswers
              .firstWhere(
                (answer) => answer.relatedQuestionId == scenario.questionOneId,
              )
              .aiGeneratedAnswerText,
          'Updated answer from targeted refresh.',
        );
        expect(
          refreshedAnswers
              .firstWhere(
                (answer) => answer.relatedQuestionId == scenario.questionTwoId,
              )
              .aiGeneratedAnswerText,
          'Original answer two.',
        );
        expect(refreshedAnalysis.createdJobAiResponsesAt, isNotNull);
      },
    );
  });
}

class _PartialRefreshCodexService extends JobCodexService {
  const _PartialRefreshCodexService();

  @override
  Future<PascoaResult<Map<String, dynamic>>> runStructuredJson({
    required String workingDirectory,
    required String prompt,
    required Map<String, Object?> schema,
    required JobAutomationAiModel aiModel,
    required JobAutomationAiThinkingEffort aiThinkingEffort,
    bool enableWebSearch = false,
    Duration? timeout,
  }) async {
    final properties = Map<String, Object?>.from(
      schema['properties']! as Map<Object?, Object?>,
    );

    if (properties.length == 1 &&
        properties.containsKey('aiGeneratedCoverLetterText')) {
      return Success({
        'aiGeneratedCoverLetterText':
            'Updated cover letter from targeted refresh.',
      });
    }

    if (properties.containsKey('relatedQuestionId') &&
        properties.containsKey('aiGeneratedAnswerText')) {
      final match = RegExp(
        r'relatedQuestionId must be (\d+)',
      ).firstMatch(prompt);
      final questionId = int.parse(match!.group(1)!);
      return Success({
        'relatedQuestionId': questionId,
        'aiGeneratedAnswerText': 'Updated answer from targeted refresh.',
      });
    }

    return Failure(
      PascoaException(
        message: 'Unexpected schema in test codex service',
        description:
            'The targeted refresh test received an unsupported schema.',
      ),
    );
  }
}

class _FakeJobKnowledgeService extends JobKnowledgeService {
  @override
  Future<PascoaResult<JobKnowledgeBundle>> getKnowledgeBundle(
    Session session,
  ) async {
    final now = DateTime.utc(2026, 4, 18, 2);
    return Success(
      JobKnowledgeBundle(
        curriculum: JobCurriculumProfile(
          singletonKey: jobAutomationSingletonKey,
          markdownText:
              '# Curriculum\n- GitHub: https://github.com/igor\n- Built mobile marketplace and backend systems.',
          updatedAt: now,
        ),
        proposalStyle: JobProposalStylePreference(
          singletonKey: jobAutomationSingletonKey,
          markdownText: '# Proposal style\nBe concise, concrete, and direct.',
          updatedAt: now,
        ),
        opportunityPreference: JobOpportunityPreference(
          singletonKey: jobAutomationSingletonKey,
          markdownText:
              '# Opportunity preference\nPrefer Flutter, Firebase, and marketplace work.',
          updatedAt: now,
        ),
      ),
    );
  }
}

class _ScenarioIds {
  const _ScenarioIds({
    required this.analysisId,
    required this.questionOneId,
    required this.questionTwoId,
  });

  final int analysisId;
  final int questionOneId;
  final int questionTwoId;
}

Future<_ScenarioIds> _insertScenario(Session session) async {
  final insertedJob = await JobInfo.db.insertRow(
    session,
    JobInfo(
      upworkId: 'upwork-refresh-${DateTime.now().microsecondsSinceEpoch}',
      title: 'Refresh targeted proposal content',
      description: 'Need help with a Flutter marketplace app.',
      url: 'https://www.upwork.com/jobs/~refresh',
      jobType: JobType.hourly,
      experienceLevel: ExperienceLevel.intermediate,
      paymentVerifiedStatus: PaymentVerifiedStatus.verified,
      allowedApplicantCountries: const [],
      tags: const ['Flutter', 'Firebase'],
      hasHired: true,
    ),
  );

  final insertedQuestions = await Question.db.insert(
    session,
    [
      Question(
        question: 'Include a link to your GitHub profile and/or website',
        positionIndex: 0,
        jobInfoId: insertedJob.id,
      ),
      Question(
        question: 'Describe your recent experience with similar projects',
        positionIndex: 1,
        jobInfoId: insertedJob.id,
      ),
    ],
  );

  final insertedAnalysis = await JobAnalysisState.db.insertRow(
    session,
    JobAnalysisState(
      jobInfoId: insertedJob.id!,
      createdJobInfoAt: DateTime.utc(2026, 4, 18, 2),
    ),
  );

  final insertedProposal = await JobProposal.db.insertRow(
    session,
    JobProposal(
      jobAnalysisStateId: insertedAnalysis.id!,
      aiGeneratedCoverLetterText: 'Original cover letter.',
    ),
  );

  await JobProposalAnswerToQuestion.db.insert(
    session,
    [
      JobProposalAnswerToQuestion(
        jobProposalId: insertedProposal.id!,
        relatedQuestionId: insertedQuestions.first.id!,
        aiGeneratedAnswerText: 'Original answer one.',
      ),
      JobProposalAnswerToQuestion(
        jobProposalId: insertedProposal.id!,
        relatedQuestionId: insertedQuestions.last.id!,
        aiGeneratedAnswerText: 'Original answer two.',
      ),
    ],
  );

  return _ScenarioIds(
    analysisId: insertedAnalysis.id!,
    questionOneId: insertedQuestions.first.id!,
    questionTwoId: insertedQuestions.last.id!,
  );
}
