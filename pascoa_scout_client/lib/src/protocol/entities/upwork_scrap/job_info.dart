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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../entities/upwork_scrap/job_type.dart' as _i2;
import '../../entities/upwork_scrap/experience_level.dart' as _i3;
import '../../entities/upwork_scrap/client_location.dart' as _i4;
import '../../entities/upwork_scrap/payment_verified_status.dart' as _i5;
import '../../entities/upwork_scrap/country.dart' as _i6;
import '../../entities/job_analysis_state.dart' as _i7;
import '../../entities/upwork_scrap/question.dart' as _i8;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i9;

abstract class JobInfo implements _i1.SerializableModel {
  JobInfo._({
    this.id,
    required this.upworkId,
    this.subId,
    required this.title,
    required this.description,
    required this.url,
    this.relativeDate,
    this.relativeDateMinutes,
    this.absoluteDate,
    this.absoluteDateTime,
    this.budget,
    this.fixedPriceAmount,
    this.hourlyMinRate,
    this.hourlyMaxRate,
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
    this.analysisState,
    this.questions,
  });

  factory JobInfo({
    int? id,
    required String upworkId,
    String? subId,
    required String title,
    required String description,
    required String url,
    String? relativeDate,
    int? relativeDateMinutes,
    String? absoluteDate,
    DateTime? absoluteDateTime,
    String? budget,
    double? fixedPriceAmount,
    double? hourlyMinRate,
    double? hourlyMaxRate,
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
    _i7.JobAnalysisState? analysisState,
    List<_i8.Question>? questions,
  }) = _JobInfoImpl;

  factory JobInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobInfo(
      id: jsonSerialization['id'] as int?,
      upworkId: jsonSerialization['upworkId'] as String,
      subId: jsonSerialization['subId'] as String?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      url: jsonSerialization['url'] as String,
      relativeDate: jsonSerialization['relativeDate'] as String?,
      relativeDateMinutes: jsonSerialization['relativeDateMinutes'] as int?,
      absoluteDate: jsonSerialization['absoluteDate'] as String?,
      absoluteDateTime: jsonSerialization['absoluteDateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['absoluteDateTime'],
            ),
      budget: jsonSerialization['budget'] as String?,
      fixedPriceAmount: (jsonSerialization['fixedPriceAmount'] as num?)
          ?.toDouble(),
      hourlyMinRate: (jsonSerialization['hourlyMinRate'] as num?)?.toDouble(),
      hourlyMaxRate: (jsonSerialization['hourlyMaxRate'] as num?)?.toDouble(),
      jobType: _i2.JobType.fromJson((jsonSerialization['jobType'] as String)),
      experienceLevel: _i3.ExperienceLevel.fromJson(
        (jsonSerialization['experienceLevel'] as String),
      ),
      clientLocation: jsonSerialization['clientLocation'] == null
          ? null
          : _i9.Protocol().deserialize<_i4.ClientLocation>(
              jsonSerialization['clientLocation'],
            ),
      paymentVerifiedStatus: _i5.PaymentVerifiedStatus.fromJson(
        (jsonSerialization['paymentVerifiedStatus'] as String),
      ),
      allowedApplicantCountries: _i9.Protocol().deserialize<List<_i6.Country>>(
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
      tags: _i9.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      hasHired: _i1.BoolJsonExtension.fromJson(jsonSerialization['hasHired']),
      analysisState: jsonSerialization['analysisState'] == null
          ? null
          : _i9.Protocol().deserialize<_i7.JobAnalysisState>(
              jsonSerialization['analysisState'],
            ),
      questions: jsonSerialization['questions'] == null
          ? null
          : _i9.Protocol().deserialize<List<_i8.Question>>(
              jsonSerialization['questions'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String upworkId;

  String? subId;

  String title;

  String description;

  String url;

  String? relativeDate;

  int? relativeDateMinutes;

  String? absoluteDate;

  DateTime? absoluteDateTime;

  String? budget;

  double? fixedPriceAmount;

  double? hourlyMinRate;

  double? hourlyMaxRate;

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

  _i7.JobAnalysisState? analysisState;

  List<_i8.Question>? questions;

  /// Returns a shallow copy of this [JobInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobInfo copyWith({
    int? id,
    String? upworkId,
    String? subId,
    String? title,
    String? description,
    String? url,
    String? relativeDate,
    int? relativeDateMinutes,
    String? absoluteDate,
    DateTime? absoluteDateTime,
    String? budget,
    double? fixedPriceAmount,
    double? hourlyMinRate,
    double? hourlyMaxRate,
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
    _i7.JobAnalysisState? analysisState,
    List<_i8.Question>? questions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobInfo',
      if (id != null) 'id': id,
      'upworkId': upworkId,
      if (subId != null) 'subId': subId,
      'title': title,
      'description': description,
      'url': url,
      if (relativeDate != null) 'relativeDate': relativeDate,
      if (relativeDateMinutes != null)
        'relativeDateMinutes': relativeDateMinutes,
      if (absoluteDate != null) 'absoluteDate': absoluteDate,
      if (absoluteDateTime != null)
        'absoluteDateTime': absoluteDateTime?.toJson(),
      if (budget != null) 'budget': budget,
      if (fixedPriceAmount != null) 'fixedPriceAmount': fixedPriceAmount,
      if (hourlyMinRate != null) 'hourlyMinRate': hourlyMinRate,
      if (hourlyMaxRate != null) 'hourlyMaxRate': hourlyMaxRate,
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
      if (analysisState != null) 'analysisState': analysisState?.toJson(),
      if (questions != null)
        'questions': questions?.toJson(valueToJson: (v) => v.toJson()),
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
    int? id,
    required String upworkId,
    String? subId,
    required String title,
    required String description,
    required String url,
    String? relativeDate,
    int? relativeDateMinutes,
    String? absoluteDate,
    DateTime? absoluteDateTime,
    String? budget,
    double? fixedPriceAmount,
    double? hourlyMinRate,
    double? hourlyMaxRate,
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
    _i7.JobAnalysisState? analysisState,
    List<_i8.Question>? questions,
  }) : super._(
         id: id,
         upworkId: upworkId,
         subId: subId,
         title: title,
         description: description,
         url: url,
         relativeDate: relativeDate,
         relativeDateMinutes: relativeDateMinutes,
         absoluteDate: absoluteDate,
         absoluteDateTime: absoluteDateTime,
         budget: budget,
         fixedPriceAmount: fixedPriceAmount,
         hourlyMinRate: hourlyMinRate,
         hourlyMaxRate: hourlyMaxRate,
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
         analysisState: analysisState,
         questions: questions,
       );

  /// Returns a shallow copy of this [JobInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobInfo copyWith({
    Object? id = _Undefined,
    String? upworkId,
    Object? subId = _Undefined,
    String? title,
    String? description,
    String? url,
    Object? relativeDate = _Undefined,
    Object? relativeDateMinutes = _Undefined,
    Object? absoluteDate = _Undefined,
    Object? absoluteDateTime = _Undefined,
    Object? budget = _Undefined,
    Object? fixedPriceAmount = _Undefined,
    Object? hourlyMinRate = _Undefined,
    Object? hourlyMaxRate = _Undefined,
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
    Object? analysisState = _Undefined,
    Object? questions = _Undefined,
  }) {
    return JobInfo(
      id: id is int? ? id : this.id,
      upworkId: upworkId ?? this.upworkId,
      subId: subId is String? ? subId : this.subId,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      relativeDate: relativeDate is String? ? relativeDate : this.relativeDate,
      relativeDateMinutes: relativeDateMinutes is int?
          ? relativeDateMinutes
          : this.relativeDateMinutes,
      absoluteDate: absoluteDate is String? ? absoluteDate : this.absoluteDate,
      absoluteDateTime: absoluteDateTime is DateTime?
          ? absoluteDateTime
          : this.absoluteDateTime,
      budget: budget is String? ? budget : this.budget,
      fixedPriceAmount: fixedPriceAmount is double?
          ? fixedPriceAmount
          : this.fixedPriceAmount,
      hourlyMinRate: hourlyMinRate is double?
          ? hourlyMinRate
          : this.hourlyMinRate,
      hourlyMaxRate: hourlyMaxRate is double?
          ? hourlyMaxRate
          : this.hourlyMaxRate,
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
      analysisState: analysisState is _i7.JobAnalysisState?
          ? analysisState
          : this.analysisState?.copyWith(),
      questions: questions is List<_i8.Question>?
          ? questions
          : this.questions?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
