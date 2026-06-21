import 'package:pascoa_scout_server/src/core/job_automation_constants.dart';
import 'package:pascoa_scout_server/src/core/pascoa_result.dart';
import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:pascoa_scout_server/src/services/job_ai_generation_service.dart';
import 'package:pascoa_scout_server/src/services/job_codex_service.dart';
import 'package:pascoa_scout_server/src/services/job_knowledge_service.dart';
import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('JobAiGenerationService', (sessionBuilder, _) {
    test(
      'preserves the full proposal prompt exactly',
      () async {
        final session = sessionBuilder.build();
        final codexService = _CapturingJobCodexService();
        final service = JobAiGenerationService(
          codexService: codexService,
          knowledgeService: _FakeJobKnowledgeService(),
        );

        final result = await service.generateProposalForAnalysis(
          session,
          analysis: _buildAnalysis(),
          aiModel: JobAutomationAiModel.gpt54,
          aiThinkingEffort: JobAutomationAiThinkingEffort.high,
        );

        expect(result.isError(), isTrue);
        expect(codexService.prompt, _expectedFullProposalPrompt);
      },
    );

    test(
      'preserves targeted proposal refresh prompts exactly',
      () async {
        final session = sessionBuilder.build();
        final coverLetterCodexService = _CapturingJobCodexService();
        final coverLetterService = JobAiGenerationService(
          codexService: coverLetterCodexService,
          knowledgeService: _FakeJobKnowledgeService(),
        );
        final answerCodexService = _CapturingJobCodexService();
        final answerService = JobAiGenerationService(
          codexService: answerCodexService,
          knowledgeService: _FakeJobKnowledgeService(),
        );
        final analysis = _buildAnalysisWithProposal();

        final coverLetterResult = await coverLetterService
            .generateProposalCoverLetterForAnalysis(
              session,
              analysis: analysis,
              aiModel: JobAutomationAiModel.gpt54,
              aiThinkingEffort: JobAutomationAiThinkingEffort.high,
            );
        final answerResult = await answerService
            .generateProposalAnswerForAnalysis(
              session,
              analysis: analysis,
              relatedQuestionId: 7001,
              aiModel: JobAutomationAiModel.gpt54,
              aiThinkingEffort: JobAutomationAiThinkingEffort.high,
            );

        expect(coverLetterResult.isError(), isTrue);
        expect(answerResult.isError(), isTrue);
        expect(coverLetterCodexService.prompt, _expectedCoverLetterPrompt);
        expect(answerCodexService.prompt, _expectedSingleAnswerPrompt);
      },
    );

    test(
      'generates a fixed-price manual proposal without persisting rows',
      () async {
        final session = sessionBuilder.build();
        final codexService = _CapturingJobCodexService(
          payload: {
            'aiGeneratedCoverLetterText': 'Manual cover letter.',
            'answers': const [],
            'milestones': const [
              {
                'title': 'Discovery and implementation plan',
                'description':
                    'Clarify requirements and prepare the delivery plan.',
                'suggestedPrice': 500,
              },
              {
                'title': 'Build and handoff',
                'description':
                    'Implement the agreed scope and hand off the result.',
                'suggestedPrice': 700,
              },
            ],
          },
        );
        final service = JobAiGenerationService(
          codexService: codexService,
          knowledgeService: _FakeJobKnowledgeService(),
        );

        final result = await service.generateManualProposal(
          session,
          request: ManualJobProposalRequest(
            title: 'Private Flutter invitation',
            description: 'Build an invited-only Flutter feature.',
            price: 1200,
            priceKind: ManualJobProposalPriceKind.fixed,
          ),
          aiModel: JobAutomationAiModel.gpt54,
          aiThinkingEffort: JobAutomationAiThinkingEffort.high,
        );

        final persistedProposals = await JobProposal.db.find(session);

        expect(result.isSuccess(), isTrue);
        final proposal = result.getOrThrow();
        expect(proposal.aiGeneratedCoverLetterText, 'Manual cover letter.');
        expect(proposal.milestones, hasLength(2));
        expect(
          proposal.milestones?.fold<double>(
            0,
            (total, milestone) => total + milestone.suggestedPrice,
          ),
          1200,
        );
        expect(persistedProposals, isEmpty);
        expect(codexService.enableWebSearch, isTrue);
        expect(
          codexService.prompt,
          contains(
            'Where the rules mention persisted job context, use the manual job file as the job context for this one-shot request.',
          ),
        );
        expect(
          codexService.prompt,
          contains(
            '- answers must be an empty list because no Upwork application questions were provided for this manual invitation.',
          ),
        );
        expect(
          codexService.prompt,
          isNot(contains('answers must contain one entry')),
        );
      },
    );
  });
}

class _CapturingJobCodexService extends JobCodexService {
  _CapturingJobCodexService({Map<String, dynamic>? payload})
    : _payload = payload;

  final Map<String, dynamic>? _payload;
  String? prompt;
  bool? enableWebSearch;

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
    this.prompt = prompt;
    this.enableWebSearch = enableWebSearch;
    final payload = _payload;
    if (payload != null) {
      return Success(payload);
    }

    return Failure(
      PascoaException(
        message: 'Stop after prompt capture',
        description: 'Used by tests to assert the generated prompt.',
      ),
    );
  }
}

class _FakeJobKnowledgeService extends JobKnowledgeService {
  @override
  Future<PascoaResult<JobKnowledgeBundle>> getKnowledgeBundle(
    Session session,
  ) async {
    final now = DateTime.utc(2026, 4, 18, 1);
    return Success(
      JobKnowledgeBundle(
        curriculum: JobCurriculumProfile(
          singletonKey: jobAutomationSingletonKey,
          markdownText:
              '# Curriculum\n- GitHub: https://github.com/igor\n- Built Flutter and backend systems for marketplace apps.',
          updatedAt: now,
        ),
        proposalStyle: JobProposalStylePreference(
          singletonKey: jobAutomationSingletonKey,
          markdownText: '# Proposal style\nBe concise, direct, and concrete.',
          updatedAt: now,
        ),
        opportunityPreference: JobOpportunityPreference(
          singletonKey: jobAutomationSingletonKey,
          markdownText:
              '# Opportunity preference\nPrefer mobile, marketplace, and Firebase-backed products.',
          updatedAt: now,
        ),
      ),
    );
  }
}

JobAnalysisState _buildAnalysis() {
  final question = Question(
    id: 7001,
    question: 'Include a link to your GitHub profile and/or website',
    positionIndex: 0,
  );
  final job = JobInfo(
    id: 501,
    upworkId: 'upwork-501',
    title: 'Flutter marketplace app',
    description: 'Build and maintain a marketplace mobile app.',
    url: 'https://www.upwork.com/jobs/~test',
    jobType: JobType.hourly,
    experienceLevel: ExperienceLevel.intermediate,
    paymentVerifiedStatus: PaymentVerifiedStatus.verified,
    allowedApplicantCountries: const [],
    tags: const ['Flutter', 'Firebase'],
    hasHired: true,
    questions: [question],
  );

  return JobAnalysisState(
    id: 9001,
    jobInfoId: job.id!,
    jobInfo: job,
    createdJobInfoAt: DateTime.utc(2026, 4, 18, 1),
  );
}

JobAnalysisState _buildAnalysisWithProposal() {
  return _buildAnalysis().copyWith(
    proposal: JobProposal(
      jobAnalysisStateId: 9001,
      aiGeneratedCoverLetterText: 'Existing cover letter.',
    ),
  );
}

const String _expectedFullProposalPrompt = '''
You are writing a tailored Upwork cover letter, question answers, and milestone suggestions for the freelancer.

Before responding, read these files completely and do not continue until you have read them all:
- @curriculum.md
- @proposal-style-preference.md
- @job-opportunity-preference.md
- @job.md


The job file is the canonical source for the contract type and compensation details.
If the project is fixed-price, you may do focused web research when it materially improves the milestone breakdown, such as validating sensible delivery phases, dependencies, or domain-specific implementation checkpoints. Keep any research tight and relevant to the actual job.

Return only structured JSON that matches the provided schema.
Rules:
- aiGeneratedCoverLetterText must sound like the freelancer described in the files.
- Base every statement on the freelancer files and the persisted job context.
- Reuse concrete facts from the freelancer files whenever relevant, such as shipped products, role scope, technologies, industries, outcomes, and links.
- Do not say information is unavailable, can be shared later, or can be provided on request when the freelancer files already contain usable evidence.
- If the freelancer files truly do not contain the requested fact, answer truthfully with the closest supported detail and do not invent credentials, years, metrics, or links.
- Every answer must be written from the freelancer's real background in the curriculum file, not as a generic template.
- If a question asks for a GitHub profile, portfolio, website, case study, or similar link, include the actual link present in the freelancer files when available.
- Each answer should be directly usable in the Upwork form, concise, specific, and should not repeat the raw question.
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

const String _expectedCoverLetterPrompt = '''
You are writing a tailored Upwork cover letter for the freelancer.

Before responding, read these files completely and do not continue until you have read them all:
- @curriculum.md
- @proposal-style-preference.md
- @job-opportunity-preference.md
- @job.md


The job file is the canonical source for the project scope, contract type, and compensation details.

Return only structured JSON that matches the provided schema.
Rules:
- aiGeneratedCoverLetterText must sound like the freelancer described in the files.
- Base every statement on the freelancer files and the persisted job context.
- Reuse concrete facts from the freelancer files whenever relevant, such as shipped products, role scope, technologies, industries, outcomes, and links.
- Do not say information is unavailable, can be shared later, or can be provided on request when the freelancer files already contain usable evidence.
- If the freelancer files truly do not contain the requested fact, answer truthfully with the closest supported detail and do not invent credentials, years, metrics, or links.
- The cover letter should be directly usable in Upwork, concise, specific, and tailored to this exact job.
''';

const String _expectedSingleAnswerPrompt = '''
You are writing one tailored Upwork question answer for the freelancer.

Before responding, read these files completely and do not continue until you have read them all:
- @curriculum.md
- @proposal-style-preference.md
- @job-opportunity-preference.md
- @job.md


Return only structured JSON that matches the provided schema.
Rules:
- Base every statement on the freelancer files and the persisted job context.
- Reuse concrete facts from the freelancer files whenever relevant, such as shipped products, role scope, technologies, industries, outcomes, and links.
- Do not say information is unavailable, can be shared later, or can be provided on request when the freelancer files already contain usable evidence.
- If the freelancer files truly do not contain the requested fact, answer truthfully with the closest supported detail and do not invent credentials, years, metrics, or links.
- Every answer must be written from the freelancer's real background in the curriculum file, not as a generic template.
- If a question asks for a GitHub profile, portfolio, website, case study, or similar link, include the actual link present in the freelancer files when available.
- Each answer should be directly usable in the Upwork form, concise, specific, and should not repeat the raw question.
- Return exactly one answer for the target question below.
- relatedQuestionId must be 7001.

Target question:
- Question 1 (relatedQuestionId: 7001): Include a link to your GitHub profile and/or website
''';
