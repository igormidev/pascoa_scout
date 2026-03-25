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

  @override
  String jobAnalysisHourlyFromLabel(Object amount) {
    return 'A partir de $amount';
  }

  @override
  String jobAnalysisHourlyUpToLabel(Object amount) {
    return 'Até $amount';
  }

  @override
  String get jobAnalysisUnavailableValue => '-';

  @override
  String jobAnalysisQuestionsChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count perguntas',
      one: '1 pergunta',
      zero: '0 perguntas',
    );
    return '$_temp0';
  }

  @override
  String jobAnalysisHireChip(Object percent) {
    return 'Contratação $percent';
  }

  @override
  String get jobAnalysisYesValue => 'Sim';

  @override
  String get jobAnalysisNoValue => 'Não';

  @override
  String get jobAnalysisPaymentStatusUnknown => 'Desconhecido';

  @override
  String get jobAnalysisPaymentStatusVerified => 'Verificado';

  @override
  String get jobAnalysisPaymentStatusUnverified => 'Não verificado';

  @override
  String get jobAnalysisDescriptionSectionTitle => 'Descrição';

  @override
  String get jobAnalysisCopyDescriptionTooltip => 'Copiar descrição';

  @override
  String get jobAnalysisDescriptionCopied => 'Descrição copiada.';

  @override
  String get jobAnalysisViewMore => 'Ver mais';

  @override
  String get jobAnalysisViewLess => 'Ver menos';

  @override
  String get jobAnalysisGeneralStatsSectionTitle => 'Estatísticas gerais';

  @override
  String get jobAnalysisQuestionsSectionTitle => 'Perguntas da vaga';

  @override
  String jobAnalysisQuestionTitle(int index) {
    return 'Pergunta $index';
  }

  @override
  String get jobAnalysisCopyQuestionTooltip => 'Copiar pergunta';

  @override
  String get jobAnalysisQuestionCopied => 'Pergunta copiada.';

  @override
  String get jobAnalysisAiCompatibilitySectionTitle =>
      'Explicação de compatibilidade da IA';

  @override
  String get jobAnalysisCopyAiCompatibilityTooltip =>
      'Copiar explicação de compatibilidade da IA';

  @override
  String get jobAnalysisAiCompatibilityCopied =>
      'Explicação de compatibilidade da IA copiada.';

  @override
  String get jobAnalysisCoverLetterSectionTitle =>
      'Carta de apresentação gerada por IA';

  @override
  String get jobAnalysisCopyCoverLetterTooltip =>
      'Copiar carta de apresentação';

  @override
  String get jobAnalysisCoverLetterCopied => 'Carta de apresentação copiada.';

  @override
  String get jobAnalysisAiAnswersSectionTitle => 'Respostas geradas por IA';

  @override
  String get jobAnalysisAnswerFallbackTitle => 'Resposta gerada';

  @override
  String get jobAnalysisCopyAnswerTooltip => 'Copiar resposta';

  @override
  String get jobAnalysisAnswerCopied => 'Resposta copiada.';

  @override
  String get jobAnalysisUpworkIdLabel => 'ID da Upwork';

  @override
  String get jobAnalysisSubIdLabel => 'Sub ID';

  @override
  String get jobAnalysisJobUrlLabel => 'URL da vaga';

  @override
  String get jobAnalysisRelativeDateLabel => 'Data relativa';

  @override
  String get jobAnalysisRelativeDateMinutesLabel => 'Data relativa (minutos)';

  @override
  String get jobAnalysisAbsoluteDateLabel => 'Data absoluta';

  @override
  String get jobAnalysisAbsoluteDateTimeLabel => 'Data e hora absolutas';

  @override
  String get jobAnalysisBudgetLabel => 'Orçamento';

  @override
  String get jobAnalysisCompensationLabel => 'Remuneração';

  @override
  String get jobAnalysisFixedPriceAmountLabel => 'Valor de preço fixo';

  @override
  String get jobAnalysisHourlyMinLabel => 'Mínimo por hora';

  @override
  String get jobAnalysisHourlyMaxLabel => 'Máximo por hora';

  @override
  String get jobAnalysisJobTypeLabel => 'Tipo de vaga';

  @override
  String get jobAnalysisExperienceLabel => 'Experiência';

  @override
  String get jobAnalysisPaymentVerifiedLabel => 'Pagamento verificado';

  @override
  String get jobAnalysisAllowedCountriesLabel =>
      'Países permitidos para candidatura';

  @override
  String get jobAnalysisClientNameLabel => 'Nome do cliente';

  @override
  String get jobAnalysisClientNameConfidenceLabel =>
      'Confiança no nome do cliente';

  @override
  String get jobAnalysisClientAverageHourlyRateLabel =>
      'Média por hora do cliente';

  @override
  String get jobAnalysisClientRatingLabel => 'Avaliação do cliente';

  @override
  String jobAnalysisClientRatingValue(Object rating) {
    return '$rating / 5';
  }

  @override
  String get jobAnalysisClientHireRateLabel => 'Taxa de contratação do cliente';

  @override
  String get jobAnalysisClientTotalSpentLabel => 'Total gasto pelo cliente';

  @override
  String get jobAnalysisClientCountryLabel => 'País do cliente';

  @override
  String get jobAnalysisClientRegionLabel => 'Região do cliente';

  @override
  String get jobAnalysisClientSubRegionLabel => 'Sub-região do cliente';

  @override
  String get jobAnalysisTagsLabel => 'Tags';

  @override
  String get jobAnalysisHasHiredLabel => 'Já contratou';

  @override
  String get jobAnalysisQuestionCountLabel => 'Quantidade de perguntas';

  @override
  String get jobAnalysisPersistedAtLabel => 'Vaga persistida em';

  @override
  String get jobAnalysisScoreGeneratedAtLabel => 'Pontuação gerada em';

  @override
  String get jobAnalysisAiResponsesGeneratedAtLabel =>
      'Respostas de IA geradas em';

  @override
  String get jobAnalysisInvalidUrlMessage => 'A URL da vaga é inválida.';

  @override
  String get jobAnalysisUnableToOpenJobMessage =>
      'Não foi possível abrir esta vaga da Upwork.';

  @override
  String get jobAnalysisBackToFiltersButton => 'Voltar aos filtros';

  @override
  String get jobAnalysisViewJobButton => 'Ver vaga';

  @override
  String get jobAnalysisNoClientRatingValue => 'Sem dados';
}
