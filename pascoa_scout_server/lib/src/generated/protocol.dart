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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'entities/upwork_scrap/available_operators.dart' as _i5;
import 'entities/upwork_scrap/available_properties.dart' as _i6;
import 'entities/upwork_scrap/client_history.dart' as _i7;
import 'entities/upwork_scrap/client_location.dart' as _i8;
import 'entities/upwork_scrap/country.dart' as _i9;
import 'entities/upwork_scrap/custom_filter.dart' as _i10;
import 'entities/upwork_scrap/experience_level.dart' as _i11;
import 'entities/upwork_scrap/job_age_unit.dart' as _i12;
import 'entities/upwork_scrap/job_filter.dart' as _i13;
import 'entities/upwork_scrap/job_info.dart' as _i14;
import 'entities/upwork_scrap/job_type.dart' as _i15;
import 'entities/upwork_scrap/maximum_job_age.dart' as _i16;
import 'entities/upwork_scrap/min_max.dart' as _i17;
import 'entities/upwork_scrap/pagination.dart' as _i18;
import 'entities/upwork_scrap/pascoa_exception.dart' as _i19;
import 'entities/upwork_scrap/payment_verified_status.dart' as _i20;
import 'entities/upwork_scrap/question.dart' as _i21;
import 'entities/upwork_scrap/region.dart' as _i22;
import 'entities/upwork_scrap/search_sort_order.dart' as _i23;
import 'entities/upwork_scrap/sub_region.dart' as _i24;
import 'greetings/greeting.dart' as _i25;
import 'package:pascoa_scout_server/src/generated/entities/upwork_scrap/job_info.dart'
    as _i26;
export 'entities/upwork_scrap/available_operators.dart';
export 'entities/upwork_scrap/available_properties.dart';
export 'entities/upwork_scrap/client_history.dart';
export 'entities/upwork_scrap/client_location.dart';
export 'entities/upwork_scrap/country.dart';
export 'entities/upwork_scrap/custom_filter.dart';
export 'entities/upwork_scrap/experience_level.dart';
export 'entities/upwork_scrap/job_age_unit.dart';
export 'entities/upwork_scrap/job_filter.dart';
export 'entities/upwork_scrap/job_info.dart';
export 'entities/upwork_scrap/job_type.dart';
export 'entities/upwork_scrap/maximum_job_age.dart';
export 'entities/upwork_scrap/min_max.dart';
export 'entities/upwork_scrap/pagination.dart';
export 'entities/upwork_scrap/pascoa_exception.dart';
export 'entities/upwork_scrap/payment_verified_status.dart';
export 'entities/upwork_scrap/question.dart';
export 'entities/upwork_scrap/region.dart';
export 'entities/upwork_scrap/search_sort_order.dart';
export 'entities/upwork_scrap/sub_region.dart';
export 'greetings/greeting.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AvailableOperators) {
      return _i5.AvailableOperators.fromJson(data) as T;
    }
    if (t == _i6.AvailableProperties) {
      return _i6.AvailableProperties.fromJson(data) as T;
    }
    if (t == _i7.ClientHistory) {
      return _i7.ClientHistory.fromJson(data) as T;
    }
    if (t == _i8.ClientLocation) {
      return _i8.ClientLocation.fromJson(data) as T;
    }
    if (t == _i9.Country) {
      return _i9.Country.fromJson(data) as T;
    }
    if (t == _i10.CustomFilter) {
      return _i10.CustomFilter.fromJson(data) as T;
    }
    if (t == _i11.ExperienceLevel) {
      return _i11.ExperienceLevel.fromJson(data) as T;
    }
    if (t == _i12.JobAgeUnit) {
      return _i12.JobAgeUnit.fromJson(data) as T;
    }
    if (t == _i13.JobFilter) {
      return _i13.JobFilter.fromJson(data) as T;
    }
    if (t == _i14.JobInfo) {
      return _i14.JobInfo.fromJson(data) as T;
    }
    if (t == _i15.JobType) {
      return _i15.JobType.fromJson(data) as T;
    }
    if (t == _i16.MaximumJobAge) {
      return _i16.MaximumJobAge.fromJson(data) as T;
    }
    if (t == _i17.MinMax) {
      return _i17.MinMax.fromJson(data) as T;
    }
    if (t == _i18.Pagination) {
      return _i18.Pagination.fromJson(data) as T;
    }
    if (t == _i19.PascoaException) {
      return _i19.PascoaException.fromJson(data) as T;
    }
    if (t == _i20.PaymentVerifiedStatus) {
      return _i20.PaymentVerifiedStatus.fromJson(data) as T;
    }
    if (t == _i21.Question) {
      return _i21.Question.fromJson(data) as T;
    }
    if (t == _i22.Region) {
      return _i22.Region.fromJson(data) as T;
    }
    if (t == _i23.SearchSortOrder) {
      return _i23.SearchSortOrder.fromJson(data) as T;
    }
    if (t == _i24.SubRegion) {
      return _i24.SubRegion.fromJson(data) as T;
    }
    if (t == _i25.Greeting) {
      return _i25.Greeting.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AvailableOperators?>()) {
      return (data != null ? _i5.AvailableOperators.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AvailableProperties?>()) {
      return (data != null ? _i6.AvailableProperties.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.ClientHistory?>()) {
      return (data != null ? _i7.ClientHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ClientLocation?>()) {
      return (data != null ? _i8.ClientLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Country?>()) {
      return (data != null ? _i9.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CustomFilter?>()) {
      return (data != null ? _i10.CustomFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ExperienceLevel?>()) {
      return (data != null ? _i11.ExperienceLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.JobAgeUnit?>()) {
      return (data != null ? _i12.JobAgeUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.JobFilter?>()) {
      return (data != null ? _i13.JobFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.JobInfo?>()) {
      return (data != null ? _i14.JobInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.JobType?>()) {
      return (data != null ? _i15.JobType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.MaximumJobAge?>()) {
      return (data != null ? _i16.MaximumJobAge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.MinMax?>()) {
      return (data != null ? _i17.MinMax.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Pagination?>()) {
      return (data != null ? _i18.Pagination.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.PascoaException?>()) {
      return (data != null ? _i19.PascoaException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.PaymentVerifiedStatus?>()) {
      return (data != null ? _i20.PaymentVerifiedStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.Question?>()) {
      return (data != null ? _i21.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Region?>()) {
      return (data != null ? _i22.Region.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SearchSortOrder?>()) {
      return (data != null ? _i23.SearchSortOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.SubRegion?>()) {
      return (data != null ? _i24.SubRegion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Greeting?>()) {
      return (data != null ? _i25.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i11.ExperienceLevel>) {
      return (data as List)
              .map((e) => deserialize<_i11.ExperienceLevel>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i11.ExperienceLevel>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i11.ExperienceLevel>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i7.ClientHistory>) {
      return (data as List)
              .map((e) => deserialize<_i7.ClientHistory>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i7.ClientHistory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i7.ClientHistory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i15.JobType>) {
      return (data as List).map((e) => deserialize<_i15.JobType>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i15.JobType>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i15.JobType>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i9.Country>) {
      return (data as List).map((e) => deserialize<_i9.Country>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i9.Country>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i9.Country>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i22.Region>) {
      return (data as List).map((e) => deserialize<_i22.Region>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i22.Region>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i22.Region>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i24.SubRegion>) {
      return (data as List).map((e) => deserialize<_i24.SubRegion>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i24.SubRegion>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i24.SubRegion>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i10.CustomFilter>) {
      return (data as List)
              .map((e) => deserialize<_i10.CustomFilter>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i10.CustomFilter>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i10.CustomFilter>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i21.Question>) {
      return (data as List).map((e) => deserialize<_i21.Question>(e)).toList()
          as T;
    }
    if (t == List<_i26.JobInfo>) {
      return (data as List).map((e) => deserialize<_i26.JobInfo>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AvailableOperators => 'AvailableOperators',
      _i6.AvailableProperties => 'AvailableProperties',
      _i7.ClientHistory => 'ClientHistory',
      _i8.ClientLocation => 'ClientLocation',
      _i9.Country => 'Country',
      _i10.CustomFilter => 'CustomFilter',
      _i11.ExperienceLevel => 'ExperienceLevel',
      _i12.JobAgeUnit => 'JobAgeUnit',
      _i13.JobFilter => 'JobFilter',
      _i14.JobInfo => 'JobInfo',
      _i15.JobType => 'JobType',
      _i16.MaximumJobAge => 'MaximumJobAge',
      _i17.MinMax => 'MinMax',
      _i18.Pagination => 'Pagination',
      _i19.PascoaException => 'PascoaException',
      _i20.PaymentVerifiedStatus => 'PaymentVerifiedStatus',
      _i21.Question => 'Question',
      _i22.Region => 'Region',
      _i23.SearchSortOrder => 'SearchSortOrder',
      _i24.SubRegion => 'SubRegion',
      _i25.Greeting => 'Greeting',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'pascoa_scout.',
        '',
      );
    }

    switch (data) {
      case _i5.AvailableOperators():
        return 'AvailableOperators';
      case _i6.AvailableProperties():
        return 'AvailableProperties';
      case _i7.ClientHistory():
        return 'ClientHistory';
      case _i8.ClientLocation():
        return 'ClientLocation';
      case _i9.Country():
        return 'Country';
      case _i10.CustomFilter():
        return 'CustomFilter';
      case _i11.ExperienceLevel():
        return 'ExperienceLevel';
      case _i12.JobAgeUnit():
        return 'JobAgeUnit';
      case _i13.JobFilter():
        return 'JobFilter';
      case _i14.JobInfo():
        return 'JobInfo';
      case _i15.JobType():
        return 'JobType';
      case _i16.MaximumJobAge():
        return 'MaximumJobAge';
      case _i17.MinMax():
        return 'MinMax';
      case _i18.Pagination():
        return 'Pagination';
      case _i19.PascoaException():
        return 'PascoaException';
      case _i20.PaymentVerifiedStatus():
        return 'PaymentVerifiedStatus';
      case _i21.Question():
        return 'Question';
      case _i22.Region():
        return 'Region';
      case _i23.SearchSortOrder():
        return 'SearchSortOrder';
      case _i24.SubRegion():
        return 'SubRegion';
      case _i25.Greeting():
        return 'Greeting';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AvailableOperators') {
      return deserialize<_i5.AvailableOperators>(data['data']);
    }
    if (dataClassName == 'AvailableProperties') {
      return deserialize<_i6.AvailableProperties>(data['data']);
    }
    if (dataClassName == 'ClientHistory') {
      return deserialize<_i7.ClientHistory>(data['data']);
    }
    if (dataClassName == 'ClientLocation') {
      return deserialize<_i8.ClientLocation>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i9.Country>(data['data']);
    }
    if (dataClassName == 'CustomFilter') {
      return deserialize<_i10.CustomFilter>(data['data']);
    }
    if (dataClassName == 'ExperienceLevel') {
      return deserialize<_i11.ExperienceLevel>(data['data']);
    }
    if (dataClassName == 'JobAgeUnit') {
      return deserialize<_i12.JobAgeUnit>(data['data']);
    }
    if (dataClassName == 'JobFilter') {
      return deserialize<_i13.JobFilter>(data['data']);
    }
    if (dataClassName == 'JobInfo') {
      return deserialize<_i14.JobInfo>(data['data']);
    }
    if (dataClassName == 'JobType') {
      return deserialize<_i15.JobType>(data['data']);
    }
    if (dataClassName == 'MaximumJobAge') {
      return deserialize<_i16.MaximumJobAge>(data['data']);
    }
    if (dataClassName == 'MinMax') {
      return deserialize<_i17.MinMax>(data['data']);
    }
    if (dataClassName == 'Pagination') {
      return deserialize<_i18.Pagination>(data['data']);
    }
    if (dataClassName == 'PascoaException') {
      return deserialize<_i19.PascoaException>(data['data']);
    }
    if (dataClassName == 'PaymentVerifiedStatus') {
      return deserialize<_i20.PaymentVerifiedStatus>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i21.Question>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_i22.Region>(data['data']);
    }
    if (dataClassName == 'SearchSortOrder') {
      return deserialize<_i23.SearchSortOrder>(data['data']);
    }
    if (dataClassName == 'SubRegion') {
      return deserialize<_i24.SubRegion>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i25.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'pascoa_scout';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
