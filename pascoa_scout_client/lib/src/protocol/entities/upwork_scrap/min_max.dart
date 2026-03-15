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

abstract class MinMax implements _i1.SerializableModel {
  MinMax._({
    required this.min,
    required this.max,
  });

  factory MinMax({
    required int min,
    required int max,
  }) = _MinMaxImpl;

  factory MinMax.fromJson(Map<String, dynamic> jsonSerialization) {
    return MinMax(
      min: jsonSerialization['min'] as int,
      max: jsonSerialization['max'] as int,
    );
  }

  int min;

  int max;

  /// Returns a shallow copy of this [MinMax]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MinMax copyWith({
    int? min,
    int? max,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MinMax',
      'min': min,
      'max': max,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MinMaxImpl extends MinMax {
  _MinMaxImpl({
    required int min,
    required int max,
  }) : super._(
         min: min,
         max: max,
       );

  /// Returns a shallow copy of this [MinMax]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MinMax copyWith({
    int? min,
    int? max,
  }) {
    return MinMax(
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }
}
