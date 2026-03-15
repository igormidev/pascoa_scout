// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_filter_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentFiltersStateNone _$CurrentFiltersStateNoneFromJson(
  Map<String, dynamic> json,
) => _CurrentFiltersStateNone($type: json['runtimeType'] as String?);

Map<String, dynamic> _$CurrentFiltersStateNoneToJson(
  _CurrentFiltersStateNone instance,
) => <String, dynamic>{'runtimeType': instance.$type};

_CurrentFiltersStateWithFilter _$CurrentFiltersStateWithFilterFromJson(
  Map<String, dynamic> json,
) => _CurrentFiltersStateWithFilter(
  jobFilter: JobFilter.fromJson(json['jobFilter'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$CurrentFiltersStateWithFilterToJson(
  _CurrentFiltersStateWithFilter instance,
) => <String, dynamic>{
  'jobFilter': instance.jobFilter,
  'runtimeType': instance.$type,
};
