// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
CurrentFiltersState _$CurrentFiltersStateFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'none':
          return _CurrentFiltersStateNone.fromJson(
            json
          );
                case 'withFilter':
          return _CurrentFiltersStateWithFilter.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'CurrentFiltersState',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$CurrentFiltersState {



  /// Serializes this CurrentFiltersState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentFiltersState);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrentFiltersState()';
}


}

/// @nodoc
class $CurrentFiltersStateCopyWith<$Res>  {
$CurrentFiltersStateCopyWith(CurrentFiltersState _, $Res Function(CurrentFiltersState) __);
}


/// Adds pattern-matching-related methods to [CurrentFiltersState].
extension CurrentFiltersStatePatterns on CurrentFiltersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CurrentFiltersStateNone value)?  none,TResult Function( _CurrentFiltersStateWithFilter value)?  withFilter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentFiltersStateNone() when none != null:
return none(_that);case _CurrentFiltersStateWithFilter() when withFilter != null:
return withFilter(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CurrentFiltersStateNone value)  none,required TResult Function( _CurrentFiltersStateWithFilter value)  withFilter,}){
final _that = this;
switch (_that) {
case _CurrentFiltersStateNone():
return none(_that);case _CurrentFiltersStateWithFilter():
return withFilter(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CurrentFiltersStateNone value)?  none,TResult? Function( _CurrentFiltersStateWithFilter value)?  withFilter,}){
final _that = this;
switch (_that) {
case _CurrentFiltersStateNone() when none != null:
return none(_that);case _CurrentFiltersStateWithFilter() when withFilter != null:
return withFilter(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  none,TResult Function( JobFilter jobFilter)?  withFilter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentFiltersStateNone() when none != null:
return none();case _CurrentFiltersStateWithFilter() when withFilter != null:
return withFilter(_that.jobFilter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  none,required TResult Function( JobFilter jobFilter)  withFilter,}) {final _that = this;
switch (_that) {
case _CurrentFiltersStateNone():
return none();case _CurrentFiltersStateWithFilter():
return withFilter(_that.jobFilter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  none,TResult? Function( JobFilter jobFilter)?  withFilter,}) {final _that = this;
switch (_that) {
case _CurrentFiltersStateNone() when none != null:
return none();case _CurrentFiltersStateWithFilter() when withFilter != null:
return withFilter(_that.jobFilter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentFiltersStateNone implements CurrentFiltersState {
   _CurrentFiltersStateNone({final  String? $type}): $type = $type ?? 'none';
  factory _CurrentFiltersStateNone.fromJson(Map<String, dynamic> json) => _$CurrentFiltersStateNoneFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$CurrentFiltersStateNoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentFiltersStateNone);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrentFiltersState.none()';
}


}




/// @nodoc
@JsonSerializable()

class _CurrentFiltersStateWithFilter implements CurrentFiltersState {
   _CurrentFiltersStateWithFilter({required this.jobFilter, final  String? $type}): $type = $type ?? 'withFilter';
  factory _CurrentFiltersStateWithFilter.fromJson(Map<String, dynamic> json) => _$CurrentFiltersStateWithFilterFromJson(json);

 final  JobFilter jobFilter;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of CurrentFiltersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentFiltersStateWithFilterCopyWith<_CurrentFiltersStateWithFilter> get copyWith => __$CurrentFiltersStateWithFilterCopyWithImpl<_CurrentFiltersStateWithFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentFiltersStateWithFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentFiltersStateWithFilter&&(identical(other.jobFilter, jobFilter) || other.jobFilter == jobFilter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobFilter);

@override
String toString() {
  return 'CurrentFiltersState.withFilter(jobFilter: $jobFilter)';
}


}

/// @nodoc
abstract mixin class _$CurrentFiltersStateWithFilterCopyWith<$Res> implements $CurrentFiltersStateCopyWith<$Res> {
  factory _$CurrentFiltersStateWithFilterCopyWith(_CurrentFiltersStateWithFilter value, $Res Function(_CurrentFiltersStateWithFilter) _then) = __$CurrentFiltersStateWithFilterCopyWithImpl;
@useResult
$Res call({
 JobFilter jobFilter
});




}
/// @nodoc
class __$CurrentFiltersStateWithFilterCopyWithImpl<$Res>
    implements _$CurrentFiltersStateWithFilterCopyWith<$Res> {
  __$CurrentFiltersStateWithFilterCopyWithImpl(this._self, this._then);

  final _CurrentFiltersStateWithFilter _self;
  final $Res Function(_CurrentFiltersStateWithFilter) _then;

/// Create a copy of CurrentFiltersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? jobFilter = null,}) {
  return _then(_CurrentFiltersStateWithFilter(
jobFilter: null == jobFilter ? _self.jobFilter : jobFilter // ignore: cast_nullable_to_non_nullable
as JobFilter,
  ));
}


}

// dart format on
