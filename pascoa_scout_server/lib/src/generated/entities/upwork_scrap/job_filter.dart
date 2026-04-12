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
import '../../entities/upwork_scrap/experience_level.dart' as _i2;
import '../../entities/upwork_scrap/client_history.dart' as _i3;
import '../../entities/upwork_scrap/job_type.dart' as _i4;
import '../../entities/upwork_scrap/min_max.dart' as _i5;
import '../../entities/upwork_scrap/country.dart' as _i6;
import '../../entities/upwork_scrap/region.dart' as _i7;
import '../../entities/upwork_scrap/sub_region.dart' as _i8;
import '../../entities/upwork_scrap/maximum_job_age.dart' as _i9;
import '../../entities/upwork_scrap/custom_filter.dart' as _i10;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i11;

abstract class JobFilter
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  JobFilter._({
    required this.searchQueryTerm,
    this.rawUrl,
    this.experienceLevel,
    this.clientHistory,
    this.jobType,
    bool? paymentVerified,
    this.fixedPriceRange,
    this.hourlyRateRange,
    this.countries,
    this.regions,
    this.subRegions,
    this.jobAgeFilter,
    this.customFilters,
  }) : paymentVerified = paymentVerified ?? false;

  factory JobFilter({
    required String searchQueryTerm,
    String? rawUrl,
    List<_i2.ExperienceLevel>? experienceLevel,
    List<_i3.ClientHistory>? clientHistory,
    List<_i4.JobType>? jobType,
    bool? paymentVerified,
    _i5.MinMax? fixedPriceRange,
    _i5.MinMax? hourlyRateRange,
    List<_i6.Country>? countries,
    List<_i7.Region>? regions,
    List<_i8.SubRegion>? subRegions,
    _i9.MaximumJobAge? jobAgeFilter,
    List<_i10.CustomFilter>? customFilters,
  }) = _JobFilterImpl;

  factory JobFilter.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobFilter(
      searchQueryTerm: jsonSerialization['searchQueryTerm'] as String,
      rawUrl: jsonSerialization['rawUrl'] as String?,
      experienceLevel: jsonSerialization['experienceLevel'] == null
          ? null
          : _i11.Protocol().deserialize<List<_i2.ExperienceLevel>>(
              jsonSerialization['experienceLevel'],
            ),
      clientHistory: jsonSerialization['clientHistory'] == null
          ? null
          : _i11.Protocol().deserialize<List<_i3.ClientHistory>>(
              jsonSerialization['clientHistory'],
            ),
      jobType: jsonSerialization['jobType'] == null
          ? null
          : _i11.Protocol().deserialize<List<_i4.JobType>>(
              jsonSerialization['jobType'],
            ),
      paymentVerified: jsonSerialization['paymentVerified'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['paymentVerified'],
            ),
      fixedPriceRange: jsonSerialization['fixedPriceRange'] == null
          ? null
          : _i11.Protocol().deserialize<_i5.MinMax>(
              jsonSerialization['fixedPriceRange'],
            ),
      hourlyRateRange: jsonSerialization['hourlyRateRange'] == null
          ? null
          : _i11.Protocol().deserialize<_i5.MinMax>(
              jsonSerialization['hourlyRateRange'],
            ),
      countries: jsonSerialization['countries'] == null
          ? null
          : _i11.Protocol().deserialize<List<_i6.Country>>(
              jsonSerialization['countries'],
            ),
      regions: jsonSerialization['regions'] == null
          ? null
          : _i11.Protocol().deserialize<List<_i7.Region>>(
              jsonSerialization['regions'],
            ),
      subRegions: jsonSerialization['subRegions'] == null
          ? null
          : _i11.Protocol().deserialize<List<_i8.SubRegion>>(
              jsonSerialization['subRegions'],
            ),
      jobAgeFilter: jsonSerialization['jobAgeFilter'] == null
          ? null
          : _i11.Protocol().deserialize<_i9.MaximumJobAge>(
              jsonSerialization['jobAgeFilter'],
            ),
      customFilters: jsonSerialization['customFilters'] == null
          ? null
          : _i11.Protocol().deserialize<List<_i10.CustomFilter>>(
              jsonSerialization['customFilters'],
            ),
    );
  }

  String searchQueryTerm;

  String? rawUrl;

  List<_i2.ExperienceLevel>? experienceLevel;

  List<_i3.ClientHistory>? clientHistory;

  List<_i4.JobType>? jobType;

  bool paymentVerified;

  _i5.MinMax? fixedPriceRange;

  _i5.MinMax? hourlyRateRange;

  List<_i6.Country>? countries;

  List<_i7.Region>? regions;

  List<_i8.SubRegion>? subRegions;

  _i9.MaximumJobAge? jobAgeFilter;

  List<_i10.CustomFilter>? customFilters;

  /// Returns a shallow copy of this [JobFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobFilter copyWith({
    String? searchQueryTerm,
    String? rawUrl,
    List<_i2.ExperienceLevel>? experienceLevel,
    List<_i3.ClientHistory>? clientHistory,
    List<_i4.JobType>? jobType,
    bool? paymentVerified,
    _i5.MinMax? fixedPriceRange,
    _i5.MinMax? hourlyRateRange,
    List<_i6.Country>? countries,
    List<_i7.Region>? regions,
    List<_i8.SubRegion>? subRegions,
    _i9.MaximumJobAge? jobAgeFilter,
    List<_i10.CustomFilter>? customFilters,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobFilter',
      'searchQueryTerm': searchQueryTerm,
      if (rawUrl != null) 'rawUrl': rawUrl,
      if (experienceLevel != null)
        'experienceLevel': experienceLevel?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (clientHistory != null)
        'clientHistory': clientHistory?.toJson(valueToJson: (v) => v.toJson()),
      if (jobType != null)
        'jobType': jobType?.toJson(valueToJson: (v) => v.toJson()),
      'paymentVerified': paymentVerified,
      if (fixedPriceRange != null) 'fixedPriceRange': fixedPriceRange?.toJson(),
      if (hourlyRateRange != null) 'hourlyRateRange': hourlyRateRange?.toJson(),
      if (countries != null)
        'countries': countries?.toJson(valueToJson: (v) => v.toJson()),
      if (regions != null)
        'regions': regions?.toJson(valueToJson: (v) => v.toJson()),
      if (subRegions != null)
        'subRegions': subRegions?.toJson(valueToJson: (v) => v.toJson()),
      if (jobAgeFilter != null) 'jobAgeFilter': jobAgeFilter?.toJson(),
      if (customFilters != null)
        'customFilters': customFilters?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobFilter',
      'searchQueryTerm': searchQueryTerm,
      if (rawUrl != null) 'rawUrl': rawUrl,
      if (experienceLevel != null)
        'experienceLevel': experienceLevel?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (clientHistory != null)
        'clientHistory': clientHistory?.toJson(valueToJson: (v) => v.toJson()),
      if (jobType != null)
        'jobType': jobType?.toJson(valueToJson: (v) => v.toJson()),
      'paymentVerified': paymentVerified,
      if (fixedPriceRange != null)
        'fixedPriceRange': fixedPriceRange?.toJsonForProtocol(),
      if (hourlyRateRange != null)
        'hourlyRateRange': hourlyRateRange?.toJsonForProtocol(),
      if (countries != null)
        'countries': countries?.toJson(valueToJson: (v) => v.toJson()),
      if (regions != null)
        'regions': regions?.toJson(valueToJson: (v) => v.toJson()),
      if (subRegions != null)
        'subRegions': subRegions?.toJson(valueToJson: (v) => v.toJson()),
      if (jobAgeFilter != null)
        'jobAgeFilter': jobAgeFilter?.toJsonForProtocol(),
      if (customFilters != null)
        'customFilters': customFilters?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobFilterImpl extends JobFilter {
  _JobFilterImpl({
    required String searchQueryTerm,
    String? rawUrl,
    List<_i2.ExperienceLevel>? experienceLevel,
    List<_i3.ClientHistory>? clientHistory,
    List<_i4.JobType>? jobType,
    bool? paymentVerified,
    _i5.MinMax? fixedPriceRange,
    _i5.MinMax? hourlyRateRange,
    List<_i6.Country>? countries,
    List<_i7.Region>? regions,
    List<_i8.SubRegion>? subRegions,
    _i9.MaximumJobAge? jobAgeFilter,
    List<_i10.CustomFilter>? customFilters,
  }) : super._(
         searchQueryTerm: searchQueryTerm,
         rawUrl: rawUrl,
         experienceLevel: experienceLevel,
         clientHistory: clientHistory,
         jobType: jobType,
         paymentVerified: paymentVerified,
         fixedPriceRange: fixedPriceRange,
         hourlyRateRange: hourlyRateRange,
         countries: countries,
         regions: regions,
         subRegions: subRegions,
         jobAgeFilter: jobAgeFilter,
         customFilters: customFilters,
       );

  /// Returns a shallow copy of this [JobFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobFilter copyWith({
    String? searchQueryTerm,
    Object? rawUrl = _Undefined,
    Object? experienceLevel = _Undefined,
    Object? clientHistory = _Undefined,
    Object? jobType = _Undefined,
    bool? paymentVerified,
    Object? fixedPriceRange = _Undefined,
    Object? hourlyRateRange = _Undefined,
    Object? countries = _Undefined,
    Object? regions = _Undefined,
    Object? subRegions = _Undefined,
    Object? jobAgeFilter = _Undefined,
    Object? customFilters = _Undefined,
  }) {
    return JobFilter(
      searchQueryTerm: searchQueryTerm ?? this.searchQueryTerm,
      rawUrl: rawUrl is String? ? rawUrl : this.rawUrl,
      experienceLevel: experienceLevel is List<_i2.ExperienceLevel>?
          ? experienceLevel
          : this.experienceLevel?.map((e0) => e0).toList(),
      clientHistory: clientHistory is List<_i3.ClientHistory>?
          ? clientHistory
          : this.clientHistory?.map((e0) => e0).toList(),
      jobType: jobType is List<_i4.JobType>?
          ? jobType
          : this.jobType?.map((e0) => e0).toList(),
      paymentVerified: paymentVerified ?? this.paymentVerified,
      fixedPriceRange: fixedPriceRange is _i5.MinMax?
          ? fixedPriceRange
          : this.fixedPriceRange?.copyWith(),
      hourlyRateRange: hourlyRateRange is _i5.MinMax?
          ? hourlyRateRange
          : this.hourlyRateRange?.copyWith(),
      countries: countries is List<_i6.Country>?
          ? countries
          : this.countries?.map((e0) => e0).toList(),
      regions: regions is List<_i7.Region>?
          ? regions
          : this.regions?.map((e0) => e0).toList(),
      subRegions: subRegions is List<_i8.SubRegion>?
          ? subRegions
          : this.subRegions?.map((e0) => e0).toList(),
      jobAgeFilter: jobAgeFilter is _i9.MaximumJobAge?
          ? jobAgeFilter
          : this.jobAgeFilter?.copyWith(),
      customFilters: customFilters is List<_i10.CustomFilter>?
          ? customFilters
          : this.customFilters?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
