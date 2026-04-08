import 'package:pascoa_scout_server/src/core/pascoa_result.dart';
import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:pascoa_scout_server/src/repository/get_upwork_jobs_repository.dart';
import 'package:pascoa_scout_server/src/services/job_upwork_sync_service.dart';
import 'package:result_dart/result_dart.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('JobUpworkSyncService', (sessionBuilder, _) {
    test(
      'keeps proposal rows when the synchronized questions are unchanged',
      () async {
        final session = sessionBuilder.build();
        final seeded = await _seedJobWithProposal(
          session,
          questionTexts: const [
            'What is your experience?',
            'Can you start today?',
          ],
        );
        final service = JobUpworkSyncService(
          repository: _FakeUpworkJobsRepository([
            _buildJobInfo(
              upworkId: seeded.jobInfo.upworkId,
              title: 'Updated title',
              questionTexts: const [
                'What is your experience?',
                'Can you start today?',
              ],
            ),
          ]),
        );

        final result = await service.syncLatestJobs(
          session,
          filter: JobFilter(searchQueryTerm: 'flutter'),
          resultsPerPage: 1,
        );

        expect(result.fold((value) => value, (error) => throw error), 1);

        final refreshedJob = await JobInfo.db.findById(
          session,
          seeded.jobInfo.id!,
        );
        final refreshedState = await JobAnalysisState.db.findById(
          session,
          seeded.analysisState.id!,
        );
        final refreshedQuestions = await Question.db.find(
          session,
          where: (table) => table.jobInfoId.equals(seeded.jobInfo.id!),
          orderBy: (table) => table.positionIndex,
        );
        final refreshedProposal = await JobProposal.db.findById(
          session,
          seeded.proposal.id!,
        );
        final refreshedAnswers = await JobProposalAnswerToQuestion.db.find(
          session,
          where: (table) => table.jobProposalId.equals(seeded.proposal.id!),
          orderBy: (table) => table.relatedQuestionId,
        );
        final refreshedMilestones = await JobProposalMilestone.db.find(
          session,
          where: (table) => table.jobProposalId.equals(seeded.proposal.id!),
          orderBy: (table) => table.positionIndex,
        );

        expect(refreshedJob?.title, 'Updated title');
        expect(
          refreshedQuestions.map((question) => question.id).toList(),
          seeded.questions.map((question) => question.id).toList(),
        );
        expect(refreshedProposal?.id, seeded.proposal.id);
        expect(refreshedAnswers, hasLength(2));
        expect(refreshedMilestones, hasLength(2));
        expect(
          refreshedAnswers.map((answer) => answer.relatedQuestionId).toList(),
          seeded.questions.map((question) => question.id).toList(),
        );
        expect(
          refreshedMilestones.map((milestone) => milestone.id).toList(),
          seeded.milestones.map((milestone) => milestone.id).toList(),
        );
        expect(
          refreshedState?.createdJobAiResponsesAt,
          seeded.analysisState.createdJobAiResponsesAt,
        );
      },
    );

    test(
      'invalidates proposal rows when the synchronized questions change',
      () async {
        final session = sessionBuilder.build();
        final seeded = await _seedJobWithProposal(
          session,
          questionTexts: const [
            'What is your experience?',
            'Can you start today?',
          ],
        );
        final service = JobUpworkSyncService(
          repository: _FakeUpworkJobsRepository([
            _buildJobInfo(
              upworkId: seeded.jobInfo.upworkId,
              title: seeded.jobInfo.title,
              questionTexts: const [
                'What is your experience with Riverpod?',
                'Can you start today?',
                'How do you handle testing?',
              ],
            ),
          ]),
        );

        final result = await service.syncLatestJobs(
          session,
          filter: JobFilter(searchQueryTerm: 'flutter'),
          resultsPerPage: 1,
        );

        expect(result.fold((value) => value, (error) => throw error), 1);

        final refreshedState = await JobAnalysisState.db.findById(
          session,
          seeded.analysisState.id!,
        );
        final refreshedQuestions = await Question.db.find(
          session,
          where: (table) => table.jobInfoId.equals(seeded.jobInfo.id!),
          orderBy: (table) => table.positionIndex,
        );
        final refreshedProposal = await JobProposal.db.findById(
          session,
          seeded.proposal.id!,
        );
        final remainingAnswers = await JobProposalAnswerToQuestion.db.find(
          session,
          where: (table) => table.jobProposalId.equals(seeded.proposal.id!),
        );
        final remainingMilestones = await JobProposalMilestone.db.find(
          session,
          where: (table) => table.jobProposalId.equals(seeded.proposal.id!),
        );

        expect(refreshedProposal, isNull);
        expect(remainingAnswers, isEmpty);
        expect(remainingMilestones, isEmpty);
        expect(refreshedState?.createdJobAiResponsesAt, isNull);
        expect(
          refreshedQuestions.map((question) => question.question).toList(),
          const [
            'What is your experience with Riverpod?',
            'Can you start today?',
            'How do you handle testing?',
          ],
        );
        expect(refreshedQuestions[0].id, seeded.questions[0].id);
        expect(refreshedQuestions[1].id, seeded.questions[1].id);
        expect(
          seeded.questions.map((question) => question.id),
          isNot(contains(refreshedQuestions[2].id)),
        );
      },
    );
  });
}

class _FakeUpworkJobsRepository implements IGetUpworkJobsRepository {
  const _FakeUpworkJobsRepository(this.jobs);

  final List<JobInfo> jobs;

  @override
  Future<PascoaResult<List<JobInfo>>> getJobs({
    required JobFilter filter,
    required Pagination pagination,
  }) async {
    return Success(jobs);
  }
}

class _SeededJobData {
  const _SeededJobData({
    required this.jobInfo,
    required this.analysisState,
    required this.questions,
    required this.proposal,
    required this.milestones,
  });

  final JobInfo jobInfo;
  final JobAnalysisState analysisState;
  final List<Question> questions;
  final JobProposal proposal;
  final List<JobProposalMilestone> milestones;
}

Future<_SeededJobData> _seedJobWithProposal(
  Session session, {
  required List<String> questionTexts,
}) async {
  final insertedJob = await JobInfo.db.insertRow(
    session,
    _buildJobInfo(
      upworkId: 'upwork-123',
      title: 'Original title',
      questionTexts: questionTexts,
    ).copyWith(questions: null, analysisState: null),
  );
  final insertedState = await JobAnalysisState.db.insertRow(
    session,
    JobAnalysisState(
      jobInfoId: insertedJob.id!,
      createdJobInfoAt: DateTime.utc(2026, 3, 25, 18),
      createdJobAiResponsesAt: DateTime.utc(2026, 3, 25, 19),
    ),
  );
  final insertedQuestions = await Question.db.insert(
    session,
    [
      for (var index = 0; index < questionTexts.length; index++)
        Question(
          question: questionTexts[index],
          positionIndex: index,
          jobInfoId: insertedJob.id!,
        ),
    ],
  );
  final insertedProposal = await JobProposal.db.insertRow(
    session,
    JobProposal(
      jobAnalysisStateId: insertedState.id!,
      aiGeneratedCoverLetterText: 'Cover letter',
    ),
  );
  await JobProposalAnswerToQuestion.db.insert(
    session,
    [
      for (final question in insertedQuestions)
        JobProposalAnswerToQuestion(
          jobProposalId: insertedProposal.id!,
          relatedQuestionId: question.id!,
          aiGeneratedAnswerText: 'Answer for ${question.question}',
        ),
    ],
  );
  final insertedMilestones = await JobProposalMilestone.db.insert(
    session,
    [
      JobProposalMilestone(
        jobProposalId: insertedProposal.id!,
        positionIndex: 0,
        title: 'Discovery and architecture',
        description: 'Refine requirements and lock the implementation plan.',
        suggestedPrice: 200,
      ),
      JobProposalMilestone(
        jobProposalId: insertedProposal.id!,
        positionIndex: 1,
        title: 'Delivery and handoff',
        description: 'Implement the scope and hand over the final deliverable.',
        suggestedPrice: 300,
      ),
    ],
  );

  return _SeededJobData(
    jobInfo: insertedJob,
    analysisState: insertedState,
    questions: insertedQuestions,
    proposal: insertedProposal,
    milestones: insertedMilestones,
  );
}

JobInfo _buildJobInfo({
  required String upworkId,
  required String title,
  required List<String> questionTexts,
}) {
  return JobInfo(
    upworkId: upworkId,
    subId: 'sub-$upworkId',
    title: title,
    description: 'Build a Flutter dashboard',
    url: 'https://www.upwork.com/jobs/$upworkId',
    relativeDate: '10 minutes ago',
    relativeDateMinutes: 10,
    absoluteDate: DateTime.utc(2026, 3, 25, 17).toIso8601String(),
    absoluteDateTime: DateTime.utc(2026, 3, 25, 17),
    budget: '\$500',
    fixedPriceAmount: 500,
    hourlyMinRate: 25,
    hourlyMaxRate: 45,
    jobType: JobType.hourly,
    experienceLevel: ExperienceLevel.intermediate,
    clientLocation: ClientLocation(country: Country.brazil),
    paymentVerifiedStatus: PaymentVerifiedStatus.verified,
    allowedApplicantCountries: const [Country.brazil],
    clientName: 'Client',
    clientNameConfidencePercent: 90,
    clientAvgHourlyRate: 60,
    clientRating: 4.9,
    clientHireRatePercent: 80,
    clientTotalSpent: 20000,
    tags: const ['flutter', 'riverpod'],
    hasHired: true,
    questions: [
      for (var index = 0; index < questionTexts.length; index++)
        Question(
          question: questionTexts[index],
          positionIndex: index,
        ),
    ],
  );
}
