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

abstract class JobAutomationSettings implements _i1.SerializableModel {
  JobAutomationSettings._({
    this.id,
    required this.singletonKey,
    required this.jobFilter,
    required this.isJobFetchingPaused,
    required this.scoreBatchSize,
    required this.proposalBatchSize,
    required this.upworkSyncResultsPerPage,
    required this.proposalMinimumScorePercentage,
    required this.loopDelayMinutes,
    required this.updatedAt,
  });

  factory JobAutomationSettings({
    int? id,
    required String singletonKey,
    required _i2.JobFilter jobFilter,
    required bool isJobFetchingPaused,
    required int scoreBatchSize,
    required int proposalBatchSize,
    required int upworkSyncResultsPerPage,
    required int proposalMinimumScorePercentage,
    required int loopDelayMinutes,
    required DateTime updatedAt,
  }) = _JobAutomationSettingsImpl;

  factory JobAutomationSettings.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAutomationSettings(
      id: jsonSerialization['id'] as int?,
      singletonKey: jsonSerialization['singletonKey'] as String,
      jobFilter: _i3.Protocol().deserialize<_i2.JobFilter>(
        jsonSerialization['jobFilter'],
      ),
      isJobFetchingPaused: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isJobFetchingPaused'],
      ),
      scoreBatchSize: jsonSerialization['scoreBatchSize'] as int,
      proposalBatchSize: jsonSerialization['proposalBatchSize'] as int,
      upworkSyncResultsPerPage:
          jsonSerialization['upworkSyncResultsPerPage'] as int,
      proposalMinimumScorePercentage:
          jsonSerialization['proposalMinimumScorePercentage'] as int,
      loopDelayMinutes: jsonSerialization['loopDelayMinutes'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String singletonKey;

  _i2.JobFilter jobFilter;

  bool isJobFetchingPaused;

  int scoreBatchSize;

  int proposalBatchSize;

  int upworkSyncResultsPerPage;

  int proposalMinimumScorePercentage;

  int loopDelayMinutes;

  DateTime updatedAt;

  /// Returns a shallow copy of this [JobAutomationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAutomationSettings copyWith({
    int? id,
    String? singletonKey,
    _i2.JobFilter? jobFilter,
    bool? isJobFetchingPaused,
    int? scoreBatchSize,
    int? proposalBatchSize,
    int? upworkSyncResultsPerPage,
    int? proposalMinimumScorePercentage,
    int? loopDelayMinutes,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAutomationSettings',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'jobFilter': jobFilter.toJson(),
      'isJobFetchingPaused': isJobFetchingPaused,
      'scoreBatchSize': scoreBatchSize,
      'proposalBatchSize': proposalBatchSize,
      'upworkSyncResultsPerPage': upworkSyncResultsPerPage,
      'proposalMinimumScorePercentage': proposalMinimumScorePercentage,
      'loopDelayMinutes': loopDelayMinutes,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAutomationSettingsImpl extends JobAutomationSettings {
  _JobAutomationSettingsImpl({
    int? id,
    required String singletonKey,
    required _i2.JobFilter jobFilter,
    required bool isJobFetchingPaused,
    required int scoreBatchSize,
    required int proposalBatchSize,
    required int upworkSyncResultsPerPage,
    required int proposalMinimumScorePercentage,
    required int loopDelayMinutes,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         singletonKey: singletonKey,
         jobFilter: jobFilter,
         isJobFetchingPaused: isJobFetchingPaused,
         scoreBatchSize: scoreBatchSize,
         proposalBatchSize: proposalBatchSize,
         upworkSyncResultsPerPage: upworkSyncResultsPerPage,
         proposalMinimumScorePercentage: proposalMinimumScorePercentage,
         loopDelayMinutes: loopDelayMinutes,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [JobAutomationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAutomationSettings copyWith({
    Object? id = _Undefined,
    String? singletonKey,
    _i2.JobFilter? jobFilter,
    bool? isJobFetchingPaused,
    int? scoreBatchSize,
    int? proposalBatchSize,
    int? upworkSyncResultsPerPage,
    int? proposalMinimumScorePercentage,
    int? loopDelayMinutes,
    DateTime? updatedAt,
  }) {
    return JobAutomationSettings(
      id: id is int? ? id : this.id,
      singletonKey: singletonKey ?? this.singletonKey,
      jobFilter: jobFilter ?? this.jobFilter.copyWith(),
      isJobFetchingPaused: isJobFetchingPaused ?? this.isJobFetchingPaused,
      scoreBatchSize: scoreBatchSize ?? this.scoreBatchSize,
      proposalBatchSize: proposalBatchSize ?? this.proposalBatchSize,
      upworkSyncResultsPerPage:
          upworkSyncResultsPerPage ?? this.upworkSyncResultsPerPage,
      proposalMinimumScorePercentage:
          proposalMinimumScorePercentage ?? this.proposalMinimumScorePercentage,
      loopDelayMinutes: loopDelayMinutes ?? this.loopDelayMinutes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
