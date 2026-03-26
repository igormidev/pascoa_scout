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
