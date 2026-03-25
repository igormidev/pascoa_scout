import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Job analysis ordering', (sessionBuilder, endpoints) {
    Future<void> seedRows() async {
      final session = sessionBuilder.build();
      final jobInfos = <JobInfo>[
        _buildJobInfo(
          suffix: 'alpha',
          relativeDateMinutes: 240,
          absoluteDateTime: DateTime.utc(2026, 3, 20, 12),
          fixedPriceAmount: 150,
          hourlyMinRate: 15,
          hourlyMaxRate: 25,
          clientHireRatePercent: 30,
          clientAvgHourlyRate: 45,
          clientNameConfidencePercent: 65,
          clientRating: 4.1,
          clientTotalSpent: 1200,
        ),
        _buildJobInfo(
          suffix: 'bravo',
          relativeDateMinutes: 45,
          absoluteDateTime: DateTime.utc(2026, 3, 22, 12),
          fixedPriceAmount: 325,
          hourlyMinRate: 35,
          hourlyMaxRate: 55,
          clientHireRatePercent: 52,
          clientAvgHourlyRate: 70,
          clientNameConfidencePercent: 90,
          clientRating: 4.8,
          clientTotalSpent: 5800,
        ),
        _buildJobInfo(
          suffix: 'charlie',
          relativeDateMinutes: 120,
          absoluteDateTime: DateTime.utc(2026, 3, 21, 12),
          fixedPriceAmount: 220,
          hourlyMinRate: 22,
          hourlyMaxRate: 40,
          clientHireRatePercent: 41,
          clientAvgHourlyRate: 58,
          clientNameConfidencePercent: 75,
          clientRating: 4.4,
          clientTotalSpent: 2600,
        ),
      ];

      final insertedInfos = await JobInfo.db.insert(session, jobInfos);
      final insertedStates = await JobAnalysisState.db.insert(session, [
        JobAnalysisState(
          jobInfoId: insertedInfos[0].id!,
          createdJobInfoAt: DateTime.utc(2026, 3, 20, 13),
          createdJobScoringAt: DateTime.utc(2026, 3, 20, 14),
          createdJobAiResponsesAt: DateTime.utc(2026, 3, 20, 16),
        ),
        JobAnalysisState(
          jobInfoId: insertedInfos[1].id!,
          createdJobInfoAt: DateTime.utc(2026, 3, 22, 13),
          createdJobScoringAt: DateTime.utc(2026, 3, 22, 18),
          createdJobAiResponsesAt: DateTime.utc(2026, 3, 22, 15),
        ),
        JobAnalysisState(
          jobInfoId: insertedInfos[2].id!,
          createdJobInfoAt: DateTime.utc(2026, 3, 21, 13),
          createdJobScoringAt: DateTime.utc(2026, 3, 21, 14),
          createdJobAiResponsesAt: DateTime.utc(2026, 3, 23, 9),
        ),
      ]);

      await JobScore.db.insert(session, [
        JobScore(
          jobAnalysisStateId: insertedStates[0].id!,
          scorePercentage: 62,
          aiScoreJustificationText: 'alpha',
        ),
        JobScore(
          jobAnalysisStateId: insertedStates[1].id!,
          scorePercentage: 94,
          aiScoreJustificationText: 'bravo',
        ),
        JobScore(
          jobAnalysisStateId: insertedStates[2].id!,
          scorePercentage: 78,
          aiScoreJustificationText: 'charlie',
        ),
      ]);
    }

    JobAnalysisListFilter buildFilter(JobAnalysisOrderBy orderBy) {
      return JobAnalysisListFilter(
        page: 1,
        pageSize: 10,
        analysisFilter: JobAnalysisFilterMode.all,
        orderBy: orderBy,
      );
    }

    Future<List<String>> titlesFor(JobAnalysisOrderBy orderBy) async {
      final page = await endpoints.jobAnalysis.getPage(
        sessionBuilder,
        filter: buildFilter(orderBy),
      );
      return page.items
          .map((item) => item.jobInfo?.title ?? '<missing>')
          .toList(growable: false);
    }

    test('returns the highest score first', () async {
      await seedRows();

      final titles = await titlesFor(JobAnalysisOrderBy.highestScore);

      expect(titles.first, 'bravo');
    });

    test(
      'keeps scoreless rows after scored rows when ordering by score',
      () async {
        await seedRows();
        final session = sessionBuilder.build();
        final scorelessInfo = await JobInfo.db.insertRow(
          session,
          _buildJobInfo(
            suffix: 'delta',
            relativeDateMinutes: 10,
            absoluteDateTime: DateTime.utc(2026, 3, 24, 12),
            fixedPriceAmount: 500,
            hourlyMinRate: 80,
            hourlyMaxRate: 100,
            clientHireRatePercent: 99,
            clientAvgHourlyRate: 120,
            clientNameConfidencePercent: 99,
            clientRating: 5,
            clientTotalSpent: 10000,
          ),
        );
        await JobAnalysisState.db.insertRow(
          session,
          JobAnalysisState(
            jobInfoId: scorelessInfo.id!,
            createdJobInfoAt: DateTime.utc(2026, 3, 24, 13),
            createdJobScoringAt: null,
            createdJobAiResponsesAt: null,
          ),
        );

        final titles = await titlesFor(JobAnalysisOrderBy.highestScore);

        expect(titles.take(3), ['bravo', 'charlie', 'alpha']);
        expect(titles.last, 'delta');
      },
    );

    test('returns the expected top job for every order mode', () async {
      await seedRows();

      final expectations = <JobAnalysisOrderBy, String>{
        JobAnalysisOrderBy.highestScore: 'bravo',
        JobAnalysisOrderBy.highestHourlyRate: 'bravo',
        JobAnalysisOrderBy.lowestHourlyRate: 'alpha',
        JobAnalysisOrderBy.highestFixedPrice: 'bravo',
        JobAnalysisOrderBy.lowestFixedPrice: 'alpha',
        JobAnalysisOrderBy.newestRelativeDate: 'bravo',
        JobAnalysisOrderBy.newestAbsoluteDate: 'bravo',
        JobAnalysisOrderBy.mostRecentJobInfoCreatedAt: 'bravo',
        JobAnalysisOrderBy.mostRecentScoringCreatedAt: 'bravo',
        JobAnalysisOrderBy.mostRecentAiResponsesCreatedAt: 'charlie',
        JobAnalysisOrderBy.highestClientHireRate: 'bravo',
        JobAnalysisOrderBy.highestClientAverageHourlyRate: 'bravo',
        JobAnalysisOrderBy.highestClientNameConfidence: 'bravo',
        JobAnalysisOrderBy.highestClientRating: 'bravo',
        JobAnalysisOrderBy.highestClientTotalSpent: 'bravo',
      };

      for (final entry in expectations.entries) {
        final titles = await titlesFor(entry.key);
        expect(
          titles.first,
          entry.value,
          reason: 'Unexpected first row for ${entry.key.name}',
        );
      }
    });
  });
}

JobInfo _buildJobInfo({
  required String suffix,
  required int relativeDateMinutes,
  required DateTime absoluteDateTime,
  required double fixedPriceAmount,
  required double hourlyMinRate,
  required double hourlyMaxRate,
  required double clientHireRatePercent,
  required double clientAvgHourlyRate,
  required double clientNameConfidencePercent,
  required double clientRating,
  required double clientTotalSpent,
}) {
  return JobInfo(
    upworkId: 'upwork-$suffix',
    title: suffix,
    description: 'description-$suffix',
    url: 'https://example.com/$suffix',
    relativeDate: '$relativeDateMinutes minutes ago',
    relativeDateMinutes: relativeDateMinutes,
    absoluteDate: absoluteDateTime.toIso8601String(),
    absoluteDateTime: absoluteDateTime,
    budget: '\$$fixedPriceAmount',
    fixedPriceAmount: fixedPriceAmount,
    hourlyMinRate: hourlyMinRate,
    hourlyMaxRate: hourlyMaxRate,
    jobType: JobType.hourly,
    experienceLevel: ExperienceLevel.intermediate,
    paymentVerifiedStatus: PaymentVerifiedStatus.verified,
    allowedApplicantCountries: [Country.brazil],
    clientName: 'Client $suffix',
    clientNameConfidencePercent: clientNameConfidencePercent,
    clientAvgHourlyRate: clientAvgHourlyRate,
    clientRating: clientRating,
    clientHireRatePercent: clientHireRatePercent,
    clientTotalSpent: clientTotalSpent,
    tags: ['tag-$suffix'],
    hasHired: true,
  );
}
