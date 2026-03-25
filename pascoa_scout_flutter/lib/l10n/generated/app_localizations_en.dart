// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get jobListOrderByHighestScore => 'Highest score';

  @override
  String get jobListOrderByHighestHourlyRate => 'Highest hourly rate';

  @override
  String get jobListOrderByLowestHourlyRate => 'Lowest hourly rate';

  @override
  String get jobListOrderByHighestFixedPrice => 'Highest fixed price';

  @override
  String get jobListOrderByLowestFixedPrice => 'Lowest fixed price';

  @override
  String get jobListOrderByNewestRelativeDate => 'Newest relative date';

  @override
  String get jobListOrderByNewestAbsoluteDate => 'Newest absolute date';

  @override
  String get jobListOrderByNewestPersistedJobs => 'Newest persisted jobs';

  @override
  String get jobListOrderByNewestGeneratedScores => 'Newest generated scores';

  @override
  String get jobListOrderByNewestAiResponses => 'Newest AI responses';

  @override
  String get jobListOrderByHighestClientHireRate => 'Highest client hire rate';

  @override
  String get jobListOrderByHighestClientAverageHourlyRate =>
      'Highest client avg hourly rate';

  @override
  String get jobListOrderByHighestClientNameConfidence =>
      'Highest client name confidence';

  @override
  String get jobListOrderByHighestClientRating => 'Highest client rating';

  @override
  String get jobListOrderByHighestClientTotalSpent =>
      'Highest client total spent';
}
