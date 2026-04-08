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
import '../entities/upwork_scrap/job_filter.dart' as _i2;
import '../entities/job_automation_ai_model.dart' as _i3;
import '../entities/job_automation_ai_thinking_effort.dart' as _i4;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i5;

abstract class JobAutomationSettingsUpdate
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  JobAutomationSettingsUpdate._({
    required this.jobFilter,
    required this.scoreBatchSize,
    required this.proposalBatchSize,
    required this.upworkSyncResultsPerPage,
    required this.proposalMinimumScorePercentage,
    required this.loopDelayMinutes,
    required this.aiModel,
    required this.aiThinkingEffort,
  });

  factory JobAutomationSettingsUpdate({
    required _i2.JobFilter jobFilter,
    required int scoreBatchSize,
    required int proposalBatchSize,
    required int upworkSyncResultsPerPage,
    required int proposalMinimumScorePercentage,
    required int loopDelayMinutes,
    required _i3.JobAutomationAiModel aiModel,
    required _i4.JobAutomationAiThinkingEffort aiThinkingEffort,
  }) = _JobAutomationSettingsUpdateImpl;

  factory JobAutomationSettingsUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAutomationSettingsUpdate(
      jobFilter: _i5.Protocol().deserialize<_i2.JobFilter>(
        jsonSerialization['jobFilter'],
      ),
      scoreBatchSize: jsonSerialization['scoreBatchSize'] as int,
      proposalBatchSize: jsonSerialization['proposalBatchSize'] as int,
      upworkSyncResultsPerPage:
          jsonSerialization['upworkSyncResultsPerPage'] as int,
      proposalMinimumScorePercentage:
          jsonSerialization['proposalMinimumScorePercentage'] as int,
      loopDelayMinutes: jsonSerialization['loopDelayMinutes'] as int,
      aiModel: _i3.JobAutomationAiModel.fromJson(
        (jsonSerialization['aiModel'] as String),
      ),
      aiThinkingEffort: _i4.JobAutomationAiThinkingEffort.fromJson(
        (jsonSerialization['aiThinkingEffort'] as String),
      ),
    );
  }

  _i2.JobFilter jobFilter;

  int scoreBatchSize;

  int proposalBatchSize;

  int upworkSyncResultsPerPage;

  int proposalMinimumScorePercentage;

  int loopDelayMinutes;

  _i3.JobAutomationAiModel aiModel;

  _i4.JobAutomationAiThinkingEffort aiThinkingEffort;

  /// Returns a shallow copy of this [JobAutomationSettingsUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAutomationSettingsUpdate copyWith({
    _i2.JobFilter? jobFilter,
    int? scoreBatchSize,
    int? proposalBatchSize,
    int? upworkSyncResultsPerPage,
    int? proposalMinimumScorePercentage,
    int? loopDelayMinutes,
    _i3.JobAutomationAiModel? aiModel,
    _i4.JobAutomationAiThinkingEffort? aiThinkingEffort,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAutomationSettingsUpdate',
      'jobFilter': jobFilter.toJson(),
      'scoreBatchSize': scoreBatchSize,
      'proposalBatchSize': proposalBatchSize,
      'upworkSyncResultsPerPage': upworkSyncResultsPerPage,
      'proposalMinimumScorePercentage': proposalMinimumScorePercentage,
      'loopDelayMinutes': loopDelayMinutes,
      'aiModel': aiModel.toJson(),
      'aiThinkingEffort': aiThinkingEffort.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobAutomationSettingsUpdate',
      'jobFilter': jobFilter.toJsonForProtocol(),
      'scoreBatchSize': scoreBatchSize,
      'proposalBatchSize': proposalBatchSize,
      'upworkSyncResultsPerPage': upworkSyncResultsPerPage,
      'proposalMinimumScorePercentage': proposalMinimumScorePercentage,
      'loopDelayMinutes': loopDelayMinutes,
      'aiModel': aiModel.toJson(),
      'aiThinkingEffort': aiThinkingEffort.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _JobAutomationSettingsUpdateImpl extends JobAutomationSettingsUpdate {
  _JobAutomationSettingsUpdateImpl({
    required _i2.JobFilter jobFilter,
    required int scoreBatchSize,
    required int proposalBatchSize,
    required int upworkSyncResultsPerPage,
    required int proposalMinimumScorePercentage,
    required int loopDelayMinutes,
    required _i3.JobAutomationAiModel aiModel,
    required _i4.JobAutomationAiThinkingEffort aiThinkingEffort,
  }) : super._(
         jobFilter: jobFilter,
         scoreBatchSize: scoreBatchSize,
         proposalBatchSize: proposalBatchSize,
         upworkSyncResultsPerPage: upworkSyncResultsPerPage,
         proposalMinimumScorePercentage: proposalMinimumScorePercentage,
         loopDelayMinutes: loopDelayMinutes,
         aiModel: aiModel,
         aiThinkingEffort: aiThinkingEffort,
       );

  /// Returns a shallow copy of this [JobAutomationSettingsUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAutomationSettingsUpdate copyWith({
    _i2.JobFilter? jobFilter,
    int? scoreBatchSize,
    int? proposalBatchSize,
    int? upworkSyncResultsPerPage,
    int? proposalMinimumScorePercentage,
    int? loopDelayMinutes,
    _i3.JobAutomationAiModel? aiModel,
    _i4.JobAutomationAiThinkingEffort? aiThinkingEffort,
  }) {
    return JobAutomationSettingsUpdate(
      jobFilter: jobFilter ?? this.jobFilter.copyWith(),
      scoreBatchSize: scoreBatchSize ?? this.scoreBatchSize,
      proposalBatchSize: proposalBatchSize ?? this.proposalBatchSize,
      upworkSyncResultsPerPage:
          upworkSyncResultsPerPage ?? this.upworkSyncResultsPerPage,
      proposalMinimumScorePercentage:
          proposalMinimumScorePercentage ?? this.proposalMinimumScorePercentage,
      loopDelayMinutes: loopDelayMinutes ?? this.loopDelayMinutes,
      aiModel: aiModel ?? this.aiModel,
      aiThinkingEffort: aiThinkingEffort ?? this.aiThinkingEffort,
    );
  }
}
