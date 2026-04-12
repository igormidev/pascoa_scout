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
import '../entities/job_analysis_force_sync_stage.dart' as _i2;
import '../entities/job_analysis_force_sync_stage_status.dart' as _i3;
import '../entities/job_analysis_state.dart' as _i4;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i5;

abstract class JobAnalysisForceSyncProgress implements _i1.SerializableModel {
  JobAnalysisForceSyncProgress._({
    required this.jobAnalysisStateId,
    required this.currentStage,
    required this.isFixedPriceJob,
    required this.scoreStatus,
    required this.proposalStatus,
    required this.answersStatus,
    required this.milestonesStatus,
    this.errorMessage,
    this.analysis,
  });

  factory JobAnalysisForceSyncProgress({
    required int jobAnalysisStateId,
    required _i2.JobAnalysisForceSyncStage currentStage,
    required bool isFixedPriceJob,
    required _i3.JobAnalysisForceSyncStageStatus scoreStatus,
    required _i3.JobAnalysisForceSyncStageStatus proposalStatus,
    required _i3.JobAnalysisForceSyncStageStatus answersStatus,
    required _i3.JobAnalysisForceSyncStageStatus milestonesStatus,
    String? errorMessage,
    _i4.JobAnalysisState? analysis,
  }) = _JobAnalysisForceSyncProgressImpl;

  factory JobAnalysisForceSyncProgress.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAnalysisForceSyncProgress(
      jobAnalysisStateId: jsonSerialization['jobAnalysisStateId'] as int,
      currentStage: _i2.JobAnalysisForceSyncStage.fromJson(
        (jsonSerialization['currentStage'] as String),
      ),
      isFixedPriceJob: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isFixedPriceJob'],
      ),
      scoreStatus: _i3.JobAnalysisForceSyncStageStatus.fromJson(
        (jsonSerialization['scoreStatus'] as String),
      ),
      proposalStatus: _i3.JobAnalysisForceSyncStageStatus.fromJson(
        (jsonSerialization['proposalStatus'] as String),
      ),
      answersStatus: _i3.JobAnalysisForceSyncStageStatus.fromJson(
        (jsonSerialization['answersStatus'] as String),
      ),
      milestonesStatus: _i3.JobAnalysisForceSyncStageStatus.fromJson(
        (jsonSerialization['milestonesStatus'] as String),
      ),
      errorMessage: jsonSerialization['errorMessage'] as String?,
      analysis: jsonSerialization['analysis'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.JobAnalysisState>(
              jsonSerialization['analysis'],
            ),
    );
  }

  int jobAnalysisStateId;

  _i2.JobAnalysisForceSyncStage currentStage;

  bool isFixedPriceJob;

  _i3.JobAnalysisForceSyncStageStatus scoreStatus;

  _i3.JobAnalysisForceSyncStageStatus proposalStatus;

  _i3.JobAnalysisForceSyncStageStatus answersStatus;

  _i3.JobAnalysisForceSyncStageStatus milestonesStatus;

  String? errorMessage;

  _i4.JobAnalysisState? analysis;

  /// Returns a shallow copy of this [JobAnalysisForceSyncProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAnalysisForceSyncProgress copyWith({
    int? jobAnalysisStateId,
    _i2.JobAnalysisForceSyncStage? currentStage,
    bool? isFixedPriceJob,
    _i3.JobAnalysisForceSyncStageStatus? scoreStatus,
    _i3.JobAnalysisForceSyncStageStatus? proposalStatus,
    _i3.JobAnalysisForceSyncStageStatus? answersStatus,
    _i3.JobAnalysisForceSyncStageStatus? milestonesStatus,
    String? errorMessage,
    _i4.JobAnalysisState? analysis,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAnalysisForceSyncProgress',
      'jobAnalysisStateId': jobAnalysisStateId,
      'currentStage': currentStage.toJson(),
      'isFixedPriceJob': isFixedPriceJob,
      'scoreStatus': scoreStatus.toJson(),
      'proposalStatus': proposalStatus.toJson(),
      'answersStatus': answersStatus.toJson(),
      'milestonesStatus': milestonesStatus.toJson(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (analysis != null) 'analysis': analysis?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAnalysisForceSyncProgressImpl extends JobAnalysisForceSyncProgress {
  _JobAnalysisForceSyncProgressImpl({
    required int jobAnalysisStateId,
    required _i2.JobAnalysisForceSyncStage currentStage,
    required bool isFixedPriceJob,
    required _i3.JobAnalysisForceSyncStageStatus scoreStatus,
    required _i3.JobAnalysisForceSyncStageStatus proposalStatus,
    required _i3.JobAnalysisForceSyncStageStatus answersStatus,
    required _i3.JobAnalysisForceSyncStageStatus milestonesStatus,
    String? errorMessage,
    _i4.JobAnalysisState? analysis,
  }) : super._(
         jobAnalysisStateId: jobAnalysisStateId,
         currentStage: currentStage,
         isFixedPriceJob: isFixedPriceJob,
         scoreStatus: scoreStatus,
         proposalStatus: proposalStatus,
         answersStatus: answersStatus,
         milestonesStatus: milestonesStatus,
         errorMessage: errorMessage,
         analysis: analysis,
       );

  /// Returns a shallow copy of this [JobAnalysisForceSyncProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAnalysisForceSyncProgress copyWith({
    int? jobAnalysisStateId,
    _i2.JobAnalysisForceSyncStage? currentStage,
    bool? isFixedPriceJob,
    _i3.JobAnalysisForceSyncStageStatus? scoreStatus,
    _i3.JobAnalysisForceSyncStageStatus? proposalStatus,
    _i3.JobAnalysisForceSyncStageStatus? answersStatus,
    _i3.JobAnalysisForceSyncStageStatus? milestonesStatus,
    Object? errorMessage = _Undefined,
    Object? analysis = _Undefined,
  }) {
    return JobAnalysisForceSyncProgress(
      jobAnalysisStateId: jobAnalysisStateId ?? this.jobAnalysisStateId,
      currentStage: currentStage ?? this.currentStage,
      isFixedPriceJob: isFixedPriceJob ?? this.isFixedPriceJob,
      scoreStatus: scoreStatus ?? this.scoreStatus,
      proposalStatus: proposalStatus ?? this.proposalStatus,
      answersStatus: answersStatus ?? this.answersStatus,
      milestonesStatus: milestonesStatus ?? this.milestonesStatus,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      analysis: analysis is _i4.JobAnalysisState?
          ? analysis
          : this.analysis?.copyWith(),
    );
  }
}
