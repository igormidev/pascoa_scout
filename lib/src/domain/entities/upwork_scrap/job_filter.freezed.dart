// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobFilter {

 String get searchQueryTerm; List<ExperienceLevel>? get experienceLevel; List<ClientHistory>? get clientHistory; List<JobType>? get jobType; bool get paymentVerified; MinMax? get fixedPriceRange; MinMax? get hourlyRateRange; List<Country>? get countries; List<Region>? get regions; List<SubRegion>? get subRegions; MaximumJobAge? get jobAgeFilter; Pagination? get pagination; List<CustomFilter>? get customFilters;
/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobFilterCopyWith<JobFilter> get copyWith => _$JobFilterCopyWithImpl<JobFilter>(this as JobFilter, _$identity);

  /// Serializes this JobFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobFilter&&(identical(other.searchQueryTerm, searchQueryTerm) || other.searchQueryTerm == searchQueryTerm)&&const DeepCollectionEquality().equals(other.experienceLevel, experienceLevel)&&const DeepCollectionEquality().equals(other.clientHistory, clientHistory)&&const DeepCollectionEquality().equals(other.jobType, jobType)&&(identical(other.paymentVerified, paymentVerified) || other.paymentVerified == paymentVerified)&&(identical(other.fixedPriceRange, fixedPriceRange) || other.fixedPriceRange == fixedPriceRange)&&(identical(other.hourlyRateRange, hourlyRateRange) || other.hourlyRateRange == hourlyRateRange)&&const DeepCollectionEquality().equals(other.countries, countries)&&const DeepCollectionEquality().equals(other.regions, regions)&&const DeepCollectionEquality().equals(other.subRegions, subRegions)&&(identical(other.jobAgeFilter, jobAgeFilter) || other.jobAgeFilter == jobAgeFilter)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&const DeepCollectionEquality().equals(other.customFilters, customFilters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchQueryTerm,const DeepCollectionEquality().hash(experienceLevel),const DeepCollectionEquality().hash(clientHistory),const DeepCollectionEquality().hash(jobType),paymentVerified,fixedPriceRange,hourlyRateRange,const DeepCollectionEquality().hash(countries),const DeepCollectionEquality().hash(regions),const DeepCollectionEquality().hash(subRegions),jobAgeFilter,pagination,const DeepCollectionEquality().hash(customFilters));

@override
String toString() {
  return 'JobFilter(searchQueryTerm: $searchQueryTerm, experienceLevel: $experienceLevel, clientHistory: $clientHistory, jobType: $jobType, paymentVerified: $paymentVerified, fixedPriceRange: $fixedPriceRange, hourlyRateRange: $hourlyRateRange, countries: $countries, regions: $regions, subRegions: $subRegions, jobAgeFilter: $jobAgeFilter, pagination: $pagination, customFilters: $customFilters)';
}


}

/// @nodoc
abstract mixin class $JobFilterCopyWith<$Res>  {
  factory $JobFilterCopyWith(JobFilter value, $Res Function(JobFilter) _then) = _$JobFilterCopyWithImpl;
@useResult
$Res call({
 String searchQueryTerm, List<ExperienceLevel>? experienceLevel, List<ClientHistory>? clientHistory, List<JobType>? jobType, bool paymentVerified, MinMax? fixedPriceRange, MinMax? hourlyRateRange, List<Country>? countries, List<Region>? regions, List<SubRegion>? subRegions, MaximumJobAge? jobAgeFilter, Pagination? pagination, List<CustomFilter>? customFilters
});


$MinMaxCopyWith<$Res>? get fixedPriceRange;$MinMaxCopyWith<$Res>? get hourlyRateRange;$MaximumJobAgeCopyWith<$Res>? get jobAgeFilter;$PaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$JobFilterCopyWithImpl<$Res>
    implements $JobFilterCopyWith<$Res> {
  _$JobFilterCopyWithImpl(this._self, this._then);

  final JobFilter _self;
  final $Res Function(JobFilter) _then;

/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQueryTerm = null,Object? experienceLevel = freezed,Object? clientHistory = freezed,Object? jobType = freezed,Object? paymentVerified = null,Object? fixedPriceRange = freezed,Object? hourlyRateRange = freezed,Object? countries = freezed,Object? regions = freezed,Object? subRegions = freezed,Object? jobAgeFilter = freezed,Object? pagination = freezed,Object? customFilters = freezed,}) {
  return _then(_self.copyWith(
searchQueryTerm: null == searchQueryTerm ? _self.searchQueryTerm : searchQueryTerm // ignore: cast_nullable_to_non_nullable
as String,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as List<ExperienceLevel>?,clientHistory: freezed == clientHistory ? _self.clientHistory : clientHistory // ignore: cast_nullable_to_non_nullable
as List<ClientHistory>?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as List<JobType>?,paymentVerified: null == paymentVerified ? _self.paymentVerified : paymentVerified // ignore: cast_nullable_to_non_nullable
as bool,fixedPriceRange: freezed == fixedPriceRange ? _self.fixedPriceRange : fixedPriceRange // ignore: cast_nullable_to_non_nullable
as MinMax?,hourlyRateRange: freezed == hourlyRateRange ? _self.hourlyRateRange : hourlyRateRange // ignore: cast_nullable_to_non_nullable
as MinMax?,countries: freezed == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>?,regions: freezed == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>?,subRegions: freezed == subRegions ? _self.subRegions : subRegions // ignore: cast_nullable_to_non_nullable
as List<SubRegion>?,jobAgeFilter: freezed == jobAgeFilter ? _self.jobAgeFilter : jobAgeFilter // ignore: cast_nullable_to_non_nullable
as MaximumJobAge?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Pagination?,customFilters: freezed == customFilters ? _self.customFilters : customFilters // ignore: cast_nullable_to_non_nullable
as List<CustomFilter>?,
  ));
}
/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MinMaxCopyWith<$Res>? get fixedPriceRange {
    if (_self.fixedPriceRange == null) {
    return null;
  }

  return $MinMaxCopyWith<$Res>(_self.fixedPriceRange!, (value) {
    return _then(_self.copyWith(fixedPriceRange: value));
  });
}/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MinMaxCopyWith<$Res>? get hourlyRateRange {
    if (_self.hourlyRateRange == null) {
    return null;
  }

  return $MinMaxCopyWith<$Res>(_self.hourlyRateRange!, (value) {
    return _then(_self.copyWith(hourlyRateRange: value));
  });
}/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MaximumJobAgeCopyWith<$Res>? get jobAgeFilter {
    if (_self.jobAgeFilter == null) {
    return null;
  }

  return $MaximumJobAgeCopyWith<$Res>(_self.jobAgeFilter!, (value) {
    return _then(_self.copyWith(jobAgeFilter: value));
  });
}/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $PaginationCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// Adds pattern-matching-related methods to [JobFilter].
extension JobFilterPatterns on JobFilter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobFilter() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobFilter value)  $default,){
final _that = this;
switch (_that) {
case _JobFilter():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobFilter value)?  $default,){
final _that = this;
switch (_that) {
case _JobFilter() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchQueryTerm,  List<ExperienceLevel>? experienceLevel,  List<ClientHistory>? clientHistory,  List<JobType>? jobType,  bool paymentVerified,  MinMax? fixedPriceRange,  MinMax? hourlyRateRange,  List<Country>? countries,  List<Region>? regions,  List<SubRegion>? subRegions,  MaximumJobAge? jobAgeFilter,  Pagination? pagination,  List<CustomFilter>? customFilters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobFilter() when $default != null:
return $default(_that.searchQueryTerm,_that.experienceLevel,_that.clientHistory,_that.jobType,_that.paymentVerified,_that.fixedPriceRange,_that.hourlyRateRange,_that.countries,_that.regions,_that.subRegions,_that.jobAgeFilter,_that.pagination,_that.customFilters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchQueryTerm,  List<ExperienceLevel>? experienceLevel,  List<ClientHistory>? clientHistory,  List<JobType>? jobType,  bool paymentVerified,  MinMax? fixedPriceRange,  MinMax? hourlyRateRange,  List<Country>? countries,  List<Region>? regions,  List<SubRegion>? subRegions,  MaximumJobAge? jobAgeFilter,  Pagination? pagination,  List<CustomFilter>? customFilters)  $default,) {final _that = this;
switch (_that) {
case _JobFilter():
return $default(_that.searchQueryTerm,_that.experienceLevel,_that.clientHistory,_that.jobType,_that.paymentVerified,_that.fixedPriceRange,_that.hourlyRateRange,_that.countries,_that.regions,_that.subRegions,_that.jobAgeFilter,_that.pagination,_that.customFilters);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchQueryTerm,  List<ExperienceLevel>? experienceLevel,  List<ClientHistory>? clientHistory,  List<JobType>? jobType,  bool paymentVerified,  MinMax? fixedPriceRange,  MinMax? hourlyRateRange,  List<Country>? countries,  List<Region>? regions,  List<SubRegion>? subRegions,  MaximumJobAge? jobAgeFilter,  Pagination? pagination,  List<CustomFilter>? customFilters)?  $default,) {final _that = this;
switch (_that) {
case _JobFilter() when $default != null:
return $default(_that.searchQueryTerm,_that.experienceLevel,_that.clientHistory,_that.jobType,_that.paymentVerified,_that.fixedPriceRange,_that.hourlyRateRange,_that.countries,_that.regions,_that.subRegions,_that.jobAgeFilter,_that.pagination,_that.customFilters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobFilter implements JobFilter {
   _JobFilter({required this.searchQueryTerm, final  List<ExperienceLevel>? experienceLevel, final  List<ClientHistory>? clientHistory, final  List<JobType>? jobType, this.paymentVerified = false, this.fixedPriceRange, this.hourlyRateRange, final  List<Country>? countries, final  List<Region>? regions, final  List<SubRegion>? subRegions, this.jobAgeFilter, this.pagination, final  List<CustomFilter>? customFilters}): _experienceLevel = experienceLevel,_clientHistory = clientHistory,_jobType = jobType,_countries = countries,_regions = regions,_subRegions = subRegions,_customFilters = customFilters;
  factory _JobFilter.fromJson(Map<String, dynamic> json) => _$JobFilterFromJson(json);

@override final  String searchQueryTerm;
 final  List<ExperienceLevel>? _experienceLevel;
@override List<ExperienceLevel>? get experienceLevel {
  final value = _experienceLevel;
  if (value == null) return null;
  if (_experienceLevel is EqualUnmodifiableListView) return _experienceLevel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ClientHistory>? _clientHistory;
@override List<ClientHistory>? get clientHistory {
  final value = _clientHistory;
  if (value == null) return null;
  if (_clientHistory is EqualUnmodifiableListView) return _clientHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<JobType>? _jobType;
@override List<JobType>? get jobType {
  final value = _jobType;
  if (value == null) return null;
  if (_jobType is EqualUnmodifiableListView) return _jobType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool paymentVerified;
@override final  MinMax? fixedPriceRange;
@override final  MinMax? hourlyRateRange;
 final  List<Country>? _countries;
@override List<Country>? get countries {
  final value = _countries;
  if (value == null) return null;
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Region>? _regions;
@override List<Region>? get regions {
  final value = _regions;
  if (value == null) return null;
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<SubRegion>? _subRegions;
@override List<SubRegion>? get subRegions {
  final value = _subRegions;
  if (value == null) return null;
  if (_subRegions is EqualUnmodifiableListView) return _subRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  MaximumJobAge? jobAgeFilter;
@override final  Pagination? pagination;
 final  List<CustomFilter>? _customFilters;
@override List<CustomFilter>? get customFilters {
  final value = _customFilters;
  if (value == null) return null;
  if (_customFilters is EqualUnmodifiableListView) return _customFilters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobFilterCopyWith<_JobFilter> get copyWith => __$JobFilterCopyWithImpl<_JobFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobFilter&&(identical(other.searchQueryTerm, searchQueryTerm) || other.searchQueryTerm == searchQueryTerm)&&const DeepCollectionEquality().equals(other._experienceLevel, _experienceLevel)&&const DeepCollectionEquality().equals(other._clientHistory, _clientHistory)&&const DeepCollectionEquality().equals(other._jobType, _jobType)&&(identical(other.paymentVerified, paymentVerified) || other.paymentVerified == paymentVerified)&&(identical(other.fixedPriceRange, fixedPriceRange) || other.fixedPriceRange == fixedPriceRange)&&(identical(other.hourlyRateRange, hourlyRateRange) || other.hourlyRateRange == hourlyRateRange)&&const DeepCollectionEquality().equals(other._countries, _countries)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._subRegions, _subRegions)&&(identical(other.jobAgeFilter, jobAgeFilter) || other.jobAgeFilter == jobAgeFilter)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&const DeepCollectionEquality().equals(other._customFilters, _customFilters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchQueryTerm,const DeepCollectionEquality().hash(_experienceLevel),const DeepCollectionEquality().hash(_clientHistory),const DeepCollectionEquality().hash(_jobType),paymentVerified,fixedPriceRange,hourlyRateRange,const DeepCollectionEquality().hash(_countries),const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_subRegions),jobAgeFilter,pagination,const DeepCollectionEquality().hash(_customFilters));

@override
String toString() {
  return 'JobFilter(searchQueryTerm: $searchQueryTerm, experienceLevel: $experienceLevel, clientHistory: $clientHistory, jobType: $jobType, paymentVerified: $paymentVerified, fixedPriceRange: $fixedPriceRange, hourlyRateRange: $hourlyRateRange, countries: $countries, regions: $regions, subRegions: $subRegions, jobAgeFilter: $jobAgeFilter, pagination: $pagination, customFilters: $customFilters)';
}


}

/// @nodoc
abstract mixin class _$JobFilterCopyWith<$Res> implements $JobFilterCopyWith<$Res> {
  factory _$JobFilterCopyWith(_JobFilter value, $Res Function(_JobFilter) _then) = __$JobFilterCopyWithImpl;
@override @useResult
$Res call({
 String searchQueryTerm, List<ExperienceLevel>? experienceLevel, List<ClientHistory>? clientHistory, List<JobType>? jobType, bool paymentVerified, MinMax? fixedPriceRange, MinMax? hourlyRateRange, List<Country>? countries, List<Region>? regions, List<SubRegion>? subRegions, MaximumJobAge? jobAgeFilter, Pagination? pagination, List<CustomFilter>? customFilters
});


@override $MinMaxCopyWith<$Res>? get fixedPriceRange;@override $MinMaxCopyWith<$Res>? get hourlyRateRange;@override $MaximumJobAgeCopyWith<$Res>? get jobAgeFilter;@override $PaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$JobFilterCopyWithImpl<$Res>
    implements _$JobFilterCopyWith<$Res> {
  __$JobFilterCopyWithImpl(this._self, this._then);

  final _JobFilter _self;
  final $Res Function(_JobFilter) _then;

/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQueryTerm = null,Object? experienceLevel = freezed,Object? clientHistory = freezed,Object? jobType = freezed,Object? paymentVerified = null,Object? fixedPriceRange = freezed,Object? hourlyRateRange = freezed,Object? countries = freezed,Object? regions = freezed,Object? subRegions = freezed,Object? jobAgeFilter = freezed,Object? pagination = freezed,Object? customFilters = freezed,}) {
  return _then(_JobFilter(
searchQueryTerm: null == searchQueryTerm ? _self.searchQueryTerm : searchQueryTerm // ignore: cast_nullable_to_non_nullable
as String,experienceLevel: freezed == experienceLevel ? _self._experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as List<ExperienceLevel>?,clientHistory: freezed == clientHistory ? _self._clientHistory : clientHistory // ignore: cast_nullable_to_non_nullable
as List<ClientHistory>?,jobType: freezed == jobType ? _self._jobType : jobType // ignore: cast_nullable_to_non_nullable
as List<JobType>?,paymentVerified: null == paymentVerified ? _self.paymentVerified : paymentVerified // ignore: cast_nullable_to_non_nullable
as bool,fixedPriceRange: freezed == fixedPriceRange ? _self.fixedPriceRange : fixedPriceRange // ignore: cast_nullable_to_non_nullable
as MinMax?,hourlyRateRange: freezed == hourlyRateRange ? _self.hourlyRateRange : hourlyRateRange // ignore: cast_nullable_to_non_nullable
as MinMax?,countries: freezed == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>?,regions: freezed == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>?,subRegions: freezed == subRegions ? _self._subRegions : subRegions // ignore: cast_nullable_to_non_nullable
as List<SubRegion>?,jobAgeFilter: freezed == jobAgeFilter ? _self.jobAgeFilter : jobAgeFilter // ignore: cast_nullable_to_non_nullable
as MaximumJobAge?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Pagination?,customFilters: freezed == customFilters ? _self._customFilters : customFilters // ignore: cast_nullable_to_non_nullable
as List<CustomFilter>?,
  ));
}

/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MinMaxCopyWith<$Res>? get fixedPriceRange {
    if (_self.fixedPriceRange == null) {
    return null;
  }

  return $MinMaxCopyWith<$Res>(_self.fixedPriceRange!, (value) {
    return _then(_self.copyWith(fixedPriceRange: value));
  });
}/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MinMaxCopyWith<$Res>? get hourlyRateRange {
    if (_self.hourlyRateRange == null) {
    return null;
  }

  return $MinMaxCopyWith<$Res>(_self.hourlyRateRange!, (value) {
    return _then(_self.copyWith(hourlyRateRange: value));
  });
}/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MaximumJobAgeCopyWith<$Res>? get jobAgeFilter {
    if (_self.jobAgeFilter == null) {
    return null;
  }

  return $MaximumJobAgeCopyWith<$Res>(_self.jobAgeFilter!, (value) {
    return _then(_self.copyWith(jobAgeFilter: value));
  });
}/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $PaginationCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// @nodoc
mixin _$MinMax {

 int get min; int get max;
/// Create a copy of MinMax
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MinMaxCopyWith<MinMax> get copyWith => _$MinMaxCopyWithImpl<MinMax>(this as MinMax, _$identity);

  /// Serializes this MinMax to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MinMax&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,min,max);

@override
String toString() {
  return 'MinMax(min: $min, max: $max)';
}


}

/// @nodoc
abstract mixin class $MinMaxCopyWith<$Res>  {
  factory $MinMaxCopyWith(MinMax value, $Res Function(MinMax) _then) = _$MinMaxCopyWithImpl;
@useResult
$Res call({
 int min, int max
});




}
/// @nodoc
class _$MinMaxCopyWithImpl<$Res>
    implements $MinMaxCopyWith<$Res> {
  _$MinMaxCopyWithImpl(this._self, this._then);

  final MinMax _self;
  final $Res Function(MinMax) _then;

/// Create a copy of MinMax
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? min = null,Object? max = null,}) {
  return _then(_self.copyWith(
min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as int,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MinMax].
extension MinMaxPatterns on MinMax {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MinMax value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MinMax() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MinMax value)  $default,){
final _that = this;
switch (_that) {
case _MinMax():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MinMax value)?  $default,){
final _that = this;
switch (_that) {
case _MinMax() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int min,  int max)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MinMax() when $default != null:
return $default(_that.min,_that.max);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int min,  int max)  $default,) {final _that = this;
switch (_that) {
case _MinMax():
return $default(_that.min,_that.max);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int min,  int max)?  $default,) {final _that = this;
switch (_that) {
case _MinMax() when $default != null:
return $default(_that.min,_that.max);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MinMax implements MinMax {
   _MinMax({required this.min, required this.max});
  factory _MinMax.fromJson(Map<String, dynamic> json) => _$MinMaxFromJson(json);

@override final  int min;
@override final  int max;

/// Create a copy of MinMax
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MinMaxCopyWith<_MinMax> get copyWith => __$MinMaxCopyWithImpl<_MinMax>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MinMaxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MinMax&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,min,max);

@override
String toString() {
  return 'MinMax(min: $min, max: $max)';
}


}

/// @nodoc
abstract mixin class _$MinMaxCopyWith<$Res> implements $MinMaxCopyWith<$Res> {
  factory _$MinMaxCopyWith(_MinMax value, $Res Function(_MinMax) _then) = __$MinMaxCopyWithImpl;
@override @useResult
$Res call({
 int min, int max
});




}
/// @nodoc
class __$MinMaxCopyWithImpl<$Res>
    implements _$MinMaxCopyWith<$Res> {
  __$MinMaxCopyWithImpl(this._self, this._then);

  final _MinMax _self;
  final $Res Function(_MinMax) _then;

/// Create a copy of MinMax
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? min = null,Object? max = null,}) {
  return _then(_MinMax(
min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as int,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MaximumJobAge {

 JobAgeUnit get unit; int get value;
/// Create a copy of MaximumJobAge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaximumJobAgeCopyWith<MaximumJobAge> get copyWith => _$MaximumJobAgeCopyWithImpl<MaximumJobAge>(this as MaximumJobAge, _$identity);

  /// Serializes this MaximumJobAge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaximumJobAge&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unit,value);

@override
String toString() {
  return 'MaximumJobAge(unit: $unit, value: $value)';
}


}

/// @nodoc
abstract mixin class $MaximumJobAgeCopyWith<$Res>  {
  factory $MaximumJobAgeCopyWith(MaximumJobAge value, $Res Function(MaximumJobAge) _then) = _$MaximumJobAgeCopyWithImpl;
@useResult
$Res call({
 JobAgeUnit unit, int value
});




}
/// @nodoc
class _$MaximumJobAgeCopyWithImpl<$Res>
    implements $MaximumJobAgeCopyWith<$Res> {
  _$MaximumJobAgeCopyWithImpl(this._self, this._then);

  final MaximumJobAge _self;
  final $Res Function(MaximumJobAge) _then;

/// Create a copy of MaximumJobAge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unit = null,Object? value = null,}) {
  return _then(_self.copyWith(
unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as JobAgeUnit,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MaximumJobAge].
extension MaximumJobAgePatterns on MaximumJobAge {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaximumJobAge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaximumJobAge() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaximumJobAge value)  $default,){
final _that = this;
switch (_that) {
case _MaximumJobAge():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaximumJobAge value)?  $default,){
final _that = this;
switch (_that) {
case _MaximumJobAge() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JobAgeUnit unit,  int value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaximumJobAge() when $default != null:
return $default(_that.unit,_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JobAgeUnit unit,  int value)  $default,) {final _that = this;
switch (_that) {
case _MaximumJobAge():
return $default(_that.unit,_that.value);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JobAgeUnit unit,  int value)?  $default,) {final _that = this;
switch (_that) {
case _MaximumJobAge() when $default != null:
return $default(_that.unit,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaximumJobAge implements MaximumJobAge {
   _MaximumJobAge({required this.unit, required this.value});
  factory _MaximumJobAge.fromJson(Map<String, dynamic> json) => _$MaximumJobAgeFromJson(json);

@override final  JobAgeUnit unit;
@override final  int value;

/// Create a copy of MaximumJobAge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaximumJobAgeCopyWith<_MaximumJobAge> get copyWith => __$MaximumJobAgeCopyWithImpl<_MaximumJobAge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaximumJobAgeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaximumJobAge&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unit,value);

@override
String toString() {
  return 'MaximumJobAge(unit: $unit, value: $value)';
}


}

/// @nodoc
abstract mixin class _$MaximumJobAgeCopyWith<$Res> implements $MaximumJobAgeCopyWith<$Res> {
  factory _$MaximumJobAgeCopyWith(_MaximumJobAge value, $Res Function(_MaximumJobAge) _then) = __$MaximumJobAgeCopyWithImpl;
@override @useResult
$Res call({
 JobAgeUnit unit, int value
});




}
/// @nodoc
class __$MaximumJobAgeCopyWithImpl<$Res>
    implements _$MaximumJobAgeCopyWith<$Res> {
  __$MaximumJobAgeCopyWithImpl(this._self, this._then);

  final _MaximumJobAge _self;
  final $Res Function(_MaximumJobAge) _then;

/// Create a copy of MaximumJobAge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unit = null,Object? value = null,}) {
  return _then(_MaximumJobAge(
unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as JobAgeUnit,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Pagination {

/// Page number to start scraping from
 int get pageNumber;/// Number of pages to scrape sequentially starting from the specified page
 int get pagesToScrape;/// Number of results to display per page
 int get resultsPerPage;/// How to sort the job listings
 SearchSortOrder get searchSortOrder;
/// Create a copy of Pagination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationCopyWith<Pagination> get copyWith => _$PaginationCopyWithImpl<Pagination>(this as Pagination, _$identity);

  /// Serializes this Pagination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pagination&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pagesToScrape, pagesToScrape) || other.pagesToScrape == pagesToScrape)&&(identical(other.resultsPerPage, resultsPerPage) || other.resultsPerPage == resultsPerPage)&&(identical(other.searchSortOrder, searchSortOrder) || other.searchSortOrder == searchSortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageNumber,pagesToScrape,resultsPerPage,searchSortOrder);

@override
String toString() {
  return 'Pagination(pageNumber: $pageNumber, pagesToScrape: $pagesToScrape, resultsPerPage: $resultsPerPage, searchSortOrder: $searchSortOrder)';
}


}

/// @nodoc
abstract mixin class $PaginationCopyWith<$Res>  {
  factory $PaginationCopyWith(Pagination value, $Res Function(Pagination) _then) = _$PaginationCopyWithImpl;
@useResult
$Res call({
 int pageNumber, int pagesToScrape, int resultsPerPage, SearchSortOrder searchSortOrder
});




}
/// @nodoc
class _$PaginationCopyWithImpl<$Res>
    implements $PaginationCopyWith<$Res> {
  _$PaginationCopyWithImpl(this._self, this._then);

  final Pagination _self;
  final $Res Function(Pagination) _then;

/// Create a copy of Pagination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageNumber = null,Object? pagesToScrape = null,Object? resultsPerPage = null,Object? searchSortOrder = null,}) {
  return _then(_self.copyWith(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pagesToScrape: null == pagesToScrape ? _self.pagesToScrape : pagesToScrape // ignore: cast_nullable_to_non_nullable
as int,resultsPerPage: null == resultsPerPage ? _self.resultsPerPage : resultsPerPage // ignore: cast_nullable_to_non_nullable
as int,searchSortOrder: null == searchSortOrder ? _self.searchSortOrder : searchSortOrder // ignore: cast_nullable_to_non_nullable
as SearchSortOrder,
  ));
}

}


/// Adds pattern-matching-related methods to [Pagination].
extension PaginationPatterns on Pagination {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pagination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pagination() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pagination value)  $default,){
final _that = this;
switch (_that) {
case _Pagination():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pagination value)?  $default,){
final _that = this;
switch (_that) {
case _Pagination() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pageNumber,  int pagesToScrape,  int resultsPerPage,  SearchSortOrder searchSortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pagination() when $default != null:
return $default(_that.pageNumber,_that.pagesToScrape,_that.resultsPerPage,_that.searchSortOrder);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pageNumber,  int pagesToScrape,  int resultsPerPage,  SearchSortOrder searchSortOrder)  $default,) {final _that = this;
switch (_that) {
case _Pagination():
return $default(_that.pageNumber,_that.pagesToScrape,_that.resultsPerPage,_that.searchSortOrder);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pageNumber,  int pagesToScrape,  int resultsPerPage,  SearchSortOrder searchSortOrder)?  $default,) {final _that = this;
switch (_that) {
case _Pagination() when $default != null:
return $default(_that.pageNumber,_that.pagesToScrape,_that.resultsPerPage,_that.searchSortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Pagination implements Pagination {
   _Pagination({required this.pageNumber, required this.pagesToScrape, required this.resultsPerPage, required this.searchSortOrder});
  factory _Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

/// Page number to start scraping from
@override final  int pageNumber;
/// Number of pages to scrape sequentially starting from the specified page
@override final  int pagesToScrape;
/// Number of results to display per page
@override final  int resultsPerPage;
/// How to sort the job listings
@override final  SearchSortOrder searchSortOrder;

/// Create a copy of Pagination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationCopyWith<_Pagination> get copyWith => __$PaginationCopyWithImpl<_Pagination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pagination&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pagesToScrape, pagesToScrape) || other.pagesToScrape == pagesToScrape)&&(identical(other.resultsPerPage, resultsPerPage) || other.resultsPerPage == resultsPerPage)&&(identical(other.searchSortOrder, searchSortOrder) || other.searchSortOrder == searchSortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageNumber,pagesToScrape,resultsPerPage,searchSortOrder);

@override
String toString() {
  return 'Pagination(pageNumber: $pageNumber, pagesToScrape: $pagesToScrape, resultsPerPage: $resultsPerPage, searchSortOrder: $searchSortOrder)';
}


}

/// @nodoc
abstract mixin class _$PaginationCopyWith<$Res> implements $PaginationCopyWith<$Res> {
  factory _$PaginationCopyWith(_Pagination value, $Res Function(_Pagination) _then) = __$PaginationCopyWithImpl;
@override @useResult
$Res call({
 int pageNumber, int pagesToScrape, int resultsPerPage, SearchSortOrder searchSortOrder
});




}
/// @nodoc
class __$PaginationCopyWithImpl<$Res>
    implements _$PaginationCopyWith<$Res> {
  __$PaginationCopyWithImpl(this._self, this._then);

  final _Pagination _self;
  final $Res Function(_Pagination) _then;

/// Create a copy of Pagination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageNumber = null,Object? pagesToScrape = null,Object? resultsPerPage = null,Object? searchSortOrder = null,}) {
  return _then(_Pagination(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pagesToScrape: null == pagesToScrape ? _self.pagesToScrape : pagesToScrape // ignore: cast_nullable_to_non_nullable
as int,resultsPerPage: null == resultsPerPage ? _self.resultsPerPage : resultsPerPage // ignore: cast_nullable_to_non_nullable
as int,searchSortOrder: null == searchSortOrder ? _self.searchSortOrder : searchSortOrder // ignore: cast_nullable_to_non_nullable
as SearchSortOrder,
  ));
}


}


/// @nodoc
mixin _$CustomFilter {

 AvailableProperties get properties; AvailableOperators get operators; List<String> get values;
/// Create a copy of CustomFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomFilterCopyWith<CustomFilter> get copyWith => _$CustomFilterCopyWithImpl<CustomFilter>(this as CustomFilter, _$identity);

  /// Serializes this CustomFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomFilter&&(identical(other.properties, properties) || other.properties == properties)&&(identical(other.operators, operators) || other.operators == operators)&&const DeepCollectionEquality().equals(other.values, values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,properties,operators,const DeepCollectionEquality().hash(values));

@override
String toString() {
  return 'CustomFilter(properties: $properties, operators: $operators, values: $values)';
}


}

/// @nodoc
abstract mixin class $CustomFilterCopyWith<$Res>  {
  factory $CustomFilterCopyWith(CustomFilter value, $Res Function(CustomFilter) _then) = _$CustomFilterCopyWithImpl;
@useResult
$Res call({
 AvailableProperties properties, AvailableOperators operators, List<String> values
});




}
/// @nodoc
class _$CustomFilterCopyWithImpl<$Res>
    implements $CustomFilterCopyWith<$Res> {
  _$CustomFilterCopyWithImpl(this._self, this._then);

  final CustomFilter _self;
  final $Res Function(CustomFilter) _then;

/// Create a copy of CustomFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? properties = null,Object? operators = null,Object? values = null,}) {
  return _then(_self.copyWith(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as AvailableProperties,operators: null == operators ? _self.operators : operators // ignore: cast_nullable_to_non_nullable
as AvailableOperators,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomFilter].
extension CustomFilterPatterns on CustomFilter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomFilter() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomFilter value)  $default,){
final _that = this;
switch (_that) {
case _CustomFilter():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomFilter value)?  $default,){
final _that = this;
switch (_that) {
case _CustomFilter() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AvailableProperties properties,  AvailableOperators operators,  List<String> values)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomFilter() when $default != null:
return $default(_that.properties,_that.operators,_that.values);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AvailableProperties properties,  AvailableOperators operators,  List<String> values)  $default,) {final _that = this;
switch (_that) {
case _CustomFilter():
return $default(_that.properties,_that.operators,_that.values);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AvailableProperties properties,  AvailableOperators operators,  List<String> values)?  $default,) {final _that = this;
switch (_that) {
case _CustomFilter() when $default != null:
return $default(_that.properties,_that.operators,_that.values);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomFilter implements CustomFilter {
   _CustomFilter({required this.properties, required this.operators, required final  List<String> values}): _values = values;
  factory _CustomFilter.fromJson(Map<String, dynamic> json) => _$CustomFilterFromJson(json);

@override final  AvailableProperties properties;
@override final  AvailableOperators operators;
 final  List<String> _values;
@override List<String> get values {
  if (_values is EqualUnmodifiableListView) return _values;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_values);
}


/// Create a copy of CustomFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomFilterCopyWith<_CustomFilter> get copyWith => __$CustomFilterCopyWithImpl<_CustomFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomFilter&&(identical(other.properties, properties) || other.properties == properties)&&(identical(other.operators, operators) || other.operators == operators)&&const DeepCollectionEquality().equals(other._values, _values));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,properties,operators,const DeepCollectionEquality().hash(_values));

@override
String toString() {
  return 'CustomFilter(properties: $properties, operators: $operators, values: $values)';
}


}

/// @nodoc
abstract mixin class _$CustomFilterCopyWith<$Res> implements $CustomFilterCopyWith<$Res> {
  factory _$CustomFilterCopyWith(_CustomFilter value, $Res Function(_CustomFilter) _then) = __$CustomFilterCopyWithImpl;
@override @useResult
$Res call({
 AvailableProperties properties, AvailableOperators operators, List<String> values
});




}
/// @nodoc
class __$CustomFilterCopyWithImpl<$Res>
    implements _$CustomFilterCopyWith<$Res> {
  __$CustomFilterCopyWithImpl(this._self, this._then);

  final _CustomFilter _self;
  final $Res Function(_CustomFilter) _then;

/// Create a copy of CustomFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? properties = null,Object? operators = null,Object? values = null,}) {
  return _then(_CustomFilter(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as AvailableProperties,operators: null == operators ? _self.operators : operators // ignore: cast_nullable_to_non_nullable
as AvailableOperators,values: null == values ? _self._values : values // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
