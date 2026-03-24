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
import '../entities/upwork_scrap/job_filter.dart' as _i2;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i3;

abstract class JobAutomationSettingsUpdate implements _i1.SerializableModel {
  JobAutomationSettingsUpdate._({
    required this.jobFilter,
    required this.scoreBatchSize,
    required this.proposalBatchSize,
    required this.upworkSyncResultsPerPage,
    required this.proposalMinimumScorePercentage,
    required this.loopDelayMinutes,
  });

  factory JobAutomationSettingsUpdate({
    required _i2.JobFilter jobFilter,
    required int scoreBatchSize,
    required int proposalBatchSize,
    required int upworkSyncResultsPerPage,
    required int proposalMinimumScorePercentage,
    required int loopDelayMinutes,
  }) = _JobAutomationSettingsUpdateImpl;

  factory JobAutomationSettingsUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAutomationSettingsUpdate(
      jobFilter: _i3.Protocol().deserialize<_i2.JobFilter>(
        jsonSerialization['jobFilter'],
      ),
      scoreBatchSize: jsonSerialization['scoreBatchSize'] as int,
      proposalBatchSize: jsonSerialization['proposalBatchSize'] as int,
      upworkSyncResultsPerPage:
          jsonSerialization['upworkSyncResultsPerPage'] as int,
      proposalMinimumScorePercentage:
          jsonSerialization['proposalMinimumScorePercentage'] as int,
      loopDelayMinutes: jsonSerialization['loopDelayMinutes'] as int,
    );
  }

  _i2.JobFilter jobFilter;

  int scoreBatchSize;

  int proposalBatchSize;

  int upworkSyncResultsPerPage;

  int proposalMinimumScorePercentage;

  int loopDelayMinutes;

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
  }) : super._(
         jobFilter: jobFilter,
         scoreBatchSize: scoreBatchSize,
         proposalBatchSize: proposalBatchSize,
         upworkSyncResultsPerPage: upworkSyncResultsPerPage,
         proposalMinimumScorePercentage: proposalMinimumScorePercentage,
         loopDelayMinutes: loopDelayMinutes,
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
    );
  }
}
