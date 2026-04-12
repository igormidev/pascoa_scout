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

  @override
  String get jobListLiveRefreshSettingTitle => 'Live refresh job list';

  @override
  String get jobListLiveRefreshSettingToggle => 'Enable';

  @override
  String get jobListLiveRefreshSettingDisabledDescription =>
      'Keeps the job list on manual refresh only.';

  @override
  String jobListLiveRefreshSettingEnabledDescription(int seconds) {
    return 'Refreshes the job list every $seconds seconds while the automation loop is running.';
  }

  @override
  String get jobListHeaderTitle => 'Job matches';

  @override
  String get jobListHeaderDescription =>
      'Search persisted analyses, inspect scores and AI-generated responses, and refresh only the rows that are still incomplete.';

  @override
  String get jobListManualFetchButton => 'Manual fetch';

  @override
  String get jobListManualFetchDialogTitle => 'Manual fetch';

  @override
  String get jobListManualFetchDialogDescription =>
      'Paste an Upwork search link to fetch and persist the jobs from that URL immediately.';

  @override
  String get jobListManualFetchFieldLabel => 'Upwork search link';

  @override
  String get jobListManualFetchFieldHint =>
      'https://www.upwork.com/nx/search/jobs/...';

  @override
  String get jobListManualFetchCancelButton => 'Cancel';

  @override
  String get jobListManualFetchSubmitButton => 'Fetch jobs';

  @override
  String get jobListManualFetchSubmittingButton => 'Fetching...';

  @override
  String get jobListManualFetchValidationRequired =>
      'Paste an Upwork search link before fetching.';

  @override
  String get jobListManualFetchValidationInvalid =>
      'Use an Upwork search link from upwork.com that contains \"nx/search/jobs\".';

  @override
  String get jobListManualFetchSuccess =>
      'Manual fetch completed and the list was refreshed.';

  @override
  String get jobAutomationAiSettingsTitle => 'AI generation';

  @override
  String get jobAutomationAiSettingsDescription =>
      'Choose the Codex model and thinking effort used for scoring and proposal generation.';

  @override
  String get jobAutomationAiModelLabel => 'Model';

  @override
  String get jobAutomationAiModelGpt54 => 'GPT-5.4';

  @override
  String get jobAutomationAiModelGpt54Mini => 'GPT-5.4 mini';

  @override
  String get jobAutomationThinkingEffortTitle => 'Thinking effort';

  @override
  String jobAutomationThinkingEffortDescription(Object model) {
    return 'Controls the Codex model profile used for scoring and proposal generation. Current model: $model.';
  }

  @override
  String get jobAutomationThinkingEffortLow => 'Low';

  @override
  String get jobAutomationThinkingEffortMedium => 'Medium';

  @override
  String get jobAutomationThinkingEffortHigh => 'High';

  @override
  String get jobAutomationThinkingEffortXhigh => 'Very high';

  @override
  String get jobAutomationStatusIdle =>
      'Automation is idle until you resume job fetching.';

  @override
  String get jobAutomationStatusWaitingNextCycle =>
      'Automation is active and waiting to queue the next loop cycle.';

  @override
  String get jobAutomationStatusFetchingJobs =>
      'Getting more jobs from Upwork.';

  @override
  String get jobAutomationStatusGeneratingScores =>
      'Generating compatibility scores for jobs without an AI score yet.';

  @override
  String get jobAutomationStatusGeneratingProposals =>
      'Generating cover letters and question answers for the strongest matches.';

  @override
  String get jobAutomationStatusPaused =>
      'Automation is paused. Resume job fetching to queue the next loop cycle.';

  @override
  String get jobAutomationStatusError =>
      'Automation hit an error. The latest failure is shown below.';

  @override
  String jobAutomationStatusElapsedText(Object elapsed) {
    return 'Current step elapsed time: $elapsed.';
  }

  @override
  String get jobAutomationPauseButton => 'Pause job fetching';

  @override
  String get jobAutomationResumeButton => 'Resume job fetching';

  @override
  String jobAnalysisHourlyFromLabel(Object amount) {
    return 'From $amount';
  }

  @override
  String jobAnalysisHourlyUpToLabel(Object amount) {
    return 'Up to $amount';
  }

  @override
  String get jobAnalysisUnavailableValue => '-';

  @override
  String jobAnalysisQuestionsChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Questions',
      one: '1 Question',
      zero: '0 Questions',
    );
    return '$_temp0';
  }

  @override
  String jobAnalysisPostedMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String jobAnalysisPostedHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String jobAnalysisPostedHoursAndMinutesAgo(int hours, int minutes) {
    return '${hours}h and ${minutes}m ago';
  }

  @override
  String jobAnalysisPostedYesterdayAt(Object time) {
    return 'Yesterday at $time';
  }

  @override
  String jobAnalysisPostedMonthDay(int day, Object month) {
    return '$day of $month';
  }

  @override
  String jobAnalysisHireChip(Object percent) {
    return 'Hire $percent';
  }

  @override
  String get jobAnalysisYesValue => 'Yes';

  @override
  String get jobAnalysisNoValue => 'No';

  @override
  String get jobAnalysisPaymentStatusUnknown => 'Unknown';

  @override
  String get jobAnalysisPaymentStatusVerified => 'Verified';

  @override
  String get jobAnalysisPaymentStatusUnverified => 'Unverified';

  @override
  String get jobAnalysisDescriptionSectionTitle => 'Description';

  @override
  String get jobAnalysisCopyDescriptionTooltip => 'Copy description';

  @override
  String get jobAnalysisDescriptionCopied => 'Description copied.';

  @override
  String get jobAnalysisViewMore => 'View more';

  @override
  String get jobAnalysisViewLess => 'View less';

  @override
  String get jobAnalysisGeneralStatsSectionTitle => 'General stats';

  @override
  String get jobAnalysisGeneralStatsEditButton => 'Edit';

  @override
  String get jobAnalysisCopyStatTooltip => 'Copy value';

  @override
  String jobAnalysisGeneralStatsCopied(Object label) {
    return '$label copied.';
  }

  @override
  String get jobAnalysisGeneralStatsEditorTitle => 'Customize general stats';

  @override
  String get jobAnalysisGeneralStatsEditorDescription =>
      'Choose which stats are visible and drag to reorder them.';

  @override
  String get jobAnalysisGeneralStatsEditorResetButton => 'Reset';

  @override
  String get jobAnalysisGeneralStatsEditorCancelButton => 'Cancel';

  @override
  String get jobAnalysisGeneralStatsEditorSaveButton => 'Save';

  @override
  String get jobAnalysisGeneralStatsSaveFailed =>
      'Unable to save the general stats configuration.';

  @override
  String get jobAnalysisQuestionsSectionTitle => 'Job questions';

  @override
  String jobAnalysisQuestionTitle(int index) {
    return 'Question $index';
  }

  @override
  String get jobAnalysisCopyQuestionTooltip => 'Copy question';

  @override
  String get jobAnalysisQuestionCopied => 'Question copied.';

  @override
  String get jobAnalysisAiCompatibilitySectionTitle =>
      'AI compatibility explanation';

  @override
  String get jobAnalysisCopyAiCompatibilityTooltip =>
      'Copy AI compatibility explanation';

  @override
  String get jobAnalysisAiCompatibilityCopied =>
      'AI compatibility explanation copied.';

  @override
  String get jobAnalysisCoverLetterSectionTitle => 'AI-generated cover letter';

  @override
  String get jobAnalysisCopyCoverLetterTooltip => 'Copy cover letter';

  @override
  String get jobAnalysisCoverLetterCopied => 'Cover letter copied.';

  @override
  String get jobAnalysisMilestonesSectionTitle => 'AI milestone breakdown';

  @override
  String jobAnalysisMilestonesTotalLabel(Object amount) {
    return 'Total suggested bid: $amount';
  }

  @override
  String jobAnalysisMilestoneTitle(int index) {
    return 'Milestone $index';
  }

  @override
  String get jobAnalysisCopyMilestoneTitleTooltip => 'Copy milestone title';

  @override
  String get jobAnalysisMilestoneTitleCopied => 'Milestone title copied.';

  @override
  String get jobAnalysisCopyMilestoneSuggestedPriceTooltip =>
      'Copy suggested value';

  @override
  String get jobAnalysisMilestoneSuggestedPriceCopied =>
      'Suggested value copied.';

  @override
  String get jobAnalysisCopyMilestoneDescriptionTooltip =>
      'Copy milestone description';

  @override
  String get jobAnalysisMilestoneDescriptionCopied =>
      'Milestone description copied.';

  @override
  String get jobAnalysisAiAnswersSectionTitle => 'AI-generated answers';

  @override
  String get jobAnalysisAnswerFallbackTitle => 'Generated answer';

  @override
  String get jobAnalysisCopyAnswerTooltip => 'Copy answer';

  @override
  String get jobAnalysisAnswerCopied => 'Answer copied.';

  @override
  String get jobAnalysisUpworkIdLabel => 'Upwork ID';

  @override
  String get jobAnalysisSubIdLabel => 'Sub ID';

  @override
  String get jobAnalysisJobUrlLabel => 'Job URL';

  @override
  String get jobAnalysisRelativeDateLabel => 'Relative date';

  @override
  String get jobAnalysisRelativeDateMinutesLabel => 'Relative date (minutes)';

  @override
  String get jobAnalysisAbsoluteDateLabel => 'Absolute date';

  @override
  String get jobAnalysisAbsoluteDateTimeLabel => 'Absolute date time';

  @override
  String get jobAnalysisBudgetLabel => 'Budget';

  @override
  String get jobAnalysisCompensationLabel => 'Compensation';

  @override
  String get jobAnalysisFixedPriceAmountLabel => 'Fixed price amount';

  @override
  String get jobAnalysisHourlyMinLabel => 'Hourly min';

  @override
  String get jobAnalysisHourlyMaxLabel => 'Hourly max';

  @override
  String get jobAnalysisJobTypeLabel => 'Job type';

  @override
  String get jobAnalysisExperienceLabel => 'Experience';

  @override
  String get jobAnalysisPaymentVerifiedLabel => 'Payment verified';

  @override
  String get jobAnalysisAllowedCountriesLabel => 'Allowed applicant countries';

  @override
  String get jobAnalysisClientNameLabel => 'Client name';

  @override
  String get jobAnalysisClientNameConfidenceLabel => 'Client name confidence';

  @override
  String get jobAnalysisClientAverageHourlyRateLabel =>
      'Client avg hourly rate';

  @override
  String get jobAnalysisClientRatingLabel => 'Client rating';

  @override
  String jobAnalysisClientRatingValue(Object rating) {
    return '$rating / 5';
  }

  @override
  String get jobAnalysisClientHireRateLabel => 'Client hire rate';

  @override
  String get jobAnalysisClientTotalSpentLabel => 'Client total spent';

  @override
  String get jobAnalysisClientCountryLabel => 'Client country';

  @override
  String get jobAnalysisClientRegionLabel => 'Client region';

  @override
  String get jobAnalysisClientSubRegionLabel => 'Client sub-region';

  @override
  String get jobAnalysisTagsLabel => 'Tags';

  @override
  String get jobAnalysisHasHiredLabel => 'Has hired';

  @override
  String get jobAnalysisQuestionCountLabel => 'Question count';

  @override
  String get jobAnalysisPersistedAtLabel => 'Job persisted at';

  @override
  String get jobAnalysisScoreGeneratedAtLabel => 'Score generated at';

  @override
  String get jobAnalysisAiResponsesGeneratedAtLabel =>
      'AI responses generated at';

  @override
  String get jobAnalysisInvalidUrlMessage => 'The job URL is invalid.';

  @override
  String get jobAnalysisUnableToOpenJobMessage =>
      'Unable to open this Upwork job.';

  @override
  String get jobAnalysisBackToFiltersButton => 'Back to filters';

  @override
  String get jobAnalysisViewJobButton => 'View job';

  @override
  String get jobAnalysisNoClientRatingValue => 'No data';

  @override
  String get jobAnalysisAiAnswersReadyTooltip =>
      'Completed. AI answers generated.';

  @override
  String get jobKnowledgeQuickActionsEditCurriculumButton =>
      'Change curriculum';

  @override
  String get jobKnowledgeQuickActionsEditAnswerStyleButton =>
      'Change proposal writing';

  @override
  String get jobKnowledgeQuickActionsEditScoreLogicButton =>
      'Change job score logic';

  @override
  String get jobKnowledgeEditorCurriculumTitle => 'Curriculum';

  @override
  String get jobKnowledgeEditorCurriculumDescription =>
      'Update the long-form curriculum text the AI uses as grounded context for your skills, experience, and positioning.';

  @override
  String get jobKnowledgeEditorCurriculumInputLabel => 'Curriculum text';

  @override
  String get jobKnowledgeEditorCurriculumSaved => 'Curriculum updated.';

  @override
  String get jobKnowledgeEditorAnswerStyleTitle =>
      'How you want answers to be written';

  @override
  String get jobKnowledgeEditorAnswerStyleDescription =>
      'Update the tone, structure, level of detail, and writing rules that should guide generated proposals and answers.';

  @override
  String get jobKnowledgeEditorAnswerStyleInputLabel =>
      'Answer style preference';

  @override
  String get jobKnowledgeEditorAnswerStyleSaved => 'Answer style updated.';

  @override
  String get jobKnowledgeEditorScoreLogicTitle => 'How a job should be scored';

  @override
  String get jobKnowledgeEditorScoreLogicDescription =>
      'Update the criteria that define what makes a job worth your time, plus the red flags that should lower the AI score.';

  @override
  String get jobKnowledgeEditorScoreLogicInputLabel => 'Job scoring logic';

  @override
  String get jobKnowledgeEditorScoreLogicSaved => 'Job scoring logic updated.';

  @override
  String get jobKnowledgeEditorLoadFailedTitle => 'Unable to load this text';

  @override
  String get jobKnowledgeEditorRetryButton => 'Retry';

  @override
  String get jobKnowledgeEditorCancelButton => 'Cancel';

  @override
  String get jobKnowledgeEditorSaveButton => 'Save';

  @override
  String get jobKnowledgeEditorSavingButton => 'Saving…';

  @override
  String jobKnowledgeEditorCharacterHint(int minimum, int maximum) {
    return 'Minimum $minimum characters. Maximum $maximum characters.';
  }

  @override
  String jobKnowledgeEditorValidationMin(int minimum) {
    return 'Please add at least $minimum characters before saving.';
  }

  @override
  String jobKnowledgeEditorValidationMax(int maximum) {
    return 'Please keep the text under $maximum characters.';
  }

  @override
  String get jobAnalysisRefreshTooltip => 'Refresh this card';

  @override
  String get jobAnalysisForceSyncTooltip => 'Force sync this job';

  @override
  String get jobAnalysisForceSyncDialogTitle => 'Force sync job';

  @override
  String get jobAnalysisForceSyncDialogDescription =>
      'Regenerating the score and all AI responses for this job card.';

  @override
  String get jobAnalysisForceSyncDoneButton => 'Done';

  @override
  String get jobAnalysisForceSyncCloseButton => 'Close';

  @override
  String get jobAnalysisForceSyncUnexpectedFailure =>
      'The force-sync stream ended unexpectedly.';

  @override
  String get jobAnalysisForceSyncStepScore => 'Score';

  @override
  String get jobAnalysisForceSyncStepProposal => 'Cover letter';

  @override
  String get jobAnalysisForceSyncStepAnswers => 'Answers';

  @override
  String get jobAnalysisForceSyncStepMilestones => 'Milestones';

  @override
  String get jobAnalysisForceSyncCurrentPreparing => 'Preparing force sync';

  @override
  String get jobAnalysisForceSyncCurrentScore => 'Generating score';

  @override
  String get jobAnalysisForceSyncCurrentProposal =>
      'Generating proposal package';

  @override
  String get jobAnalysisForceSyncCurrentAnswers => 'Generating answers';

  @override
  String get jobAnalysisForceSyncCurrentMilestones => 'Generating milestones';

  @override
  String get jobAnalysisForceSyncCurrentReloading => 'Reloading card';

  @override
  String get jobAnalysisForceSyncCurrentCompleted => 'Force sync completed';

  @override
  String get jobAnalysisForceSyncCurrentFailed => 'Force sync failed';

  @override
  String get jobAnalysisForceSyncStatusPending => 'Pending';

  @override
  String get jobAnalysisForceSyncStatusRunning => 'Running';

  @override
  String get jobAnalysisForceSyncStatusCompleted => 'Done';

  @override
  String get jobAnalysisForceSyncStatusSkipped => 'Skipped';

  @override
  String get jobAnalysisForceSyncStatusFailed => 'Failed';
}
