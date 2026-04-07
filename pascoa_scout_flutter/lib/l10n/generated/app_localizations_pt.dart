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
  String jobAnalysisPostedMinutesAgo(int minutes) {
    return 'há $minutes min';
  }

  @override
  String jobAnalysisPostedHoursAgo(int hours) {
    return 'há $hours h';
  }

  @override
  String jobAnalysisPostedHoursAndMinutesAgo(int hours, int minutes) {
    return 'há $hours h e $minutes min';
  }

  @override
  String jobAnalysisPostedYesterdayAt(Object time) {
    return 'Ontem às $time';
  }

  @override
  String jobAnalysisPostedMonthDay(int day, Object month) {
    return '$day de $month';
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
  String get jobAnalysisGeneralStatsEditButton => 'Editar';

  @override
  String get jobAnalysisCopyStatTooltip => 'Copiar valor';

  @override
  String jobAnalysisGeneralStatsCopied(Object label) {
    return '$label copiado.';
  }

  @override
  String get jobAnalysisGeneralStatsEditorTitle =>
      'Personalizar estatísticas gerais';

  @override
  String get jobAnalysisGeneralStatsEditorDescription =>
      'Escolha quais estatísticas ficam visíveis e arraste para reordenar.';

  @override
  String get jobAnalysisGeneralStatsEditorResetButton => 'Redefinir';

  @override
  String get jobAnalysisGeneralStatsEditorCancelButton => 'Cancelar';

  @override
  String get jobAnalysisGeneralStatsEditorSaveButton => 'Salvar';

  @override
  String get jobAnalysisGeneralStatsSaveFailed =>
      'Não foi possível salvar a configuração das estatísticas gerais.';

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

  @override
  String get jobAnalysisAiAnswersReadyTooltip =>
      'Concluído. Respostas de IA geradas.';

  @override
  String get jobKnowledgeQuickActionsEditCurriculumButton =>
      'Alterar currículo';

  @override
  String get jobKnowledgeQuickActionsEditAnswerStyleButton =>
      'Alterar escrita da proposta';

  @override
  String get jobKnowledgeQuickActionsEditScoreLogicButton =>
      'Alterar lógica de pontuação da vaga';

  @override
  String get jobKnowledgeEditorCurriculumTitle => 'Currículo';

  @override
  String get jobKnowledgeEditorCurriculumDescription =>
      'Atualize o texto longo do currículo que a IA usa como contexto sobre suas habilidades, experiência e posicionamento.';

  @override
  String get jobKnowledgeEditorCurriculumInputLabel => 'Texto do currículo';

  @override
  String get jobKnowledgeEditorCurriculumSaved => 'Currículo atualizado.';

  @override
  String get jobKnowledgeEditorAnswerStyleTitle =>
      'Como você quer que as respostas sejam escritas';

  @override
  String get jobKnowledgeEditorAnswerStyleDescription =>
      'Atualize o tom, a estrutura, o nível de detalhe e as regras de escrita que devem orientar propostas e respostas geradas.';

  @override
  String get jobKnowledgeEditorAnswerStyleInputLabel =>
      'Preferência de estilo das respostas';

  @override
  String get jobKnowledgeEditorAnswerStyleSaved =>
      'Estilo das respostas atualizado.';

  @override
  String get jobKnowledgeEditorScoreLogicTitle =>
      'Como uma vaga deve ser pontuada';

  @override
  String get jobKnowledgeEditorScoreLogicDescription =>
      'Atualize os critérios que definem o que faz uma vaga valer o seu tempo, além dos sinais de alerta que devem reduzir a pontuação da IA.';

  @override
  String get jobKnowledgeEditorScoreLogicInputLabel =>
      'Lógica de pontuação da vaga';

  @override
  String get jobKnowledgeEditorScoreLogicSaved =>
      'Lógica de pontuação da vaga atualizada.';

  @override
  String get jobKnowledgeEditorLoadFailedTitle =>
      'Não foi possível carregar este texto';

  @override
  String get jobKnowledgeEditorRetryButton => 'Tentar novamente';

  @override
  String get jobKnowledgeEditorCancelButton => 'Cancelar';

  @override
  String get jobKnowledgeEditorSaveButton => 'Salvar';

  @override
  String get jobKnowledgeEditorSavingButton => 'Salvando…';

  @override
  String jobKnowledgeEditorCharacterHint(int minimum, int maximum) {
    return 'Mínimo de $minimum caracteres. Máximo de $maximum caracteres.';
  }

  @override
  String jobKnowledgeEditorValidationMin(int minimum) {
    return 'Adicione pelo menos $minimum caracteres antes de salvar.';
  }

  @override
  String jobKnowledgeEditorValidationMax(int maximum) {
    return 'Mantenha o texto abaixo de $maximum caracteres.';
  }
}
