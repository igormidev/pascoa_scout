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
import '../entities/job_automation_settings.dart' as _i2;
import '../entities/job_automation_runtime.dart' as _i3;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i4;

abstract class JobAutomationOverview
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  JobAutomationOverview._({
    required this.settings,
    required this.runtime,
    required this.isLoopActive,
  });

  factory JobAutomationOverview({
    required _i2.JobAutomationSettings settings,
    required _i3.JobAutomationRuntime runtime,
    required bool isLoopActive,
  }) = _JobAutomationOverviewImpl;

  factory JobAutomationOverview.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAutomationOverview(
      settings: _i4.Protocol().deserialize<_i2.JobAutomationSettings>(
        jsonSerialization['settings'],
      ),
      runtime: _i4.Protocol().deserialize<_i3.JobAutomationRuntime>(
        jsonSerialization['runtime'],
      ),
      isLoopActive: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isLoopActive'],
      ),
    );
  }

  _i2.JobAutomationSettings settings;

  _i3.JobAutomationRuntime runtime;

  bool isLoopActive;

  /// Returns a shallow copy of this [JobAutomationOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAutomationOverview copyWith({
    _i2.JobAutomationSettings? settings,
    _i3.JobAutomationRuntime? runtime,
    bool? isLoopActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAutomationOverview',
      'settings': settings.toJson(),
      'runtime': runtime.toJson(),
      'isLoopActive': isLoopActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobAutomationOverview',
      'settings': settings.toJsonForProtocol(),
      'runtime': runtime.toJsonForProtocol(),
      'isLoopActive': isLoopActive,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _JobAutomationOverviewImpl extends JobAutomationOverview {
  _JobAutomationOverviewImpl({
    required _i2.JobAutomationSettings settings,
    required _i3.JobAutomationRuntime runtime,
    required bool isLoopActive,
  }) : super._(
         settings: settings,
         runtime: runtime,
         isLoopActive: isLoopActive,
       );

  /// Returns a shallow copy of this [JobAutomationOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAutomationOverview copyWith({
    _i2.JobAutomationSettings? settings,
    _i3.JobAutomationRuntime? runtime,
    bool? isLoopActive,
  }) {
    return JobAutomationOverview(
      settings: settings ?? this.settings.copyWith(),
      runtime: runtime ?? this.runtime.copyWith(),
      isLoopActive: isLoopActive ?? this.isLoopActive,
    );
  }
}
