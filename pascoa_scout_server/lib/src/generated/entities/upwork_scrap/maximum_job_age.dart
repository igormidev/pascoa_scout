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
import '../../entities/upwork_scrap/job_age_unit.dart' as _i2;

abstract class MaximumJobAge
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MaximumJobAge._({
    required this.unit,
    required this.value,
  });

  factory MaximumJobAge({
    required _i2.JobAgeUnit unit,
    required int value,
  }) = _MaximumJobAgeImpl;

  factory MaximumJobAge.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaximumJobAge(
      unit: _i2.JobAgeUnit.fromJson((jsonSerialization['unit'] as String)),
      value: jsonSerialization['value'] as int,
    );
  }

  _i2.JobAgeUnit unit;

  int value;

  /// Returns a shallow copy of this [MaximumJobAge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaximumJobAge copyWith({
    _i2.JobAgeUnit? unit,
    int? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaximumJobAge',
      'unit': unit.toJson(),
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaximumJobAge',
      'unit': unit.toJson(),
      'value': value,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MaximumJobAgeImpl extends MaximumJobAge {
  _MaximumJobAgeImpl({
    required _i2.JobAgeUnit unit,
    required int value,
  }) : super._(
         unit: unit,
         value: value,
       );

  /// Returns a shallow copy of this [MaximumJobAge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaximumJobAge copyWith({
    _i2.JobAgeUnit? unit,
    int? value,
  }) {
    return MaximumJobAge(
      unit: unit ?? this.unit,
      value: value ?? this.value,
    );
  }
}
