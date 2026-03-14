// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobInfo {

 String get id; String? get subId; String get title; String get description; String get url; String? get relativeDate; String? get absoluteDate; double? get budget; JobType get jobType; ExperienceLevel get experienceLevel; ClientLocation? get clientLocation; PaymentVerifiedStatus get paymentVerifiedStatus; List<ClientLocation> get allowedApplicantCountries; String? get clientName; double? get clientNameConfidencePercent;// Goes from 0@ to 100%
 double? get clientAvgHourlyRate;// USD
 double? get clientRating;// Goes from 0 to 5 stars
 double? get clientHireRatePercent;// Goes from 0% to 100%
 double? get clientTotalSpent; List<String> get tags; bool get hasHired;// Whether the client has hired anyone for this specific job
 List<Question> get questions;
/// Create a copy of JobInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobInfoCopyWith<JobInfo> get copyWith => _$JobInfoCopyWithImpl<JobInfo>(this as JobInfo, _$identity);

  /// Serializes this JobInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.subId, subId) || other.subId == subId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.relativeDate, relativeDate) || other.relativeDate == relativeDate)&&(identical(other.absoluteDate, absoluteDate) || other.absoluteDate == absoluteDate)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.clientLocation, clientLocation) || other.clientLocation == clientLocation)&&(identical(other.paymentVerifiedStatus, paymentVerifiedStatus) || other.paymentVerifiedStatus == paymentVerifiedStatus)&&const DeepCollectionEquality().equals(other.allowedApplicantCountries, allowedApplicantCountries)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientNameConfidencePercent, clientNameConfidencePercent) || other.clientNameConfidencePercent == clientNameConfidencePercent)&&(identical(other.clientAvgHourlyRate, clientAvgHourlyRate) || other.clientAvgHourlyRate == clientAvgHourlyRate)&&(identical(other.clientRating, clientRating) || other.clientRating == clientRating)&&(identical(other.clientHireRatePercent, clientHireRatePercent) || other.clientHireRatePercent == clientHireRatePercent)&&(identical(other.clientTotalSpent, clientTotalSpent) || other.clientTotalSpent == clientTotalSpent)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.hasHired, hasHired) || other.hasHired == hasHired)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,subId,title,description,url,relativeDate,absoluteDate,budget,jobType,experienceLevel,clientLocation,paymentVerifiedStatus,const DeepCollectionEquality().hash(allowedApplicantCountries),clientName,clientNameConfidencePercent,clientAvgHourlyRate,clientRating,clientHireRatePercent,clientTotalSpent,const DeepCollectionEquality().hash(tags),hasHired,const DeepCollectionEquality().hash(questions)]);

@override
String toString() {
  return 'JobInfo(id: $id, subId: $subId, title: $title, description: $description, url: $url, relativeDate: $relativeDate, absoluteDate: $absoluteDate, budget: $budget, jobType: $jobType, experienceLevel: $experienceLevel, clientLocation: $clientLocation, paymentVerifiedStatus: $paymentVerifiedStatus, allowedApplicantCountries: $allowedApplicantCountries, clientName: $clientName, clientNameConfidencePercent: $clientNameConfidencePercent, clientAvgHourlyRate: $clientAvgHourlyRate, clientRating: $clientRating, clientHireRatePercent: $clientHireRatePercent, clientTotalSpent: $clientTotalSpent, tags: $tags, hasHired: $hasHired, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $JobInfoCopyWith<$Res>  {
  factory $JobInfoCopyWith(JobInfo value, $Res Function(JobInfo) _then) = _$JobInfoCopyWithImpl;
@useResult
$Res call({
 String id, String? subId, String title, String description, String url, String? relativeDate, String? absoluteDate, double? budget, JobType jobType, ExperienceLevel experienceLevel, ClientLocation? clientLocation, PaymentVerifiedStatus paymentVerifiedStatus, List<ClientLocation> allowedApplicantCountries, String? clientName, double? clientNameConfidencePercent, double? clientAvgHourlyRate, double? clientRating, double? clientHireRatePercent, double? clientTotalSpent, List<String> tags, bool hasHired, List<Question> questions
});


$ClientLocationCopyWith<$Res>? get clientLocation;

}
/// @nodoc
class _$JobInfoCopyWithImpl<$Res>
    implements $JobInfoCopyWith<$Res> {
  _$JobInfoCopyWithImpl(this._self, this._then);

  final JobInfo _self;
  final $Res Function(JobInfo) _then;

/// Create a copy of JobInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subId = freezed,Object? title = null,Object? description = null,Object? url = null,Object? relativeDate = freezed,Object? absoluteDate = freezed,Object? budget = freezed,Object? jobType = null,Object? experienceLevel = null,Object? clientLocation = freezed,Object? paymentVerifiedStatus = null,Object? allowedApplicantCountries = null,Object? clientName = freezed,Object? clientNameConfidencePercent = freezed,Object? clientAvgHourlyRate = freezed,Object? clientRating = freezed,Object? clientHireRatePercent = freezed,Object? clientTotalSpent = freezed,Object? tags = null,Object? hasHired = null,Object? questions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subId: freezed == subId ? _self.subId : subId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,relativeDate: freezed == relativeDate ? _self.relativeDate : relativeDate // ignore: cast_nullable_to_non_nullable
as String?,absoluteDate: freezed == absoluteDate ? _self.absoluteDate : absoluteDate // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,jobType: null == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as JobType,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel,clientLocation: freezed == clientLocation ? _self.clientLocation : clientLocation // ignore: cast_nullable_to_non_nullable
as ClientLocation?,paymentVerifiedStatus: null == paymentVerifiedStatus ? _self.paymentVerifiedStatus : paymentVerifiedStatus // ignore: cast_nullable_to_non_nullable
as PaymentVerifiedStatus,allowedApplicantCountries: null == allowedApplicantCountries ? _self.allowedApplicantCountries : allowedApplicantCountries // ignore: cast_nullable_to_non_nullable
as List<ClientLocation>,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientNameConfidencePercent: freezed == clientNameConfidencePercent ? _self.clientNameConfidencePercent : clientNameConfidencePercent // ignore: cast_nullable_to_non_nullable
as double?,clientAvgHourlyRate: freezed == clientAvgHourlyRate ? _self.clientAvgHourlyRate : clientAvgHourlyRate // ignore: cast_nullable_to_non_nullable
as double?,clientRating: freezed == clientRating ? _self.clientRating : clientRating // ignore: cast_nullable_to_non_nullable
as double?,clientHireRatePercent: freezed == clientHireRatePercent ? _self.clientHireRatePercent : clientHireRatePercent // ignore: cast_nullable_to_non_nullable
as double?,clientTotalSpent: freezed == clientTotalSpent ? _self.clientTotalSpent : clientTotalSpent // ignore: cast_nullable_to_non_nullable
as double?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,hasHired: null == hasHired ? _self.hasHired : hasHired // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}
/// Create a copy of JobInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientLocationCopyWith<$Res>? get clientLocation {
    if (_self.clientLocation == null) {
    return null;
  }

  return $ClientLocationCopyWith<$Res>(_self.clientLocation!, (value) {
    return _then(_self.copyWith(clientLocation: value));
  });
}
}


/// Adds pattern-matching-related methods to [JobInfo].
extension JobInfoPatterns on JobInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobInfo value)  $default,){
final _that = this;
switch (_that) {
case _JobInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobInfo value)?  $default,){
final _that = this;
switch (_that) {
case _JobInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? subId,  String title,  String description,  String url,  String? relativeDate,  String? absoluteDate,  double? budget,  JobType jobType,  ExperienceLevel experienceLevel,  ClientLocation? clientLocation,  PaymentVerifiedStatus paymentVerifiedStatus,  List<ClientLocation> allowedApplicantCountries,  String? clientName,  double? clientNameConfidencePercent,  double? clientAvgHourlyRate,  double? clientRating,  double? clientHireRatePercent,  double? clientTotalSpent,  List<String> tags,  bool hasHired,  List<Question> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobInfo() when $default != null:
return $default(_that.id,_that.subId,_that.title,_that.description,_that.url,_that.relativeDate,_that.absoluteDate,_that.budget,_that.jobType,_that.experienceLevel,_that.clientLocation,_that.paymentVerifiedStatus,_that.allowedApplicantCountries,_that.clientName,_that.clientNameConfidencePercent,_that.clientAvgHourlyRate,_that.clientRating,_that.clientHireRatePercent,_that.clientTotalSpent,_that.tags,_that.hasHired,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? subId,  String title,  String description,  String url,  String? relativeDate,  String? absoluteDate,  double? budget,  JobType jobType,  ExperienceLevel experienceLevel,  ClientLocation? clientLocation,  PaymentVerifiedStatus paymentVerifiedStatus,  List<ClientLocation> allowedApplicantCountries,  String? clientName,  double? clientNameConfidencePercent,  double? clientAvgHourlyRate,  double? clientRating,  double? clientHireRatePercent,  double? clientTotalSpent,  List<String> tags,  bool hasHired,  List<Question> questions)  $default,) {final _that = this;
switch (_that) {
case _JobInfo():
return $default(_that.id,_that.subId,_that.title,_that.description,_that.url,_that.relativeDate,_that.absoluteDate,_that.budget,_that.jobType,_that.experienceLevel,_that.clientLocation,_that.paymentVerifiedStatus,_that.allowedApplicantCountries,_that.clientName,_that.clientNameConfidencePercent,_that.clientAvgHourlyRate,_that.clientRating,_that.clientHireRatePercent,_that.clientTotalSpent,_that.tags,_that.hasHired,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? subId,  String title,  String description,  String url,  String? relativeDate,  String? absoluteDate,  double? budget,  JobType jobType,  ExperienceLevel experienceLevel,  ClientLocation? clientLocation,  PaymentVerifiedStatus paymentVerifiedStatus,  List<ClientLocation> allowedApplicantCountries,  String? clientName,  double? clientNameConfidencePercent,  double? clientAvgHourlyRate,  double? clientRating,  double? clientHireRatePercent,  double? clientTotalSpent,  List<String> tags,  bool hasHired,  List<Question> questions)?  $default,) {final _that = this;
switch (_that) {
case _JobInfo() when $default != null:
return $default(_that.id,_that.subId,_that.title,_that.description,_that.url,_that.relativeDate,_that.absoluteDate,_that.budget,_that.jobType,_that.experienceLevel,_that.clientLocation,_that.paymentVerifiedStatus,_that.allowedApplicantCountries,_that.clientName,_that.clientNameConfidencePercent,_that.clientAvgHourlyRate,_that.clientRating,_that.clientHireRatePercent,_that.clientTotalSpent,_that.tags,_that.hasHired,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobInfo implements JobInfo {
   _JobInfo({required this.id, required this.subId, required this.title, required this.description, required this.url, required this.relativeDate, required this.absoluteDate, required this.budget, required this.jobType, required this.experienceLevel, required this.clientLocation, required this.paymentVerifiedStatus, required final  List<ClientLocation> allowedApplicantCountries, required this.clientName, required this.clientNameConfidencePercent, required this.clientAvgHourlyRate, required this.clientRating, required this.clientHireRatePercent, required this.clientTotalSpent, required final  List<String> tags, required this.hasHired, required final  List<Question> questions}): _allowedApplicantCountries = allowedApplicantCountries,_tags = tags,_questions = questions;
  factory _JobInfo.fromJson(Map<String, dynamic> json) => _$JobInfoFromJson(json);

@override final  String id;
@override final  String? subId;
@override final  String title;
@override final  String description;
@override final  String url;
@override final  String? relativeDate;
@override final  String? absoluteDate;
@override final  double? budget;
@override final  JobType jobType;
@override final  ExperienceLevel experienceLevel;
@override final  ClientLocation? clientLocation;
@override final  PaymentVerifiedStatus paymentVerifiedStatus;
 final  List<ClientLocation> _allowedApplicantCountries;
@override List<ClientLocation> get allowedApplicantCountries {
  if (_allowedApplicantCountries is EqualUnmodifiableListView) return _allowedApplicantCountries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedApplicantCountries);
}

@override final  String? clientName;
@override final  double? clientNameConfidencePercent;
// Goes from 0@ to 100%
@override final  double? clientAvgHourlyRate;
// USD
@override final  double? clientRating;
// Goes from 0 to 5 stars
@override final  double? clientHireRatePercent;
// Goes from 0% to 100%
@override final  double? clientTotalSpent;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  bool hasHired;
// Whether the client has hired anyone for this specific job
 final  List<Question> _questions;
// Whether the client has hired anyone for this specific job
@override List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of JobInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobInfoCopyWith<_JobInfo> get copyWith => __$JobInfoCopyWithImpl<_JobInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.subId, subId) || other.subId == subId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.relativeDate, relativeDate) || other.relativeDate == relativeDate)&&(identical(other.absoluteDate, absoluteDate) || other.absoluteDate == absoluteDate)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.clientLocation, clientLocation) || other.clientLocation == clientLocation)&&(identical(other.paymentVerifiedStatus, paymentVerifiedStatus) || other.paymentVerifiedStatus == paymentVerifiedStatus)&&const DeepCollectionEquality().equals(other._allowedApplicantCountries, _allowedApplicantCountries)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientNameConfidencePercent, clientNameConfidencePercent) || other.clientNameConfidencePercent == clientNameConfidencePercent)&&(identical(other.clientAvgHourlyRate, clientAvgHourlyRate) || other.clientAvgHourlyRate == clientAvgHourlyRate)&&(identical(other.clientRating, clientRating) || other.clientRating == clientRating)&&(identical(other.clientHireRatePercent, clientHireRatePercent) || other.clientHireRatePercent == clientHireRatePercent)&&(identical(other.clientTotalSpent, clientTotalSpent) || other.clientTotalSpent == clientTotalSpent)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.hasHired, hasHired) || other.hasHired == hasHired)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,subId,title,description,url,relativeDate,absoluteDate,budget,jobType,experienceLevel,clientLocation,paymentVerifiedStatus,const DeepCollectionEquality().hash(_allowedApplicantCountries),clientName,clientNameConfidencePercent,clientAvgHourlyRate,clientRating,clientHireRatePercent,clientTotalSpent,const DeepCollectionEquality().hash(_tags),hasHired,const DeepCollectionEquality().hash(_questions)]);

@override
String toString() {
  return 'JobInfo(id: $id, subId: $subId, title: $title, description: $description, url: $url, relativeDate: $relativeDate, absoluteDate: $absoluteDate, budget: $budget, jobType: $jobType, experienceLevel: $experienceLevel, clientLocation: $clientLocation, paymentVerifiedStatus: $paymentVerifiedStatus, allowedApplicantCountries: $allowedApplicantCountries, clientName: $clientName, clientNameConfidencePercent: $clientNameConfidencePercent, clientAvgHourlyRate: $clientAvgHourlyRate, clientRating: $clientRating, clientHireRatePercent: $clientHireRatePercent, clientTotalSpent: $clientTotalSpent, tags: $tags, hasHired: $hasHired, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$JobInfoCopyWith<$Res> implements $JobInfoCopyWith<$Res> {
  factory _$JobInfoCopyWith(_JobInfo value, $Res Function(_JobInfo) _then) = __$JobInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String? subId, String title, String description, String url, String? relativeDate, String? absoluteDate, double? budget, JobType jobType, ExperienceLevel experienceLevel, ClientLocation? clientLocation, PaymentVerifiedStatus paymentVerifiedStatus, List<ClientLocation> allowedApplicantCountries, String? clientName, double? clientNameConfidencePercent, double? clientAvgHourlyRate, double? clientRating, double? clientHireRatePercent, double? clientTotalSpent, List<String> tags, bool hasHired, List<Question> questions
});


@override $ClientLocationCopyWith<$Res>? get clientLocation;

}
/// @nodoc
class __$JobInfoCopyWithImpl<$Res>
    implements _$JobInfoCopyWith<$Res> {
  __$JobInfoCopyWithImpl(this._self, this._then);

  final _JobInfo _self;
  final $Res Function(_JobInfo) _then;

/// Create a copy of JobInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subId = freezed,Object? title = null,Object? description = null,Object? url = null,Object? relativeDate = freezed,Object? absoluteDate = freezed,Object? budget = freezed,Object? jobType = null,Object? experienceLevel = null,Object? clientLocation = freezed,Object? paymentVerifiedStatus = null,Object? allowedApplicantCountries = null,Object? clientName = freezed,Object? clientNameConfidencePercent = freezed,Object? clientAvgHourlyRate = freezed,Object? clientRating = freezed,Object? clientHireRatePercent = freezed,Object? clientTotalSpent = freezed,Object? tags = null,Object? hasHired = null,Object? questions = null,}) {
  return _then(_JobInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subId: freezed == subId ? _self.subId : subId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,relativeDate: freezed == relativeDate ? _self.relativeDate : relativeDate // ignore: cast_nullable_to_non_nullable
as String?,absoluteDate: freezed == absoluteDate ? _self.absoluteDate : absoluteDate // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,jobType: null == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as JobType,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel,clientLocation: freezed == clientLocation ? _self.clientLocation : clientLocation // ignore: cast_nullable_to_non_nullable
as ClientLocation?,paymentVerifiedStatus: null == paymentVerifiedStatus ? _self.paymentVerifiedStatus : paymentVerifiedStatus // ignore: cast_nullable_to_non_nullable
as PaymentVerifiedStatus,allowedApplicantCountries: null == allowedApplicantCountries ? _self._allowedApplicantCountries : allowedApplicantCountries // ignore: cast_nullable_to_non_nullable
as List<ClientLocation>,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientNameConfidencePercent: freezed == clientNameConfidencePercent ? _self.clientNameConfidencePercent : clientNameConfidencePercent // ignore: cast_nullable_to_non_nullable
as double?,clientAvgHourlyRate: freezed == clientAvgHourlyRate ? _self.clientAvgHourlyRate : clientAvgHourlyRate // ignore: cast_nullable_to_non_nullable
as double?,clientRating: freezed == clientRating ? _self.clientRating : clientRating // ignore: cast_nullable_to_non_nullable
as double?,clientHireRatePercent: freezed == clientHireRatePercent ? _self.clientHireRatePercent : clientHireRatePercent // ignore: cast_nullable_to_non_nullable
as double?,clientTotalSpent: freezed == clientTotalSpent ? _self.clientTotalSpent : clientTotalSpent // ignore: cast_nullable_to_non_nullable
as double?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,hasHired: null == hasHired ? _self.hasHired : hasHired // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}

/// Create a copy of JobInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientLocationCopyWith<$Res>? get clientLocation {
    if (_self.clientLocation == null) {
    return null;
  }

  return $ClientLocationCopyWith<$Res>(_self.clientLocation!, (value) {
    return _then(_self.copyWith(clientLocation: value));
  });
}
}

ClientLocation _$ClientLocationFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'country':
          return _ClientLocationCountry.fromJson(
            json
          );
                case 'region':
          return _ClientLocationRegion.fromJson(
            json
          );
                case 'subRegion':
          return _ClientLocationSubRegion.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'ClientLocation',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$ClientLocation {



  /// Serializes this ClientLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientLocation);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientLocation()';
}


}

/// @nodoc
class $ClientLocationCopyWith<$Res>  {
$ClientLocationCopyWith(ClientLocation _, $Res Function(ClientLocation) __);
}


/// Adds pattern-matching-related methods to [ClientLocation].
extension ClientLocationPatterns on ClientLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ClientLocationCountry value)?  country,TResult Function( _ClientLocationRegion value)?  region,TResult Function( _ClientLocationSubRegion value)?  subRegion,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientLocationCountry() when country != null:
return country(_that);case _ClientLocationRegion() when region != null:
return region(_that);case _ClientLocationSubRegion() when subRegion != null:
return subRegion(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ClientLocationCountry value)  country,required TResult Function( _ClientLocationRegion value)  region,required TResult Function( _ClientLocationSubRegion value)  subRegion,}){
final _that = this;
switch (_that) {
case _ClientLocationCountry():
return country(_that);case _ClientLocationRegion():
return region(_that);case _ClientLocationSubRegion():
return subRegion(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ClientLocationCountry value)?  country,TResult? Function( _ClientLocationRegion value)?  region,TResult? Function( _ClientLocationSubRegion value)?  subRegion,}){
final _that = this;
switch (_that) {
case _ClientLocationCountry() when country != null:
return country(_that);case _ClientLocationRegion() when region != null:
return region(_that);case _ClientLocationSubRegion() when subRegion != null:
return subRegion(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Country country)?  country,TResult Function( Region region)?  region,TResult Function( SubRegion subRegion)?  subRegion,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientLocationCountry() when country != null:
return country(_that.country);case _ClientLocationRegion() when region != null:
return region(_that.region);case _ClientLocationSubRegion() when subRegion != null:
return subRegion(_that.subRegion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Country country)  country,required TResult Function( Region region)  region,required TResult Function( SubRegion subRegion)  subRegion,}) {final _that = this;
switch (_that) {
case _ClientLocationCountry():
return country(_that.country);case _ClientLocationRegion():
return region(_that.region);case _ClientLocationSubRegion():
return subRegion(_that.subRegion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Country country)?  country,TResult? Function( Region region)?  region,TResult? Function( SubRegion subRegion)?  subRegion,}) {final _that = this;
switch (_that) {
case _ClientLocationCountry() when country != null:
return country(_that.country);case _ClientLocationRegion() when region != null:
return region(_that.region);case _ClientLocationSubRegion() when subRegion != null:
return subRegion(_that.subRegion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientLocationCountry implements ClientLocation {
   _ClientLocationCountry({required this.country, final  String? $type}): $type = $type ?? 'country';
  factory _ClientLocationCountry.fromJson(Map<String, dynamic> json) => _$ClientLocationCountryFromJson(json);

 final  Country country;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ClientLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientLocationCountryCopyWith<_ClientLocationCountry> get copyWith => __$ClientLocationCountryCopyWithImpl<_ClientLocationCountry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientLocationCountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientLocationCountry&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country);

@override
String toString() {
  return 'ClientLocation.country(country: $country)';
}


}

/// @nodoc
abstract mixin class _$ClientLocationCountryCopyWith<$Res> implements $ClientLocationCopyWith<$Res> {
  factory _$ClientLocationCountryCopyWith(_ClientLocationCountry value, $Res Function(_ClientLocationCountry) _then) = __$ClientLocationCountryCopyWithImpl;
@useResult
$Res call({
 Country country
});




}
/// @nodoc
class __$ClientLocationCountryCopyWithImpl<$Res>
    implements _$ClientLocationCountryCopyWith<$Res> {
  __$ClientLocationCountryCopyWithImpl(this._self, this._then);

  final _ClientLocationCountry _self;
  final $Res Function(_ClientLocationCountry) _then;

/// Create a copy of ClientLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? country = null,}) {
  return _then(_ClientLocationCountry(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _ClientLocationRegion implements ClientLocation {
   _ClientLocationRegion({required this.region, final  String? $type}): $type = $type ?? 'region';
  factory _ClientLocationRegion.fromJson(Map<String, dynamic> json) => _$ClientLocationRegionFromJson(json);

 final  Region region;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ClientLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientLocationRegionCopyWith<_ClientLocationRegion> get copyWith => __$ClientLocationRegionCopyWithImpl<_ClientLocationRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientLocationRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientLocationRegion&&(identical(other.region, region) || other.region == region));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region);

@override
String toString() {
  return 'ClientLocation.region(region: $region)';
}


}

/// @nodoc
abstract mixin class _$ClientLocationRegionCopyWith<$Res> implements $ClientLocationCopyWith<$Res> {
  factory _$ClientLocationRegionCopyWith(_ClientLocationRegion value, $Res Function(_ClientLocationRegion) _then) = __$ClientLocationRegionCopyWithImpl;
@useResult
$Res call({
 Region region
});




}
/// @nodoc
class __$ClientLocationRegionCopyWithImpl<$Res>
    implements _$ClientLocationRegionCopyWith<$Res> {
  __$ClientLocationRegionCopyWithImpl(this._self, this._then);

  final _ClientLocationRegion _self;
  final $Res Function(_ClientLocationRegion) _then;

/// Create a copy of ClientLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? region = null,}) {
  return _then(_ClientLocationRegion(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _ClientLocationSubRegion implements ClientLocation {
   _ClientLocationSubRegion({required this.subRegion, final  String? $type}): $type = $type ?? 'subRegion';
  factory _ClientLocationSubRegion.fromJson(Map<String, dynamic> json) => _$ClientLocationSubRegionFromJson(json);

 final  SubRegion subRegion;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ClientLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientLocationSubRegionCopyWith<_ClientLocationSubRegion> get copyWith => __$ClientLocationSubRegionCopyWithImpl<_ClientLocationSubRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientLocationSubRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientLocationSubRegion&&(identical(other.subRegion, subRegion) || other.subRegion == subRegion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subRegion);

@override
String toString() {
  return 'ClientLocation.subRegion(subRegion: $subRegion)';
}


}

/// @nodoc
abstract mixin class _$ClientLocationSubRegionCopyWith<$Res> implements $ClientLocationCopyWith<$Res> {
  factory _$ClientLocationSubRegionCopyWith(_ClientLocationSubRegion value, $Res Function(_ClientLocationSubRegion) _then) = __$ClientLocationSubRegionCopyWithImpl;
@useResult
$Res call({
 SubRegion subRegion
});




}
/// @nodoc
class __$ClientLocationSubRegionCopyWithImpl<$Res>
    implements _$ClientLocationSubRegionCopyWith<$Res> {
  __$ClientLocationSubRegionCopyWithImpl(this._self, this._then);

  final _ClientLocationSubRegion _self;
  final $Res Function(_ClientLocationSubRegion) _then;

/// Create a copy of ClientLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subRegion = null,}) {
  return _then(_ClientLocationSubRegion(
subRegion: null == subRegion ? _self.subRegion : subRegion // ignore: cast_nullable_to_non_nullable
as SubRegion,
  ));
}


}


/// @nodoc
mixin _$Question {

 String get question; int get positionIndex;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.question, question) || other.question == question)&&(identical(other.positionIndex, positionIndex) || other.positionIndex == positionIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,positionIndex);

@override
String toString() {
  return 'Question(question: $question, positionIndex: $positionIndex)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String question, int positionIndex
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? positionIndex = null,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,positionIndex: null == positionIndex ? _self.positionIndex : positionIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  int positionIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.question,_that.positionIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  int positionIndex)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.question,_that.positionIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  int positionIndex)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.question,_that.positionIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
   _Question({required this.question, required this.positionIndex});
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String question;
@override final  int positionIndex;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.question, question) || other.question == question)&&(identical(other.positionIndex, positionIndex) || other.positionIndex == positionIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,positionIndex);

@override
String toString() {
  return 'Question(question: $question, positionIndex: $positionIndex)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String question, int positionIndex
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? positionIndex = null,}) {
  return _then(_Question(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,positionIndex: null == positionIndex ? _self.positionIndex : positionIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
