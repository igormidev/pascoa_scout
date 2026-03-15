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
import '../../entities/upwork_scrap/available_properties.dart' as _i2;
import '../../entities/upwork_scrap/available_operators.dart' as _i3;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i4;

abstract class CustomFilter implements _i1.SerializableModel {
  CustomFilter._({
    required this.properties,
    required this.operators,
    required this.values,
  });

  factory CustomFilter({
    required _i2.AvailableProperties properties,
    required _i3.AvailableOperators operators,
    required List<String> values,
  }) = _CustomFilterImpl;

  factory CustomFilter.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomFilter(
      properties: _i2.AvailableProperties.fromJson(
        (jsonSerialization['properties'] as String),
      ),
      operators: _i3.AvailableOperators.fromJson(
        (jsonSerialization['operators'] as String),
      ),
      values: _i4.Protocol().deserialize<List<String>>(
        jsonSerialization['values'],
      ),
    );
  }

  _i2.AvailableProperties properties;

  _i3.AvailableOperators operators;

  List<String> values;

  /// Returns a shallow copy of this [CustomFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CustomFilter copyWith({
    _i2.AvailableProperties? properties,
    _i3.AvailableOperators? operators,
    List<String>? values,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomFilter',
      'properties': properties.toJson(),
      'operators': operators.toJson(),
      'values': values.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CustomFilterImpl extends CustomFilter {
  _CustomFilterImpl({
    required _i2.AvailableProperties properties,
    required _i3.AvailableOperators operators,
    required List<String> values,
  }) : super._(
         properties: properties,
         operators: operators,
         values: values,
       );

  /// Returns a shallow copy of this [CustomFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CustomFilter copyWith({
    _i2.AvailableProperties? properties,
    _i3.AvailableOperators? operators,
    List<String>? values,
  }) {
    return CustomFilter(
      properties: properties ?? this.properties,
      operators: operators ?? this.operators,
      values: values ?? this.values.map((e0) => e0).toList(),
    );
  }
}
