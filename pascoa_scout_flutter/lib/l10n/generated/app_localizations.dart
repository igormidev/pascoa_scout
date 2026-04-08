import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// Order-by label for showing the highest scored job analyses first.
  ///
  /// In en, this message translates to:
  /// **'Highest score'**
  String get jobListOrderByHighestScore;

  /// Order-by label for sorting jobs by the highest hourly rate.
  ///
  /// In en, this message translates to:
  /// **'Highest hourly rate'**
  String get jobListOrderByHighestHourlyRate;

  /// Order-by label for sorting jobs by the lowest hourly rate.
  ///
  /// In en, this message translates to:
  /// **'Lowest hourly rate'**
  String get jobListOrderByLowestHourlyRate;

  /// Order-by label for sorting jobs by the highest fixed price.
  ///
  /// In en, this message translates to:
  /// **'Highest fixed price'**
  String get jobListOrderByHighestFixedPrice;

  /// Order-by label for sorting jobs by the lowest fixed price.
  ///
  /// In en, this message translates to:
  /// **'Lowest fixed price'**
  String get jobListOrderByLowestFixedPrice;

  /// Order-by label for sorting jobs by the newest relative date.
  ///
  /// In en, this message translates to:
  /// **'Newest relative date'**
  String get jobListOrderByNewestRelativeDate;

  /// Order-by label for sorting jobs by the newest absolute date.
  ///
  /// In en, this message translates to:
  /// **'Newest absolute date'**
  String get jobListOrderByNewestAbsoluteDate;

  /// Order-by label for sorting jobs by the newest persisted job info rows.
  ///
  /// In en, this message translates to:
  /// **'Newest persisted jobs'**
  String get jobListOrderByNewestPersistedJobs;

  /// Order-by label for sorting jobs by the newest generated scores.
  ///
  /// In en, this message translates to:
  /// **'Newest generated scores'**
  String get jobListOrderByNewestGeneratedScores;

  /// Order-by label for sorting jobs by the newest AI responses.
  ///
  /// In en, this message translates to:
  /// **'Newest AI responses'**
  String get jobListOrderByNewestAiResponses;

  /// Order-by label for sorting jobs by the highest client hire rate.
  ///
  /// In en, this message translates to:
  /// **'Highest client hire rate'**
  String get jobListOrderByHighestClientHireRate;

  /// Order-by label for sorting jobs by the highest client average hourly rate.
  ///
  /// In en, this message translates to:
  /// **'Highest client avg hourly rate'**
  String get jobListOrderByHighestClientAverageHourlyRate;

  /// Order-by label for sorting jobs by the highest client name confidence.
  ///
  /// In en, this message translates to:
  /// **'Highest client name confidence'**
  String get jobListOrderByHighestClientNameConfidence;

  /// Order-by label for sorting jobs by the highest client rating.
  ///
  /// In en, this message translates to:
  /// **'Highest client rating'**
  String get jobListOrderByHighestClientRating;

  /// Order-by label for sorting jobs by the highest client total spent.
  ///
  /// In en, this message translates to:
  /// **'Highest client total spent'**
  String get jobListOrderByHighestClientTotalSpent;

  /// Title for the local setting that refreshes the job list automatically while the automation loop is running.
  ///
  /// In en, this message translates to:
  /// **'Live refresh job list'**
  String get jobListLiveRefreshSettingTitle;

  /// Checkbox label for enabling or disabling automatic refresh of the job list.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get jobListLiveRefreshSettingToggle;

  /// Description shown when automatic job list refresh is disabled.
  ///
  /// In en, this message translates to:
  /// **'Keeps the job list on manual refresh only.'**
  String get jobListLiveRefreshSettingDisabledDescription;

  /// Description shown when automatic job list refresh is enabled.
  ///
  /// In en, this message translates to:
  /// **'Refreshes the job list every {seconds} seconds while the automation loop is running.'**
  String jobListLiveRefreshSettingEnabledDescription(int seconds);

  /// Title for the automation card that controls the Codex model and reasoning effort.
  ///
  /// In en, this message translates to:
  /// **'AI generation'**
  String get jobAutomationAiSettingsTitle;

  /// Description for the automation card that controls the Codex model and reasoning effort.
  ///
  /// In en, this message translates to:
  /// **'Choose the Codex model and thinking effort used for scoring and proposal generation.'**
  String get jobAutomationAiSettingsDescription;

  /// Label for the Codex model dropdown.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get jobAutomationAiModelLabel;

  /// Dropdown option for the GPT-5.4 Codex model.
  ///
  /// In en, this message translates to:
  /// **'GPT-5.4'**
  String get jobAutomationAiModelGpt54;

  /// Dropdown option for the GPT-5.4 mini Codex model.
  ///
  /// In en, this message translates to:
  /// **'GPT-5.4 mini'**
  String get jobAutomationAiModelGpt54Mini;

  /// Label for the automation setting that controls the Codex reasoning effort.
  ///
  /// In en, this message translates to:
  /// **'Thinking effort'**
  String get jobAutomationThinkingEffortTitle;

  /// Description for the automation setting that controls the Codex reasoning effort.
  ///
  /// In en, this message translates to:
  /// **'Controls the Codex model profile used for scoring and proposal generation. Current model: {model}.'**
  String jobAutomationThinkingEffortDescription(Object model);

  /// Dropdown option for the lowest Codex thinking effort.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get jobAutomationThinkingEffortLow;

  /// Dropdown option for the medium Codex thinking effort.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get jobAutomationThinkingEffortMedium;

  /// Dropdown option for the high Codex thinking effort.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get jobAutomationThinkingEffortHigh;

  /// Dropdown option for the highest Codex thinking effort.
  ///
  /// In en, this message translates to:
  /// **'Very high'**
  String get jobAutomationThinkingEffortXhigh;

  /// Status copy shown when the automation loop is not active.
  ///
  /// In en, this message translates to:
  /// **'Automation is idle until you resume job fetching.'**
  String get jobAutomationStatusIdle;

  /// Status copy shown when the automation loop is active on the server but not currently processing a fetch, scoring, or proposal step.
  ///
  /// In en, this message translates to:
  /// **'Automation is active and waiting to queue the next loop cycle.'**
  String get jobAutomationStatusWaitingNextCycle;

  /// Status copy shown while the automation loop is synchronizing jobs.
  ///
  /// In en, this message translates to:
  /// **'Getting more jobs from Upwork.'**
  String get jobAutomationStatusFetchingJobs;

  /// Status copy shown while the automation loop is generating missing scores.
  ///
  /// In en, this message translates to:
  /// **'Generating compatibility scores for jobs without an AI score yet.'**
  String get jobAutomationStatusGeneratingScores;

  /// Status copy shown while the automation loop is generating proposals.
  ///
  /// In en, this message translates to:
  /// **'Generating cover letters and question answers for the strongest matches.'**
  String get jobAutomationStatusGeneratingProposals;

  /// Status copy shown when the automation loop is paused by the user.
  ///
  /// In en, this message translates to:
  /// **'Automation is paused. Resume job fetching to queue the next loop cycle.'**
  String get jobAutomationStatusPaused;

  /// Status copy shown when the latest automation step failed.
  ///
  /// In en, this message translates to:
  /// **'Automation hit an error. The latest failure is shown below.'**
  String get jobAutomationStatusError;

  /// Suffix appended to the automation status card to show how long the current step has been in its latest state.
  ///
  /// In en, this message translates to:
  /// **'Current step elapsed time: {elapsed}.'**
  String jobAutomationStatusElapsedText(Object elapsed);

  /// Button label for pausing the automation loop.
  ///
  /// In en, this message translates to:
  /// **'Pause job fetching'**
  String get jobAutomationPauseButton;

  /// Button label for resuming the automation loop.
  ///
  /// In en, this message translates to:
  /// **'Resume job fetching'**
  String get jobAutomationResumeButton;

  /// Compensation label for hourly jobs with only a minimum rate.
  ///
  /// In en, this message translates to:
  /// **'From {amount}'**
  String jobAnalysisHourlyFromLabel(Object amount);

  /// Compensation label for hourly jobs with only a maximum rate.
  ///
  /// In en, this message translates to:
  /// **'Up to {amount}'**
  String jobAnalysisHourlyUpToLabel(Object amount);

  /// Fallback value shown when a job detail is unavailable.
  ///
  /// In en, this message translates to:
  /// **'-'**
  String get jobAnalysisUnavailableValue;

  /// Compact chip label showing how many application questions a job has.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 Questions} =1{1 Question} other{{count} Questions}}'**
  String jobAnalysisQuestionsChip(int count);

  /// Compact label for jobs posted today when less than one hour has elapsed.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String jobAnalysisPostedMinutesAgo(int minutes);

  /// Compact label for jobs posted today when only whole hours have elapsed.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String jobAnalysisPostedHoursAgo(int hours);

  /// Compact label for jobs posted today when hours and minutes have elapsed.
  ///
  /// In en, this message translates to:
  /// **'{hours}h and {minutes}m ago'**
  String jobAnalysisPostedHoursAndMinutesAgo(int hours, int minutes);

  /// Compact label for jobs posted on the previous calendar day.
  ///
  /// In en, this message translates to:
  /// **'Yesterday at {time}'**
  String jobAnalysisPostedYesterdayAt(Object time);

  /// Compact label for jobs posted before yesterday, without including the year.
  ///
  /// In en, this message translates to:
  /// **'{day} of {month}'**
  String jobAnalysisPostedMonthDay(int day, Object month);

  /// Compact chip label showing the client hire rate.
  ///
  /// In en, this message translates to:
  /// **'Hire {percent}'**
  String jobAnalysisHireChip(Object percent);

  /// Affirmative value label in job details tables.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get jobAnalysisYesValue;

  /// Negative value label in job details tables.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get jobAnalysisNoValue;

  /// Payment verification label for an unknown client payment status.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get jobAnalysisPaymentStatusUnknown;

  /// Payment verification label for a verified client payment status.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get jobAnalysisPaymentStatusVerified;

  /// Payment verification label for an unverified client payment status.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get jobAnalysisPaymentStatusUnverified;

  /// Section title for the job description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get jobAnalysisDescriptionSectionTitle;

  /// Tooltip for copying the job description.
  ///
  /// In en, this message translates to:
  /// **'Copy description'**
  String get jobAnalysisCopyDescriptionTooltip;

  /// Snackbar message after copying the job description.
  ///
  /// In en, this message translates to:
  /// **'Description copied.'**
  String get jobAnalysisDescriptionCopied;

  /// Label for expanding a truncated block of job text.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get jobAnalysisViewMore;

  /// Label for collapsing an expanded block of job text.
  ///
  /// In en, this message translates to:
  /// **'View less'**
  String get jobAnalysisViewLess;

  /// Section title for the general job stats table.
  ///
  /// In en, this message translates to:
  /// **'General stats'**
  String get jobAnalysisGeneralStatsSectionTitle;

  /// Button label for opening the general stats customization dialog.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get jobAnalysisGeneralStatsEditButton;

  /// Tooltip for copying a value from the general stats list.
  ///
  /// In en, this message translates to:
  /// **'Copy value'**
  String get jobAnalysisCopyStatTooltip;

  /// Snackbar message after copying a value from the general stats list.
  ///
  /// In en, this message translates to:
  /// **'{label} copied.'**
  String jobAnalysisGeneralStatsCopied(Object label);

  /// Dialog title for customizing which general stats are shown and in what order.
  ///
  /// In en, this message translates to:
  /// **'Customize general stats'**
  String get jobAnalysisGeneralStatsEditorTitle;

  /// Dialog description for the general stats customization dialog.
  ///
  /// In en, this message translates to:
  /// **'Choose which stats are visible and drag to reorder them.'**
  String get jobAnalysisGeneralStatsEditorDescription;

  /// Button label for resetting the general stats customization back to defaults.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get jobAnalysisGeneralStatsEditorResetButton;

  /// Button label for dismissing the general stats customization dialog without saving.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get jobAnalysisGeneralStatsEditorCancelButton;

  /// Button label for saving the general stats customization dialog.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get jobAnalysisGeneralStatsEditorSaveButton;

  /// Error shown when the general stats configuration cannot be persisted.
  ///
  /// In en, this message translates to:
  /// **'Unable to save the general stats configuration.'**
  String get jobAnalysisGeneralStatsSaveFailed;

  /// Section title for the raw application questions.
  ///
  /// In en, this message translates to:
  /// **'Job questions'**
  String get jobAnalysisQuestionsSectionTitle;

  /// Title for a question entry in the selected job detail panel.
  ///
  /// In en, this message translates to:
  /// **'Question {index}'**
  String jobAnalysisQuestionTitle(int index);

  /// Tooltip for copying a raw application question.
  ///
  /// In en, this message translates to:
  /// **'Copy question'**
  String get jobAnalysisCopyQuestionTooltip;

  /// Snackbar message after copying a raw application question.
  ///
  /// In en, this message translates to:
  /// **'Question copied.'**
  String get jobAnalysisQuestionCopied;

  /// Section title for the AI-generated compatibility explanation.
  ///
  /// In en, this message translates to:
  /// **'AI compatibility explanation'**
  String get jobAnalysisAiCompatibilitySectionTitle;

  /// Tooltip for copying the AI-generated compatibility explanation.
  ///
  /// In en, this message translates to:
  /// **'Copy AI compatibility explanation'**
  String get jobAnalysisCopyAiCompatibilityTooltip;

  /// Snackbar message after copying the AI-generated compatibility explanation.
  ///
  /// In en, this message translates to:
  /// **'AI compatibility explanation copied.'**
  String get jobAnalysisAiCompatibilityCopied;

  /// Section title for the AI-generated cover letter.
  ///
  /// In en, this message translates to:
  /// **'AI-generated cover letter'**
  String get jobAnalysisCoverLetterSectionTitle;

  /// Tooltip for copying the AI-generated cover letter.
  ///
  /// In en, this message translates to:
  /// **'Copy cover letter'**
  String get jobAnalysisCopyCoverLetterTooltip;

  /// Snackbar message after copying the AI-generated cover letter.
  ///
  /// In en, this message translates to:
  /// **'Cover letter copied.'**
  String get jobAnalysisCoverLetterCopied;

  /// Section title for the AI-generated fixed-price milestone suggestions.
  ///
  /// In en, this message translates to:
  /// **'AI milestone breakdown'**
  String get jobAnalysisMilestonesSectionTitle;

  /// Label showing the total bid implied by the AI-generated milestone prices.
  ///
  /// In en, this message translates to:
  /// **'Total suggested bid: {amount}'**
  String jobAnalysisMilestonesTotalLabel(Object amount);

  /// Title label for an individual AI-generated milestone suggestion.
  ///
  /// In en, this message translates to:
  /// **'Milestone {index}'**
  String jobAnalysisMilestoneTitle(int index);

  /// Tooltip for copying a milestone title.
  ///
  /// In en, this message translates to:
  /// **'Copy milestone title'**
  String get jobAnalysisCopyMilestoneTitleTooltip;

  /// Snackbar message shown after copying a milestone title.
  ///
  /// In en, this message translates to:
  /// **'Milestone title copied.'**
  String get jobAnalysisMilestoneTitleCopied;

  /// Tooltip for copying the suggested milestone value.
  ///
  /// In en, this message translates to:
  /// **'Copy suggested value'**
  String get jobAnalysisCopyMilestoneSuggestedPriceTooltip;

  /// Snackbar message shown after copying the suggested milestone value.
  ///
  /// In en, this message translates to:
  /// **'Suggested value copied.'**
  String get jobAnalysisMilestoneSuggestedPriceCopied;

  /// Tooltip for copying a milestone description.
  ///
  /// In en, this message translates to:
  /// **'Copy milestone description'**
  String get jobAnalysisCopyMilestoneDescriptionTooltip;

  /// Snackbar message shown after copying a milestone description.
  ///
  /// In en, this message translates to:
  /// **'Milestone description copied.'**
  String get jobAnalysisMilestoneDescriptionCopied;

  /// Section title for the AI-generated answers to the job questions.
  ///
  /// In en, this message translates to:
  /// **'AI-generated answers'**
  String get jobAnalysisAiAnswersSectionTitle;

  /// Fallback title when an AI-generated answer has no linked question title.
  ///
  /// In en, this message translates to:
  /// **'Generated answer'**
  String get jobAnalysisAnswerFallbackTitle;

  /// Tooltip for copying an AI-generated answer.
  ///
  /// In en, this message translates to:
  /// **'Copy answer'**
  String get jobAnalysisCopyAnswerTooltip;

  /// Snackbar message after copying an AI-generated answer.
  ///
  /// In en, this message translates to:
  /// **'Answer copied.'**
  String get jobAnalysisAnswerCopied;

  /// Label for the Upwork ID row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Upwork ID'**
  String get jobAnalysisUpworkIdLabel;

  /// Label for the Sub ID row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Sub ID'**
  String get jobAnalysisSubIdLabel;

  /// Label for the job URL row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Job URL'**
  String get jobAnalysisJobUrlLabel;

  /// Label for the relative date row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Relative date'**
  String get jobAnalysisRelativeDateLabel;

  /// Label for the raw relative date in minutes row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Relative date (minutes)'**
  String get jobAnalysisRelativeDateMinutesLabel;

  /// Label for the absolute date row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Absolute date'**
  String get jobAnalysisAbsoluteDateLabel;

  /// Label for the absolute date time row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Absolute date time'**
  String get jobAnalysisAbsoluteDateTimeLabel;

  /// Label for the raw budget row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get jobAnalysisBudgetLabel;

  /// Label for the formatted compensation row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Compensation'**
  String get jobAnalysisCompensationLabel;

  /// Label for the fixed price amount row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Fixed price amount'**
  String get jobAnalysisFixedPriceAmountLabel;

  /// Label for the hourly minimum rate row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Hourly min'**
  String get jobAnalysisHourlyMinLabel;

  /// Label for the hourly maximum rate row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Hourly max'**
  String get jobAnalysisHourlyMaxLabel;

  /// Label for the job type row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Job type'**
  String get jobAnalysisJobTypeLabel;

  /// Label for the experience level row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get jobAnalysisExperienceLabel;

  /// Label for the payment verification row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Payment verified'**
  String get jobAnalysisPaymentVerifiedLabel;

  /// Label for the allowed applicant countries row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Allowed applicant countries'**
  String get jobAnalysisAllowedCountriesLabel;

  /// Label for the client name row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client name'**
  String get jobAnalysisClientNameLabel;

  /// Label for the client name confidence row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client name confidence'**
  String get jobAnalysisClientNameConfidenceLabel;

  /// Label for the client average hourly rate row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client avg hourly rate'**
  String get jobAnalysisClientAverageHourlyRateLabel;

  /// Label for the client rating row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client rating'**
  String get jobAnalysisClientRatingLabel;

  /// Formatted client rating value in the job details table.
  ///
  /// In en, this message translates to:
  /// **'{rating} / 5'**
  String jobAnalysisClientRatingValue(Object rating);

  /// Label for the client hire rate row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client hire rate'**
  String get jobAnalysisClientHireRateLabel;

  /// Label for the client total spent row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client total spent'**
  String get jobAnalysisClientTotalSpentLabel;

  /// Label for the client country row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client country'**
  String get jobAnalysisClientCountryLabel;

  /// Label for the client region row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client region'**
  String get jobAnalysisClientRegionLabel;

  /// Label for the client sub-region row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Client sub-region'**
  String get jobAnalysisClientSubRegionLabel;

  /// Label for the tags row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get jobAnalysisTagsLabel;

  /// Label for the has hired row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Has hired'**
  String get jobAnalysisHasHiredLabel;

  /// Label for the question count row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Question count'**
  String get jobAnalysisQuestionCountLabel;

  /// Label for the job persisted timestamp row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Job persisted at'**
  String get jobAnalysisPersistedAtLabel;

  /// Label for the score generated timestamp row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'Score generated at'**
  String get jobAnalysisScoreGeneratedAtLabel;

  /// Label for the AI responses generated timestamp row in the job details table.
  ///
  /// In en, this message translates to:
  /// **'AI responses generated at'**
  String get jobAnalysisAiResponsesGeneratedAtLabel;

  /// Error snackbar message shown when a job URL cannot be parsed.
  ///
  /// In en, this message translates to:
  /// **'The job URL is invalid.'**
  String get jobAnalysisInvalidUrlMessage;

  /// Error snackbar message shown when opening a job URL fails.
  ///
  /// In en, this message translates to:
  /// **'Unable to open this Upwork job.'**
  String get jobAnalysisUnableToOpenJobMessage;

  /// Button label for returning from the selected job panel to the filter editor.
  ///
  /// In en, this message translates to:
  /// **'Back to filters'**
  String get jobAnalysisBackToFiltersButton;

  /// Button label for opening the job in the browser.
  ///
  /// In en, this message translates to:
  /// **'View job'**
  String get jobAnalysisViewJobButton;

  /// Fallback value shown when a client does not have a rating.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get jobAnalysisNoClientRatingValue;

  /// Tooltip shown on the badge when AI answers have already been generated for the job.
  ///
  /// In en, this message translates to:
  /// **'Completed. AI answers generated.'**
  String get jobAnalysisAiAnswersReadyTooltip;

  /// Button label for changing the curriculum knowledge text from the compact summary view.
  ///
  /// In en, this message translates to:
  /// **'Change curriculum'**
  String get jobKnowledgeQuickActionsEditCurriculumButton;

  /// Button label for changing the proposal writing guidance from the compact summary view.
  ///
  /// In en, this message translates to:
  /// **'Change proposal writing'**
  String get jobKnowledgeQuickActionsEditAnswerStyleButton;

  /// Button label for changing the job score logic from the compact summary view.
  ///
  /// In en, this message translates to:
  /// **'Change job score logic'**
  String get jobKnowledgeQuickActionsEditScoreLogicButton;

  /// Dialog title for editing the curriculum knowledge text.
  ///
  /// In en, this message translates to:
  /// **'Curriculum'**
  String get jobKnowledgeEditorCurriculumTitle;

  /// Dialog description for editing the curriculum knowledge text.
  ///
  /// In en, this message translates to:
  /// **'Update the long-form curriculum text the AI uses as grounded context for your skills, experience, and positioning.'**
  String get jobKnowledgeEditorCurriculumDescription;

  /// Text field label for the curriculum knowledge editor.
  ///
  /// In en, this message translates to:
  /// **'Curriculum text'**
  String get jobKnowledgeEditorCurriculumInputLabel;

  /// Snackbar message after saving the curriculum knowledge text.
  ///
  /// In en, this message translates to:
  /// **'Curriculum updated.'**
  String get jobKnowledgeEditorCurriculumSaved;

  /// Dialog title for editing how proposals and answers should sound.
  ///
  /// In en, this message translates to:
  /// **'How you want answers to be written'**
  String get jobKnowledgeEditorAnswerStyleTitle;

  /// Dialog description for editing the proposal style knowledge text.
  ///
  /// In en, this message translates to:
  /// **'Update the tone, structure, level of detail, and writing rules that should guide generated proposals and answers.'**
  String get jobKnowledgeEditorAnswerStyleDescription;

  /// Text field label for the proposal style knowledge editor.
  ///
  /// In en, this message translates to:
  /// **'Answer style preference'**
  String get jobKnowledgeEditorAnswerStyleInputLabel;

  /// Snackbar message after saving the proposal style knowledge text.
  ///
  /// In en, this message translates to:
  /// **'Answer style updated.'**
  String get jobKnowledgeEditorAnswerStyleSaved;

  /// Dialog title for editing the opportunity preference and job scoring logic.
  ///
  /// In en, this message translates to:
  /// **'How a job should be scored'**
  String get jobKnowledgeEditorScoreLogicTitle;

  /// Dialog description for editing the opportunity preference and job scoring logic.
  ///
  /// In en, this message translates to:
  /// **'Update the criteria that define what makes a job worth your time, plus the red flags that should lower the AI score.'**
  String get jobKnowledgeEditorScoreLogicDescription;

  /// Text field label for the job scoring logic editor.
  ///
  /// In en, this message translates to:
  /// **'Job scoring logic'**
  String get jobKnowledgeEditorScoreLogicInputLabel;

  /// Snackbar message after saving the job scoring logic text.
  ///
  /// In en, this message translates to:
  /// **'Job scoring logic updated.'**
  String get jobKnowledgeEditorScoreLogicSaved;

  /// Dialog error title shown when a stored knowledge text cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'Unable to load this text'**
  String get jobKnowledgeEditorLoadFailedTitle;

  /// Button label for retrying the knowledge text load.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get jobKnowledgeEditorRetryButton;

  /// Button label for dismissing the knowledge editor dialog without saving.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get jobKnowledgeEditorCancelButton;

  /// Button label for saving the knowledge editor dialog.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get jobKnowledgeEditorSaveButton;

  /// Button label shown while a knowledge text is being saved.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get jobKnowledgeEditorSavingButton;

  /// Helper text explaining the supported character range in the knowledge editor dialog.
  ///
  /// In en, this message translates to:
  /// **'Minimum {minimum} characters. Maximum {maximum} characters.'**
  String jobKnowledgeEditorCharacterHint(int minimum, int maximum);

  /// Validation message shown when a knowledge text is too short.
  ///
  /// In en, this message translates to:
  /// **'Please add at least {minimum} characters before saving.'**
  String jobKnowledgeEditorValidationMin(int minimum);

  /// Validation message shown when a knowledge text is too long.
  ///
  /// In en, this message translates to:
  /// **'Please keep the text under {maximum} characters.'**
  String jobKnowledgeEditorValidationMax(int maximum);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
