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
import '../entities/job_analysis_filter_mode.dart' as _i2;
import '../entities/job_analysis_order_by.dart' as _i3;

abstract class JobAnalysisListFilter
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  JobAnalysisListFilter._({
    required this.page,
    required this.pageSize,
    required this.analysisFilter,
    required this.orderBy,
    this.referencePaginationHourStamp,
    this.searchTerm,
    this.hasQuestions,
    this.minimumScorePercentage,
    this.maximumScorePercentage,
    this.maxAgeJobInfoHours,
    this.maxAgeScoringHours,
    this.maxAgeAiResponsesHours,
  });

  factory JobAnalysisListFilter({
    required int page,
    required int pageSize,
    required _i2.JobAnalysisFilterMode analysisFilter,
    required _i3.JobAnalysisOrderBy orderBy,
    DateTime? referencePaginationHourStamp,
    String? searchTerm,
    bool? hasQuestions,
    int? minimumScorePercentage,
    int? maximumScorePercentage,
    int? maxAgeJobInfoHours,
    int? maxAgeScoringHours,
    int? maxAgeAiResponsesHours,
  }) = _JobAnalysisListFilterImpl;

  factory JobAnalysisListFilter.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAnalysisListFilter(
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
      analysisFilter: _i2.JobAnalysisFilterMode.fromJson(
        (jsonSerialization['analysisFilter'] as String),
      ),
      orderBy: _i3.JobAnalysisOrderBy.fromJson(
        (jsonSerialization['orderBy'] as String),
      ),
      referencePaginationHourStamp:
          jsonSerialization['referencePaginationHourStamp'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['referencePaginationHourStamp'],
            ),
      searchTerm: jsonSerialization['searchTerm'] as String?,
      hasQuestions: jsonSerialization['hasQuestions'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['hasQuestions']),
      minimumScorePercentage:
          jsonSerialization['minimumScorePercentage'] as int?,
      maximumScorePercentage:
          jsonSerialization['maximumScorePercentage'] as int?,
      maxAgeJobInfoHours: jsonSerialization['maxAgeJobInfoHours'] as int?,
      maxAgeScoringHours: jsonSerialization['maxAgeScoringHours'] as int?,
      maxAgeAiResponsesHours:
          jsonSerialization['maxAgeAiResponsesHours'] as int?,
    );
  }

  int page;

  int pageSize;

  _i2.JobAnalysisFilterMode analysisFilter;

  _i3.JobAnalysisOrderBy orderBy;

  DateTime? referencePaginationHourStamp;

  String? searchTerm;

  bool? hasQuestions;

  int? minimumScorePercentage;

  int? maximumScorePercentage;

  int? maxAgeJobInfoHours;

  int? maxAgeScoringHours;

  int? maxAgeAiResponsesHours;

  /// Returns a shallow copy of this [JobAnalysisListFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAnalysisListFilter copyWith({
    int? page,
    int? pageSize,
    _i2.JobAnalysisFilterMode? analysisFilter,
    _i3.JobAnalysisOrderBy? orderBy,
    DateTime? referencePaginationHourStamp,
    String? searchTerm,
    bool? hasQuestions,
    int? minimumScorePercentage,
    int? maximumScorePercentage,
    int? maxAgeJobInfoHours,
    int? maxAgeScoringHours,
    int? maxAgeAiResponsesHours,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAnalysisListFilter',
      'page': page,
      'pageSize': pageSize,
      'analysisFilter': analysisFilter.toJson(),
      'orderBy': orderBy.toJson(),
      if (referencePaginationHourStamp != null)
        'referencePaginationHourStamp': referencePaginationHourStamp?.toJson(),
      if (searchTerm != null) 'searchTerm': searchTerm,
      if (hasQuestions != null) 'hasQuestions': hasQuestions,
      if (minimumScorePercentage != null)
        'minimumScorePercentage': minimumScorePercentage,
      if (maximumScorePercentage != null)
        'maximumScorePercentage': maximumScorePercentage,
      if (maxAgeJobInfoHours != null) 'maxAgeJobInfoHours': maxAgeJobInfoHours,
      if (maxAgeScoringHours != null) 'maxAgeScoringHours': maxAgeScoringHours,
      if (maxAgeAiResponsesHours != null)
        'maxAgeAiResponsesHours': maxAgeAiResponsesHours,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobAnalysisListFilter',
      'page': page,
      'pageSize': pageSize,
      'analysisFilter': analysisFilter.toJson(),
      'orderBy': orderBy.toJson(),
      if (referencePaginationHourStamp != null)
        'referencePaginationHourStamp': referencePaginationHourStamp?.toJson(),
      if (searchTerm != null) 'searchTerm': searchTerm,
      if (hasQuestions != null) 'hasQuestions': hasQuestions,
      if (minimumScorePercentage != null)
        'minimumScorePercentage': minimumScorePercentage,
      if (maximumScorePercentage != null)
        'maximumScorePercentage': maximumScorePercentage,
      if (maxAgeJobInfoHours != null) 'maxAgeJobInfoHours': maxAgeJobInfoHours,
      if (maxAgeScoringHours != null) 'maxAgeScoringHours': maxAgeScoringHours,
      if (maxAgeAiResponsesHours != null)
        'maxAgeAiResponsesHours': maxAgeAiResponsesHours,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAnalysisListFilterImpl extends JobAnalysisListFilter {
  _JobAnalysisListFilterImpl({
    required int page,
    required int pageSize,
    required _i2.JobAnalysisFilterMode analysisFilter,
    required _i3.JobAnalysisOrderBy orderBy,
    DateTime? referencePaginationHourStamp,
    String? searchTerm,
    bool? hasQuestions,
    int? minimumScorePercentage,
    int? maximumScorePercentage,
    int? maxAgeJobInfoHours,
    int? maxAgeScoringHours,
    int? maxAgeAiResponsesHours,
  }) : super._(
         page: page,
         pageSize: pageSize,
         analysisFilter: analysisFilter,
         orderBy: orderBy,
         referencePaginationHourStamp: referencePaginationHourStamp,
         searchTerm: searchTerm,
         hasQuestions: hasQuestions,
         minimumScorePercentage: minimumScorePercentage,
         maximumScorePercentage: maximumScorePercentage,
         maxAgeJobInfoHours: maxAgeJobInfoHours,
         maxAgeScoringHours: maxAgeScoringHours,
         maxAgeAiResponsesHours: maxAgeAiResponsesHours,
       );

  /// Returns a shallow copy of this [JobAnalysisListFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAnalysisListFilter copyWith({
    int? page,
    int? pageSize,
    _i2.JobAnalysisFilterMode? analysisFilter,
    _i3.JobAnalysisOrderBy? orderBy,
    Object? referencePaginationHourStamp = _Undefined,
    Object? searchTerm = _Undefined,
    Object? hasQuestions = _Undefined,
    Object? minimumScorePercentage = _Undefined,
    Object? maximumScorePercentage = _Undefined,
    Object? maxAgeJobInfoHours = _Undefined,
    Object? maxAgeScoringHours = _Undefined,
    Object? maxAgeAiResponsesHours = _Undefined,
  }) {
    return JobAnalysisListFilter(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      analysisFilter: analysisFilter ?? this.analysisFilter,
      orderBy: orderBy ?? this.orderBy,
      referencePaginationHourStamp: referencePaginationHourStamp is DateTime?
          ? referencePaginationHourStamp
          : this.referencePaginationHourStamp,
      searchTerm: searchTerm is String? ? searchTerm : this.searchTerm,
      hasQuestions: hasQuestions is bool? ? hasQuestions : this.hasQuestions,
      minimumScorePercentage: minimumScorePercentage is int?
          ? minimumScorePercentage
          : this.minimumScorePercentage,
      maximumScorePercentage: maximumScorePercentage is int?
          ? maximumScorePercentage
          : this.maximumScorePercentage,
      maxAgeJobInfoHours: maxAgeJobInfoHours is int?
          ? maxAgeJobInfoHours
          : this.maxAgeJobInfoHours,
      maxAgeScoringHours: maxAgeScoringHours is int?
          ? maxAgeScoringHours
          : this.maxAgeScoringHours,
      maxAgeAiResponsesHours: maxAgeAiResponsesHours is int?
          ? maxAgeAiResponsesHours
          : this.maxAgeAiResponsesHours,
    );
  }
}
