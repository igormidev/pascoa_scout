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
      'grounds proposal answers in curriculum-backed prompt instructions',
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
        expect(
          codexService.prompt,
          contains(
            '- @job-opportunity-preference.md',
          ),
        );
        expect(
          codexService.prompt,
          contains(
            "Every answer must be written from the freelancer's real background in the curriculum file, not as a generic template.",
          ),
        );
        expect(
          codexService.prompt,
          contains(
            'If a question asks for a GitHub profile, portfolio, website, case study, or similar link, include the actual link present in the freelancer files when available.',
          ),
        );
        expect(
          codexService.prompt,
          contains(
            'Do not say information is unavailable, can be shared later, or can be provided on request when the freelancer files already contain usable evidence.',
          ),
        );
      },
    );
  });
}

class _CapturingJobCodexService extends JobCodexService {
  String? prompt;

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
