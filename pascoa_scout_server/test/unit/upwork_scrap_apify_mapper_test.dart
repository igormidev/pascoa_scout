import 'package:pascoa_scout_server/src/adapters/upwork_scrap_apify_mapper.dart';
import 'package:pascoa_scout_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('jobInfoFromApify budget parsing', () {
    test('preserves fixed-price amounts with thousands separators', () {
      final job = jobInfoFromApify({
        'id': '2037201467066404420',
        'subId': '~022037201467066404420',
        'url':
            'https://www.upwork.com/jobs/Cross-Platform-App-Developer-for-Food-Delivery-App_~022037201467066404420/',
        'title': 'Cross-Platform App Developer for Food Delivery App',
        'description': 'Build a food delivery app.',
        'budget': '\$2,000.00',
        'clientLocation': 'Switzerland',
        'clientName': null,
        'clientNameConfidence': null,
        'clientAvgHourlyRate': null,
        'clientRating': 4.99,
        'clientHireRatePercent': 33,
        'clientTotalSpent': 4967,
        'hasHired': false,
        'proposals': 58,
        'paymentVerified': true,
        'relativeDate': 'Posted 2 hours ago',
        'absoluteDate': '2026-03-26T16:14:14.167Z',
        'jobType': 'Fixed',
        'experienceLevel': 'Intermediate',
        'allowedApplicantCountries': null,
        'questions': const [],
        'tags': const [
          'Android',
          'iOS',
        ],
      });

      expect(job.jobType, JobType.fixed);
      expect(job.budget, '\$2,000.00');
      expect(job.fixedPriceAmount, 2000);
      expect(job.hourlyMinRate, isNull);
      expect(job.hourlyMaxRate, isNull);
    });

    test('parses hourly ranges without treating separators as negatives', () {
      final job = jobInfoFromApify({
        'id': 'job-hourly',
        'subId': '~job-hourly',
        'url': 'https://www.upwork.com/jobs/job-hourly/',
        'title': 'Flutter hourly contract',
        'description': 'Build a Flutter app.',
        'budget': '\$25.00-\$45.00',
        'clientLocation': 'Brazil',
        'paymentVerified': true,
        'relativeDate': 'Posted 10 minutes ago',
        'absoluteDate': '2026-03-26T16:14:14.167Z',
        'jobType': 'Hourly',
        'experienceLevel': 'Intermediate',
        'questions': const [],
        'tags': const [],
      });

      expect(job.jobType, JobType.hourly);
      expect(job.fixedPriceAmount, isNull);
      expect(job.hourlyMinRate, 25);
      expect(job.hourlyMaxRate, 45);
    });
  });
}
