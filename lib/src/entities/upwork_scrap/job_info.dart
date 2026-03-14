import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pascoa_scout/src/entities/upwork_scrap/enums.dart';

part 'job_info.freezed.dart';
part 'job_info.g.dart';

@freezed
abstract class JobInfo with _$JobInfo {
  factory JobInfo({
    required String id,
    required String? subId,
    required String title,
    required String description,
    required String url,
    required String? relativeDate,
    required String? absoluteDate,
    required double? budget,
    required JobType jobType,
    required ExperienceLevel experienceLevel,
    required ClientLocation? clientLocation,
    required PaymentVerifiedStatus paymentVerifiedStatus,
    required List<ClientLocation> allowedApplicantCountries,
    required String? clientName,
    required double? clientNameConfidencePercent, // Goes from 0@ to 100%
    required double? clientAvgHourlyRate, // USD
    required double? clientRating, // Goes from 0 to 5 stars
    required double? clientHireRatePercent, // Goes from 0% to 100%
    required double? clientTotalSpent,
    required List<String> tags,
    required bool
    hasHired, // Whether the client has hired anyone for this specific job
    required List<Question>
    questions, // Additional screening questions the client has for applicants (optional, not all jobs have these)
  }) = _JobInfo;

  factory JobInfo.fromJson(Map<String, dynamic> json) =>
      _$JobInfoFromJson(json);

  factory JobInfo.fromApify(Map<String, dynamic> json) {
    final rawBudget = (json['budget'] as String?);

    final rawRelativeDate = json['relativeDate'] as String;
    final rawAbsoluteDate = json['absoluteDate'] as String;
    final relativeDate = rawRelativeDate.isNotEmpty ? rawRelativeDate : null;
    final absoluteDate = rawAbsoluteDate.isNotEmpty ? rawAbsoluteDate : null;

    final clientLocation = ClientLocation.fromApifyJson(json);

    final PaymentVerifiedStatus paymentVerifiedStatus;
    if (json['paymentVerified'] == true) {
      paymentVerifiedStatus = PaymentVerifiedStatus.verified;
    } else if (json['paymentVerified'] == false) {
      paymentVerifiedStatus = PaymentVerifiedStatus.unverified;
    } else {
      paymentVerifiedStatus = PaymentVerifiedStatus.unknown;
    }

    final List<ClientLocation> allowedApplicantCountries = [];
    if (json['allowedApplicantCountries'] != null) {
      for (var countryName in json['allowedApplicantCountries'] as List) {
        final country = Country.fromName(countryName.toString());
        if (country != null) {
          allowedApplicantCountries.add(
            ClientLocation.country(country: country),
          );
        }
      }
    }

    final clientName = json['clientName'] as String?;
    final clientNameConfidenceRaw = (json['clientNameConfidence'] as num?)
        ?.toDouble(); // Ensure it's a double
    // Will be from 0 to 1, so lets convert it to a percentage
    final double? castedClientNameConfidence = clientNameConfidenceRaw != null
        ? (clientNameConfidenceRaw * 100).clamp(0, 100)
        : null;
    // Lets make it in a scope of 0 to 100% IF it is not null AND the values are between 0 and 1, otherwise we assume it's already in percentage form
    final double? clientNameConfidence = (castedClientNameConfidence != null)
        ? (castedClientNameConfidence >= 0 && castedClientNameConfidence <= 1)
              ? (castedClientNameConfidence * 100).clamp(0, 100)
              : castedClientNameConfidence.clamp(0, 100)
        : null;

    final double? clientAvgHourlyRate = (json['clientAvgHourlyRate'] as num?)
        ?.toDouble();

    // Will go from 0 to 5 stars
    final clientRating = (json['clientRating'] as num?)?.toDouble();

    final clientHireRatePercentRaw = (json['clientHireRatePercent'] as num?)
        ?.toDouble();
    // Lets make it in a scope of 0 to 100% IF it is not null AND the values are between 0 and 1, otherwise we assume it's already in percentage form
    final double? castedClientHireRatePercent = clientHireRatePercentRaw;
    final double? clientHireRatePercent = (castedClientHireRatePercent != null)
        ? (castedClientHireRatePercent >= 0 && castedClientHireRatePercent <= 1)
              ? (castedClientHireRatePercent * 100).clamp(0, 100)
              : castedClientHireRatePercent.clamp(0, 100)
        : null;
    final clientTotalSpent = (json['clientTotalSpent'] as num?)?.toDouble();
    final hasHired = json['hasHired'] as bool? ?? false;

    final questionsRaw = (json['questions'] as List<dynamic>? ?? []);
    final List<Question> questions = questionsRaw
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map(Question.fromApify)
        .toList();

    final tags = (json['tags'] as List<dynamic>? ?? <String>[]).cast<String>();

    return JobInfo(
      id: json['id'] as String,
      subId: json['subId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      budget: rawBudget != null ? double.tryParse(rawBudget) : null,
      relativeDate: relativeDate,
      absoluteDate: absoluteDate,
      jobType: JobType.fromApifyName(json),
      experienceLevel: ExperienceLevel.fromApifyName(json),
      clientLocation: clientLocation,
      paymentVerifiedStatus: paymentVerifiedStatus,
      allowedApplicantCountries: allowedApplicantCountries,
      clientName: clientName,
      clientNameConfidencePercent: clientNameConfidence,
      clientAvgHourlyRate: clientAvgHourlyRate,
      clientRating: clientRating,
      clientHireRatePercent: clientHireRatePercent,
      clientTotalSpent: clientTotalSpent,
      hasHired: hasHired,
      questions: questions,
      tags: tags,
    );
  }
}

@freezed
abstract class ClientLocation with _$ClientLocation {
  factory ClientLocation.country({required Country country}) =
      _ClientLocationCountry;
  factory ClientLocation.region({required Region region}) =
      _ClientLocationRegion;
  factory ClientLocation.subRegion({required SubRegion subRegion}) =
      _ClientLocationSubRegion;
  factory ClientLocation.fromJson(Map<String, dynamic> json) =>
      _$ClientLocationFromJson(json);

  static ClientLocation? fromApifyJson(Map<String, dynamic> json) {
    return ClientLocation.fromName(json['clientLocation'] as String);
  }

  static ClientLocation? fromName(String name) {
    final Country? country = Country.fromName(name);
    if (country != null) {
      return ClientLocation.country(country: country);
    }
    final Region? region = Region.fromName(name);
    if (region != null) {
      return ClientLocation.region(region: region);
    }
    final SubRegion? subRegion = SubRegion.fromName(name);
    if (subRegion != null) {
      return ClientLocation.subRegion(subRegion: subRegion);
    }

    return null;
  }
}

enum PaymentVerifiedStatus { unknown, verified, unverified }

/// Additional screening questions the client has for applicants (optional, not all jobs have these)
@freezed
abstract class Question with _$Question {
  factory Question({
    required String question,
    required int
    positionIndex, // The order in which the question appears in the application process
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  factory Question.fromApify(Map<String, dynamic> json) {
    final questionText = json['question'] as String;
    final positionIndexRaw = json['position'].toString();
    final positionIndex = int.parse(positionIndexRaw);
    return Question(question: questionText, positionIndex: positionIndex);
  }
}
