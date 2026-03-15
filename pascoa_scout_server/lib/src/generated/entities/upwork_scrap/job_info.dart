/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../entities/upwork_scrap/job_type.dart' as _i2;
import '../../entities/upwork_scrap/experience_level.dart' as _i3;
import '../../entities/upwork_scrap/client_location.dart' as _i4;
import '../../entities/upwork_scrap/payment_verified_status.dart' as _i5;
import '../../entities/upwork_scrap/country.dart' as _i6;
import '../../entities/upwork_scrap/question.dart' as _i7;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i8;

abstract class JobInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  JobInfo._({
    required this.id,
    this.subId,
    required this.title,
    required this.description,
    required this.url,
    this.relativeDate,
    this.absoluteDate,
    this.budget,
    required this.jobType,
    required this.experienceLevel,
    this.clientLocation,
    required this.paymentVerifiedStatus,
    required this.allowedApplicantCountries,
    this.clientName,
    this.clientNameConfidencePercent,
    this.clientAvgHourlyRate,
    this.clientRating,
    this.clientHireRatePercent,
    this.clientTotalSpent,
    required this.tags,
    required this.hasHired,
    required this.questions,
  });

  factory JobInfo({
    required String id,
    String? subId,
    required String title,
    required String description,
    required String url,
    String? relativeDate,
    String? absoluteDate,
    String? budget,
    required _i2.JobType jobType,
    required _i3.ExperienceLevel experienceLevel,
    _i4.ClientLocation? clientLocation,
    required _i5.PaymentVerifiedStatus paymentVerifiedStatus,
    required List<_i6.Country> allowedApplicantCountries,
    String? clientName,
    double? clientNameConfidencePercent,
    double? clientAvgHourlyRate,
    double? clientRating,
    double? clientHireRatePercent,
    double? clientTotalSpent,
    required List<String> tags,
    required bool hasHired,
    required List<_i7.Question> questions,
  }) = _JobInfoImpl;

  factory JobInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobInfo(
      id: jsonSerialization['id'] as String,
      subId: jsonSerialization['subId'] as String?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      url: jsonSerialization['url'] as String,
      relativeDate: jsonSerialization['relativeDate'] as String?,
      absoluteDate: jsonSerialization['absoluteDate'] as String?,
      budget: jsonSerialization['budget'] as String?,
      jobType: _i2.JobType.fromJson((jsonSerialization['jobType'] as String)),
      experienceLevel: _i3.ExperienceLevel.fromJson(
        (jsonSerialization['experienceLevel'] as String),
      ),
      clientLocation: jsonSerialization['clientLocation'] == null
          ? null
          : _i8.Protocol().deserialize<_i4.ClientLocation>(
              jsonSerialization['clientLocation'],
            ),
      paymentVerifiedStatus: _i5.PaymentVerifiedStatus.fromJson(
        (jsonSerialization['paymentVerifiedStatus'] as String),
      ),
      allowedApplicantCountries: _i8.Protocol().deserialize<List<_i6.Country>>(
        jsonSerialization['allowedApplicantCountries'],
      ),
      clientName: jsonSerialization['clientName'] as String?,
      clientNameConfidencePercent:
          (jsonSerialization['clientNameConfidencePercent'] as num?)
              ?.toDouble(),
      clientAvgHourlyRate: (jsonSerialization['clientAvgHourlyRate'] as num?)
          ?.toDouble(),
      clientRating: (jsonSerialization['clientRating'] as num?)?.toDouble(),
      clientHireRatePercent:
          (jsonSerialization['clientHireRatePercent'] as num?)?.toDouble(),
      clientTotalSpent: (jsonSerialization['clientTotalSpent'] as num?)
          ?.toDouble(),
      tags: _i8.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      hasHired: _i1.BoolJsonExtension.fromJson(jsonSerialization['hasHired']),
      questions: _i8.Protocol().deserialize<List<_i7.Question>>(
        jsonSerialization['questions'],
      ),
    );
  }

  String id;

  String? subId;

  String title;

  String description;

  String url;

  String? relativeDate;

  String? absoluteDate;

  String? budget;

  _i2.JobType jobType;

  _i3.ExperienceLevel experienceLevel;

  _i4.ClientLocation? clientLocation;

  _i5.PaymentVerifiedStatus paymentVerifiedStatus;

  List<_i6.Country> allowedApplicantCountries;

  String? clientName;

  double? clientNameConfidencePercent;

  double? clientAvgHourlyRate;

  double? clientRating;

  double? clientHireRatePercent;

  double? clientTotalSpent;

  List<String> tags;

  bool hasHired;

  List<_i7.Question> questions;

  /// Returns a shallow copy of this [JobInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobInfo copyWith({
    String? id,
    String? subId,
    String? title,
    String? description,
    String? url,
    String? relativeDate,
    String? absoluteDate,
    String? budget,
    _i2.JobType? jobType,
    _i3.ExperienceLevel? experienceLevel,
    _i4.ClientLocation? clientLocation,
    _i5.PaymentVerifiedStatus? paymentVerifiedStatus,
    List<_i6.Country>? allowedApplicantCountries,
    String? clientName,
    double? clientNameConfidencePercent,
    double? clientAvgHourlyRate,
    double? clientRating,
    double? clientHireRatePercent,
    double? clientTotalSpent,
    List<String>? tags,
    bool? hasHired,
    List<_i7.Question>? questions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobInfo',
      'id': id,
      if (subId != null) 'subId': subId,
      'title': title,
      'description': description,
      'url': url,
      if (relativeDate != null) 'relativeDate': relativeDate,
      if (absoluteDate != null) 'absoluteDate': absoluteDate,
      if (budget != null) 'budget': budget,
      'jobType': jobType.toJson(),
      'experienceLevel': experienceLevel.toJson(),
      if (clientLocation != null) 'clientLocation': clientLocation?.toJson(),
      'paymentVerifiedStatus': paymentVerifiedStatus.toJson(),
      'allowedApplicantCountries': allowedApplicantCountries.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      if (clientName != null) 'clientName': clientName,
      if (clientNameConfidencePercent != null)
        'clientNameConfidencePercent': clientNameConfidencePercent,
      if (clientAvgHourlyRate != null)
        'clientAvgHourlyRate': clientAvgHourlyRate,
      if (clientRating != null) 'clientRating': clientRating,
      if (clientHireRatePercent != null)
        'clientHireRatePercent': clientHireRatePercent,
      if (clientTotalSpent != null) 'clientTotalSpent': clientTotalSpent,
      'tags': tags.toJson(),
      'hasHired': hasHired,
      'questions': questions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobInfo',
      'id': id,
      if (subId != null) 'subId': subId,
      'title': title,
      'description': description,
      'url': url,
      if (relativeDate != null) 'relativeDate': relativeDate,
      if (absoluteDate != null) 'absoluteDate': absoluteDate,
      if (budget != null) 'budget': budget,
      'jobType': jobType.toJson(),
      'experienceLevel': experienceLevel.toJson(),
      if (clientLocation != null)
        'clientLocation': clientLocation?.toJsonForProtocol(),
      'paymentVerifiedStatus': paymentVerifiedStatus.toJson(),
      'allowedApplicantCountries': allowedApplicantCountries.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      if (clientName != null) 'clientName': clientName,
      if (clientNameConfidencePercent != null)
        'clientNameConfidencePercent': clientNameConfidencePercent,
      if (clientAvgHourlyRate != null)
        'clientAvgHourlyRate': clientAvgHourlyRate,
      if (clientRating != null) 'clientRating': clientRating,
      if (clientHireRatePercent != null)
        'clientHireRatePercent': clientHireRatePercent,
      if (clientTotalSpent != null) 'clientTotalSpent': clientTotalSpent,
      'tags': tags.toJson(),
      'hasHired': hasHired,
      'questions': questions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobInfoImpl extends JobInfo {
  _JobInfoImpl({
    required String id,
    String? subId,
    required String title,
    required String description,
    required String url,
    String? relativeDate,
    String? absoluteDate,
    String? budget,
    required _i2.JobType jobType,
    required _i3.ExperienceLevel experienceLevel,
    _i4.ClientLocation? clientLocation,
    required _i5.PaymentVerifiedStatus paymentVerifiedStatus,
    required List<_i6.Country> allowedApplicantCountries,
    String? clientName,
    double? clientNameConfidencePercent,
    double? clientAvgHourlyRate,
    double? clientRating,
    double? clientHireRatePercent,
    double? clientTotalSpent,
    required List<String> tags,
    required bool hasHired,
    required List<_i7.Question> questions,
  }) : super._(
         id: id,
         subId: subId,
         title: title,
         description: description,
         url: url,
         relativeDate: relativeDate,
         absoluteDate: absoluteDate,
         budget: budget,
         jobType: jobType,
         experienceLevel: experienceLevel,
         clientLocation: clientLocation,
         paymentVerifiedStatus: paymentVerifiedStatus,
         allowedApplicantCountries: allowedApplicantCountries,
         clientName: clientName,
         clientNameConfidencePercent: clientNameConfidencePercent,
         clientAvgHourlyRate: clientAvgHourlyRate,
         clientRating: clientRating,
         clientHireRatePercent: clientHireRatePercent,
         clientTotalSpent: clientTotalSpent,
         tags: tags,
         hasHired: hasHired,
         questions: questions,
       );

  /// Returns a shallow copy of this [JobInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobInfo copyWith({
    String? id,
    Object? subId = _Undefined,
    String? title,
    String? description,
    String? url,
    Object? relativeDate = _Undefined,
    Object? absoluteDate = _Undefined,
    Object? budget = _Undefined,
    _i2.JobType? jobType,
    _i3.ExperienceLevel? experienceLevel,
    Object? clientLocation = _Undefined,
    _i5.PaymentVerifiedStatus? paymentVerifiedStatus,
    List<_i6.Country>? allowedApplicantCountries,
    Object? clientName = _Undefined,
    Object? clientNameConfidencePercent = _Undefined,
    Object? clientAvgHourlyRate = _Undefined,
    Object? clientRating = _Undefined,
    Object? clientHireRatePercent = _Undefined,
    Object? clientTotalSpent = _Undefined,
    List<String>? tags,
    bool? hasHired,
    List<_i7.Question>? questions,
  }) {
    return JobInfo(
      id: id ?? this.id,
      subId: subId is String? ? subId : this.subId,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      relativeDate: relativeDate is String? ? relativeDate : this.relativeDate,
      absoluteDate: absoluteDate is String? ? absoluteDate : this.absoluteDate,
      budget: budget is String? ? budget : this.budget,
      jobType: jobType ?? this.jobType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      clientLocation: clientLocation is _i4.ClientLocation?
          ? clientLocation
          : this.clientLocation?.copyWith(),
      paymentVerifiedStatus:
          paymentVerifiedStatus ?? this.paymentVerifiedStatus,
      allowedApplicantCountries:
          allowedApplicantCountries ??
          this.allowedApplicantCountries.map((e0) => e0).toList(),
      clientName: clientName is String? ? clientName : this.clientName,
      clientNameConfidencePercent: clientNameConfidencePercent is double?
          ? clientNameConfidencePercent
          : this.clientNameConfidencePercent,
      clientAvgHourlyRate: clientAvgHourlyRate is double?
          ? clientAvgHourlyRate
          : this.clientAvgHourlyRate,
      clientRating: clientRating is double? ? clientRating : this.clientRating,
      clientHireRatePercent: clientHireRatePercent is double?
          ? clientHireRatePercent
          : this.clientHireRatePercent,
      clientTotalSpent: clientTotalSpent is double?
          ? clientTotalSpent
          : this.clientTotalSpent,
      tags: tags ?? this.tags.map((e0) => e0).toList(),
      hasHired: hasHired ?? this.hasHired,
      questions:
          questions ?? this.questions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
