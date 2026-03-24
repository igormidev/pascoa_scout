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
import '../entities/job_automation_step.dart' as _i2;

abstract class JobAutomationRuntime implements _i1.SerializableModel {
  JobAutomationRuntime._({
    this.id,
    required this.singletonKey,
    required this.currentStep,
    required this.currentStepStartedAt,
    required this.updatedAt,
    this.lastSuccessfulJobSyncAt,
    this.lastSuccessfulScoringAt,
    this.lastSuccessfulProposalGenerationAt,
    this.lastErrorMessage,
    this.lastErrorAt,
  });

  factory JobAutomationRuntime({
    int? id,
    required String singletonKey,
    required _i2.JobAutomationStep currentStep,
    required DateTime currentStepStartedAt,
    required DateTime updatedAt,
    DateTime? lastSuccessfulJobSyncAt,
    DateTime? lastSuccessfulScoringAt,
    DateTime? lastSuccessfulProposalGenerationAt,
    String? lastErrorMessage,
    DateTime? lastErrorAt,
  }) = _JobAutomationRuntimeImpl;

  factory JobAutomationRuntime.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAutomationRuntime(
      id: jsonSerialization['id'] as int?,
      singletonKey: jsonSerialization['singletonKey'] as String,
      currentStep: _i2.JobAutomationStep.fromJson(
        (jsonSerialization['currentStep'] as String),
      ),
      currentStepStartedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['currentStepStartedAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      lastSuccessfulJobSyncAt:
          jsonSerialization['lastSuccessfulJobSyncAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessfulJobSyncAt'],
            ),
      lastSuccessfulScoringAt:
          jsonSerialization['lastSuccessfulScoringAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessfulScoringAt'],
            ),
      lastSuccessfulProposalGenerationAt:
          jsonSerialization['lastSuccessfulProposalGenerationAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessfulProposalGenerationAt'],
            ),
      lastErrorMessage: jsonSerialization['lastErrorMessage'] as String?,
      lastErrorAt: jsonSerialization['lastErrorAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastErrorAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String singletonKey;

  _i2.JobAutomationStep currentStep;

  DateTime currentStepStartedAt;

  DateTime updatedAt;

  DateTime? lastSuccessfulJobSyncAt;

  DateTime? lastSuccessfulScoringAt;

  DateTime? lastSuccessfulProposalGenerationAt;

  String? lastErrorMessage;

  DateTime? lastErrorAt;

  /// Returns a shallow copy of this [JobAutomationRuntime]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAutomationRuntime copyWith({
    int? id,
    String? singletonKey,
    _i2.JobAutomationStep? currentStep,
    DateTime? currentStepStartedAt,
    DateTime? updatedAt,
    DateTime? lastSuccessfulJobSyncAt,
    DateTime? lastSuccessfulScoringAt,
    DateTime? lastSuccessfulProposalGenerationAt,
    String? lastErrorMessage,
    DateTime? lastErrorAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAutomationRuntime',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'currentStep': currentStep.toJson(),
      'currentStepStartedAt': currentStepStartedAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastSuccessfulJobSyncAt != null)
        'lastSuccessfulJobSyncAt': lastSuccessfulJobSyncAt?.toJson(),
      if (lastSuccessfulScoringAt != null)
        'lastSuccessfulScoringAt': lastSuccessfulScoringAt?.toJson(),
      if (lastSuccessfulProposalGenerationAt != null)
        'lastSuccessfulProposalGenerationAt': lastSuccessfulProposalGenerationAt
            ?.toJson(),
      if (lastErrorMessage != null) 'lastErrorMessage': lastErrorMessage,
      if (lastErrorAt != null) 'lastErrorAt': lastErrorAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAutomationRuntimeImpl extends JobAutomationRuntime {
  _JobAutomationRuntimeImpl({
    int? id,
    required String singletonKey,
    required _i2.JobAutomationStep currentStep,
    required DateTime currentStepStartedAt,
    required DateTime updatedAt,
    DateTime? lastSuccessfulJobSyncAt,
    DateTime? lastSuccessfulScoringAt,
    DateTime? lastSuccessfulProposalGenerationAt,
    String? lastErrorMessage,
    DateTime? lastErrorAt,
  }) : super._(
         id: id,
         singletonKey: singletonKey,
         currentStep: currentStep,
         currentStepStartedAt: currentStepStartedAt,
         updatedAt: updatedAt,
         lastSuccessfulJobSyncAt: lastSuccessfulJobSyncAt,
         lastSuccessfulScoringAt: lastSuccessfulScoringAt,
         lastSuccessfulProposalGenerationAt: lastSuccessfulProposalGenerationAt,
         lastErrorMessage: lastErrorMessage,
         lastErrorAt: lastErrorAt,
       );

  /// Returns a shallow copy of this [JobAutomationRuntime]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAutomationRuntime copyWith({
    Object? id = _Undefined,
    String? singletonKey,
    _i2.JobAutomationStep? currentStep,
    DateTime? currentStepStartedAt,
    DateTime? updatedAt,
    Object? lastSuccessfulJobSyncAt = _Undefined,
    Object? lastSuccessfulScoringAt = _Undefined,
    Object? lastSuccessfulProposalGenerationAt = _Undefined,
    Object? lastErrorMessage = _Undefined,
    Object? lastErrorAt = _Undefined,
  }) {
    return JobAutomationRuntime(
      id: id is int? ? id : this.id,
      singletonKey: singletonKey ?? this.singletonKey,
      currentStep: currentStep ?? this.currentStep,
      currentStepStartedAt: currentStepStartedAt ?? this.currentStepStartedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSuccessfulJobSyncAt: lastSuccessfulJobSyncAt is DateTime?
          ? lastSuccessfulJobSyncAt
          : this.lastSuccessfulJobSyncAt,
      lastSuccessfulScoringAt: lastSuccessfulScoringAt is DateTime?
          ? lastSuccessfulScoringAt
          : this.lastSuccessfulScoringAt,
      lastSuccessfulProposalGenerationAt:
          lastSuccessfulProposalGenerationAt is DateTime?
          ? lastSuccessfulProposalGenerationAt
          : this.lastSuccessfulProposalGenerationAt,
      lastErrorMessage: lastErrorMessage is String?
          ? lastErrorMessage
          : this.lastErrorMessage,
      lastErrorAt: lastErrorAt is DateTime? ? lastErrorAt : this.lastErrorAt,
    );
  }
}
