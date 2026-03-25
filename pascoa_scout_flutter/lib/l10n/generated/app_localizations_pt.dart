// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get jobListOrderByHighestScore => 'Maior pontuação';

  @override
  String get jobListOrderByHighestHourlyRate => 'Maior valor por hora';

  @override
  String get jobListOrderByLowestHourlyRate => 'Menor valor por hora';

  @override
  String get jobListOrderByHighestFixedPrice => 'Maior preço fixo';

  @override
  String get jobListOrderByLowestFixedPrice => 'Menor preço fixo';

  @override
  String get jobListOrderByNewestRelativeDate => 'Data relativa mais recente';

  @override
  String get jobListOrderByNewestAbsoluteDate => 'Data absoluta mais recente';

  @override
  String get jobListOrderByNewestPersistedJobs =>
      'Vagas persistidas mais recentes';

  @override
  String get jobListOrderByNewestGeneratedScores =>
      'Pontuações geradas mais recentes';

  @override
  String get jobListOrderByNewestAiResponses => 'Respostas de IA mais recentes';

  @override
  String get jobListOrderByHighestClientHireRate =>
      'Maior taxa de contratação do cliente';

  @override
  String get jobListOrderByHighestClientAverageHourlyRate =>
      'Maior média por hora do cliente';

  @override
  String get jobListOrderByHighestClientNameConfidence =>
      'Maior confiança no nome do cliente';

  @override
  String get jobListOrderByHighestClientRating => 'Maior avaliação do cliente';

  @override
  String get jobListOrderByHighestClientTotalSpent =>
      'Maior total gasto pelo cliente';
}
