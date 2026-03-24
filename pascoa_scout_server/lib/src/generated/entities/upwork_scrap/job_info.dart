/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../entities/upwork_scrap/job_type.dart' as _i2;
import '../../entities/upwork_scrap/experience_level.dart' as _i3;
import '../../entities/upwork_scrap/client_location.dart' as _i4;
import '../../entities/upwork_scrap/payment_verified_status.dart' as _i5;
import '../../entities/upwork_scrap/country.dart' as _i6;
import '../../entities/job_analysis_state.dart' as _i7;
import '../../entities/upwork_scrap/question.dart' as _i8;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i9;

abstract class JobInfo
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = JobInfoTable();

  static const db = JobInfoRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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
      if (analysisState != null)
        'analysisState': analysisState?.toJsonForProtocol(),
      if (questions != null)
        'questions': questions?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static JobInfoInclude include({
    _i7.JobAnalysisStateInclude? analysisState,
    _i8.QuestionIncludeList? questions,
  }) {
    return JobInfoInclude._(
      analysisState: analysisState,
      questions: questions,
    );
  }

  static JobInfoIncludeList includeList({
    _i1.WhereExpressionBuilder<JobInfoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobInfoTable>? orderByList,
    JobInfoInclude? include,
  }) {
    return JobInfoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobInfo.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JobInfo.t),
      include: include,
    );
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

class JobInfoUpdateTable extends _i1.UpdateTable<JobInfoTable> {
  JobInfoUpdateTable(super.table);

  _i1.ColumnValue<String, String> upworkId(String value) => _i1.ColumnValue(
    table.upworkId,
    value,
  );

  _i1.ColumnValue<String, String> subId(String? value) => _i1.ColumnValue(
    table.subId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> url(String value) => _i1.ColumnValue(
    table.url,
    value,
  );

  _i1.ColumnValue<String, String> relativeDate(String? value) =>
      _i1.ColumnValue(
        table.relativeDate,
        value,
      );

  _i1.ColumnValue<int, int> relativeDateMinutes(int? value) => _i1.ColumnValue(
    table.relativeDateMinutes,
    value,
  );

  _i1.ColumnValue<String, String> absoluteDate(String? value) =>
      _i1.ColumnValue(
        table.absoluteDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> absoluteDateTime(DateTime? value) =>
      _i1.ColumnValue(
        table.absoluteDateTime,
        value,
      );

  _i1.ColumnValue<String, String> budget(String? value) => _i1.ColumnValue(
    table.budget,
    value,
  );

  _i1.ColumnValue<double, double> fixedPriceAmount(double? value) =>
      _i1.ColumnValue(
        table.fixedPriceAmount,
        value,
      );

  _i1.ColumnValue<double, double> hourlyMinRate(double? value) =>
      _i1.ColumnValue(
        table.hourlyMinRate,
        value,
      );

  _i1.ColumnValue<double, double> hourlyMaxRate(double? value) =>
      _i1.ColumnValue(
        table.hourlyMaxRate,
        value,
      );

  _i1.ColumnValue<_i2.JobType, _i2.JobType> jobType(_i2.JobType value) =>
      _i1.ColumnValue(
        table.jobType,
        value,
      );

  _i1.ColumnValue<_i3.ExperienceLevel, _i3.ExperienceLevel> experienceLevel(
    _i3.ExperienceLevel value,
  ) => _i1.ColumnValue(
    table.experienceLevel,
    value,
  );

  _i1.ColumnValue<_i4.ClientLocation, _i4.ClientLocation> clientLocation(
    _i4.ClientLocation? value,
  ) => _i1.ColumnValue(
    table.clientLocation,
    value,
  );

  _i1.ColumnValue<_i5.PaymentVerifiedStatus, _i5.PaymentVerifiedStatus>
  paymentVerifiedStatus(_i5.PaymentVerifiedStatus value) => _i1.ColumnValue(
    table.paymentVerifiedStatus,
    value,
  );

  _i1.ColumnValue<List<_i6.Country>, List<_i6.Country>>
  allowedApplicantCountries(List<_i6.Country> value) => _i1.ColumnValue(
    table.allowedApplicantCountries,
    value,
  );

  _i1.ColumnValue<String, String> clientName(String? value) => _i1.ColumnValue(
    table.clientName,
    value,
  );

  _i1.ColumnValue<double, double> clientNameConfidencePercent(double? value) =>
      _i1.ColumnValue(
        table.clientNameConfidencePercent,
        value,
      );

  _i1.ColumnValue<double, double> clientAvgHourlyRate(double? value) =>
      _i1.ColumnValue(
        table.clientAvgHourlyRate,
        value,
      );

  _i1.ColumnValue<double, double> clientRating(double? value) =>
      _i1.ColumnValue(
        table.clientRating,
        value,
      );

  _i1.ColumnValue<double, double> clientHireRatePercent(double? value) =>
      _i1.ColumnValue(
        table.clientHireRatePercent,
        value,
      );

  _i1.ColumnValue<double, double> clientTotalSpent(double? value) =>
      _i1.ColumnValue(
        table.clientTotalSpent,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> tags(List<String> value) =>
      _i1.ColumnValue(
        table.tags,
        value,
      );

  _i1.ColumnValue<bool, bool> hasHired(bool value) => _i1.ColumnValue(
    table.hasHired,
    value,
  );
}

class JobInfoTable extends _i1.Table<int?> {
  JobInfoTable({super.tableRelation}) : super(tableName: 'job_info') {
    updateTable = JobInfoUpdateTable(this);
    upworkId = _i1.ColumnString(
      'upworkId',
      this,
    );
    subId = _i1.ColumnString(
      'subId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    url = _i1.ColumnString(
      'url',
      this,
    );
    relativeDate = _i1.ColumnString(
      'relativeDate',
      this,
    );
    relativeDateMinutes = _i1.ColumnInt(
      'relativeDateMinutes',
      this,
    );
    absoluteDate = _i1.ColumnString(
      'absoluteDate',
      this,
    );
    absoluteDateTime = _i1.ColumnDateTime(
      'absoluteDateTime',
      this,
    );
    budget = _i1.ColumnString(
      'budget',
      this,
    );
    fixedPriceAmount = _i1.ColumnDouble(
      'fixedPriceAmount',
      this,
    );
    hourlyMinRate = _i1.ColumnDouble(
      'hourlyMinRate',
      this,
    );
    hourlyMaxRate = _i1.ColumnDouble(
      'hourlyMaxRate',
      this,
    );
    jobType = _i1.ColumnEnum(
      'jobType',
      this,
      _i1.EnumSerialization.byName,
    );
    experienceLevel = _i1.ColumnEnum(
      'experienceLevel',
      this,
      _i1.EnumSerialization.byName,
    );
    clientLocation = _i1.ColumnSerializable<_i4.ClientLocation>(
      'clientLocation',
      this,
    );
    paymentVerifiedStatus = _i1.ColumnEnum(
      'paymentVerifiedStatus',
      this,
      _i1.EnumSerialization.byName,
    );
    allowedApplicantCountries = _i1.ColumnSerializable<List<_i6.Country>>(
      'allowedApplicantCountries',
      this,
    );
    clientName = _i1.ColumnString(
      'clientName',
      this,
    );
    clientNameConfidencePercent = _i1.ColumnDouble(
      'clientNameConfidencePercent',
      this,
    );
    clientAvgHourlyRate = _i1.ColumnDouble(
      'clientAvgHourlyRate',
      this,
    );
    clientRating = _i1.ColumnDouble(
      'clientRating',
      this,
    );
    clientHireRatePercent = _i1.ColumnDouble(
      'clientHireRatePercent',
      this,
    );
    clientTotalSpent = _i1.ColumnDouble(
      'clientTotalSpent',
      this,
    );
    tags = _i1.ColumnSerializable<List<String>>(
      'tags',
      this,
    );
    hasHired = _i1.ColumnBool(
      'hasHired',
      this,
    );
  }

  late final JobInfoUpdateTable updateTable;

  late final _i1.ColumnString upworkId;

  late final _i1.ColumnString subId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString url;

  late final _i1.ColumnString relativeDate;

  late final _i1.ColumnInt relativeDateMinutes;

  late final _i1.ColumnString absoluteDate;

  late final _i1.ColumnDateTime absoluteDateTime;

  late final _i1.ColumnString budget;

  late final _i1.ColumnDouble fixedPriceAmount;

  late final _i1.ColumnDouble hourlyMinRate;

  late final _i1.ColumnDouble hourlyMaxRate;

  late final _i1.ColumnEnum<_i2.JobType> jobType;

  late final _i1.ColumnEnum<_i3.ExperienceLevel> experienceLevel;

  late final _i1.ColumnSerializable<_i4.ClientLocation> clientLocation;

  late final _i1.ColumnEnum<_i5.PaymentVerifiedStatus> paymentVerifiedStatus;

  late final _i1.ColumnSerializable<List<_i6.Country>>
  allowedApplicantCountries;

  late final _i1.ColumnString clientName;

  late final _i1.ColumnDouble clientNameConfidencePercent;

  late final _i1.ColumnDouble clientAvgHourlyRate;

  late final _i1.ColumnDouble clientRating;

  late final _i1.ColumnDouble clientHireRatePercent;

  late final _i1.ColumnDouble clientTotalSpent;

  late final _i1.ColumnSerializable<List<String>> tags;

  late final _i1.ColumnBool hasHired;

  _i7.JobAnalysisStateTable? _analysisState;

  _i8.QuestionTable? ___questions;

  _i1.ManyRelation<_i8.QuestionTable>? _questions;

  _i7.JobAnalysisStateTable get analysisState {
    if (_analysisState != null) return _analysisState!;
    _analysisState = _i1.createRelationTable(
      relationFieldName: 'analysisState',
      field: JobInfo.t.id,
      foreignField: _i7.JobAnalysisState.t.jobInfoId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7.JobAnalysisStateTable(tableRelation: foreignTableRelation),
    );
    return _analysisState!;
  }

  _i8.QuestionTable get __questions {
    if (___questions != null) return ___questions!;
    ___questions = _i1.createRelationTable(
      relationFieldName: '__questions',
      field: JobInfo.t.id,
      foreignField: _i8.Question.t.jobInfoId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.QuestionTable(tableRelation: foreignTableRelation),
    );
    return ___questions!;
  }

  _i1.ManyRelation<_i8.QuestionTable> get questions {
    if (_questions != null) return _questions!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'questions',
      field: JobInfo.t.id,
      foreignField: _i8.Question.t.jobInfoId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i8.QuestionTable(tableRelation: foreignTableRelation),
    );
    _questions = _i1.ManyRelation<_i8.QuestionTable>(
      tableWithRelations: relationTable,
      table: _i8.QuestionTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _questions!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    upworkId,
    subId,
    title,
    description,
    url,
    relativeDate,
    relativeDateMinutes,
    absoluteDate,
    absoluteDateTime,
    budget,
    fixedPriceAmount,
    hourlyMinRate,
    hourlyMaxRate,
    jobType,
    experienceLevel,
    clientLocation,
    paymentVerifiedStatus,
    allowedApplicantCountries,
    clientName,
    clientNameConfidencePercent,
    clientAvgHourlyRate,
    clientRating,
    clientHireRatePercent,
    clientTotalSpent,
    tags,
    hasHired,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'analysisState') {
      return analysisState;
    }
    if (relationField == 'questions') {
      return __questions;
    }
    return null;
  }
}

class JobInfoInclude extends _i1.IncludeObject {
  JobInfoInclude._({
    _i7.JobAnalysisStateInclude? analysisState,
    _i8.QuestionIncludeList? questions,
  }) {
    _analysisState = analysisState;
    _questions = questions;
  }

  _i7.JobAnalysisStateInclude? _analysisState;

  _i8.QuestionIncludeList? _questions;

  @override
  Map<String, _i1.Include?> get includes => {
    'analysisState': _analysisState,
    'questions': _questions,
  };

  @override
  _i1.Table<int?> get table => JobInfo.t;
}

class JobInfoIncludeList extends _i1.IncludeList {
  JobInfoIncludeList._({
    _i1.WhereExpressionBuilder<JobInfoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobInfo.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JobInfo.t;
}

class JobInfoRepository {
  const JobInfoRepository._();

  final attach = const JobInfoAttachRepository._();

  final attachRow = const JobInfoAttachRowRepository._();

  final detach = const JobInfoDetachRepository._();

  final detachRow = const JobInfoDetachRowRepository._();

  /// Returns a list of [JobInfo]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<JobInfo>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobInfoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobInfoTable>? orderByList,
    _i1.Transaction? transaction,
    JobInfoInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobInfo>(
      where: where?.call(JobInfo.t),
      orderBy: orderBy?.call(JobInfo.t),
      orderByList: orderByList?.call(JobInfo.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobInfo] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<JobInfo?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobInfoTable>? where,
    int? offset,
    _i1.OrderByBuilder<JobInfoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JobInfoTable>? orderByList,
    _i1.Transaction? transaction,
    JobInfoInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobInfo>(
      where: where?.call(JobInfo.t),
      orderBy: orderBy?.call(JobInfo.t),
      orderByList: orderByList?.call(JobInfo.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobInfo] by its [id] or null if no such row exists.
  Future<JobInfo?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    JobInfoInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobInfo>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobInfo]s in the list and returns the inserted rows.
  ///
  /// The returned [JobInfo]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<JobInfo>> insert(
    _i1.DatabaseSession session,
    List<JobInfo> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<JobInfo>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [JobInfo] and returns the inserted row.
  ///
  /// The returned [JobInfo] will have its `id` field set.
  Future<JobInfo> insertRow(
    _i1.DatabaseSession session,
    JobInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobInfo>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JobInfo]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JobInfo>> update(
    _i1.DatabaseSession session,
    List<JobInfo> rows, {
    _i1.ColumnSelections<JobInfoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JobInfo>(
      rows,
      columns: columns?.call(JobInfo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobInfo]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobInfo> updateRow(
    _i1.DatabaseSession session,
    JobInfo row, {
    _i1.ColumnSelections<JobInfoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobInfo>(
      row,
      columns: columns?.call(JobInfo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobInfo] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobInfo?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<JobInfoUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JobInfo>(
      id,
      columnValues: columnValues(JobInfo.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobInfo]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JobInfo>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<JobInfoUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<JobInfoTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JobInfoTable>? orderBy,
    _i1.OrderByListBuilder<JobInfoTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JobInfo>(
      columnValues: columnValues(JobInfo.t.updateTable),
      where: where(JobInfo.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobInfo.t),
      orderByList: orderByList?.call(JobInfo.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JobInfo]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JobInfo>> delete(
    _i1.DatabaseSession session,
    List<JobInfo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JobInfo>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JobInfo].
  Future<JobInfo> deleteRow(
    _i1.DatabaseSession session,
    JobInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobInfo>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JobInfo>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobInfoTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JobInfo>(
      where: where(JobInfo.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<JobInfoTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JobInfo>(
      where: where?.call(JobInfo.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobInfo] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<JobInfoTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobInfo>(
      where: where(JobInfo.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class JobInfoAttachRepository {
  const JobInfoAttachRepository._();

  /// Creates a relation between this [JobInfo] and the given [Question]s
  /// by setting each [Question]'s foreign key `jobInfoId` to refer to this [JobInfo].
  Future<void> questions(
    _i1.DatabaseSession session,
    JobInfo jobInfo,
    List<_i8.Question> question, {
    _i1.Transaction? transaction,
  }) async {
    if (question.any((e) => e.id == null)) {
      throw ArgumentError.notNull('question.id');
    }
    if (jobInfo.id == null) {
      throw ArgumentError.notNull('jobInfo.id');
    }

    var $question = question
        .map((e) => e.copyWith(jobInfoId: jobInfo.id))
        .toList();
    await session.db.update<_i8.Question>(
      $question,
      columns: [_i8.Question.t.jobInfoId],
      transaction: transaction,
    );
  }
}

class JobInfoAttachRowRepository {
  const JobInfoAttachRowRepository._();

  /// Creates a relation between the given [JobInfo] and [JobAnalysisState]
  /// by setting the [JobInfo]'s foreign key `id` to refer to the [JobAnalysisState].
  Future<void> analysisState(
    _i1.DatabaseSession session,
    JobInfo jobInfo,
    _i7.JobAnalysisState analysisState, {
    _i1.Transaction? transaction,
  }) async {
    if (analysisState.id == null) {
      throw ArgumentError.notNull('analysisState.id');
    }
    if (jobInfo.id == null) {
      throw ArgumentError.notNull('jobInfo.id');
    }

    var $analysisState = analysisState.copyWith(jobInfoId: jobInfo.id);
    await session.db.updateRow<_i7.JobAnalysisState>(
      $analysisState,
      columns: [_i7.JobAnalysisState.t.jobInfoId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [JobInfo] and the given [Question]
  /// by setting the [Question]'s foreign key `jobInfoId` to refer to this [JobInfo].
  Future<void> questions(
    _i1.DatabaseSession session,
    JobInfo jobInfo,
    _i8.Question question, {
    _i1.Transaction? transaction,
  }) async {
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }
    if (jobInfo.id == null) {
      throw ArgumentError.notNull('jobInfo.id');
    }

    var $question = question.copyWith(jobInfoId: jobInfo.id);
    await session.db.updateRow<_i8.Question>(
      $question,
      columns: [_i8.Question.t.jobInfoId],
      transaction: transaction,
    );
  }
}

class JobInfoDetachRepository {
  const JobInfoDetachRepository._();

  /// Detaches the relation between this [JobInfo] and the given [Question]
  /// by setting the [Question]'s foreign key `jobInfoId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> questions(
    _i1.DatabaseSession session,
    List<_i8.Question> question, {
    _i1.Transaction? transaction,
  }) async {
    if (question.any((e) => e.id == null)) {
      throw ArgumentError.notNull('question.id');
    }

    var $question = question.map((e) => e.copyWith(jobInfoId: null)).toList();
    await session.db.update<_i8.Question>(
      $question,
      columns: [_i8.Question.t.jobInfoId],
      transaction: transaction,
    );
  }
}

class JobInfoDetachRowRepository {
  const JobInfoDetachRowRepository._();

  /// Detaches the relation between this [JobInfo] and the given [Question]
  /// by setting the [Question]'s foreign key `jobInfoId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> questions(
    _i1.DatabaseSession session,
    _i8.Question question, {
    _i1.Transaction? transaction,
  }) async {
    if (question.id == null) {
      throw ArgumentError.notNull('question.id');
    }

    var $question = question.copyWith(jobInfoId: null);
    await session.db.updateRow<_i8.Question>(
      $question,
      columns: [_i8.Question.t.jobInfoId],
      transaction: transaction,
    );
  }
}
