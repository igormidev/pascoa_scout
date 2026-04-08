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
import '../entities/upwork_scrap/job_info.dart' as _i2;
import '../entities/job_score.dart' as _i3;
import '../entities/job_proposal.dart' as _i4;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i5;

abstract class JobAnalysisState implements _i1.SerializableModel {
  JobAnalysisState._({
    this.id,
    required this.jobInfoId,
    this.jobInfo,
    this.score,
    this.proposal,
    bool? didViewJob,
    required this.createdJobInfoAt,
    this.createdJobScoringAt,
    this.createdJobAiResponsesAt,
  }) : didViewJob = didViewJob ?? false;

  factory JobAnalysisState({
    int? id,
    required int jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobScore? score,
    _i4.JobProposal? proposal,
    bool? didViewJob,
    required DateTime createdJobInfoAt,
    DateTime? createdJobScoringAt,
    DateTime? createdJobAiResponsesAt,
  }) = _JobAnalysisStateImpl;

  factory JobAnalysisState.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobAnalysisState(
      id: jsonSerialization['id'] as int?,
      jobInfoId: jsonSerialization['jobInfoId'] as int,
      jobInfo: jsonSerialization['jobInfo'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.JobInfo>(
              jsonSerialization['jobInfo'],
            ),
      score: jsonSerialization['score'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.JobScore>(
              jsonSerialization['score'],
            ),
      proposal: jsonSerialization['proposal'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.JobProposal>(
              jsonSerialization['proposal'],
            ),
      didViewJob: jsonSerialization['didViewJob'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['didViewJob']),
      createdJobInfoAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdJobInfoAt'],
      ),
      createdJobScoringAt: jsonSerialization['createdJobScoringAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['createdJobScoringAt'],
            ),
      createdJobAiResponsesAt:
          jsonSerialization['createdJobAiResponsesAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['createdJobAiResponsesAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobInfoId;

  _i2.JobInfo? jobInfo;

  _i3.JobScore? score;

  _i4.JobProposal? proposal;

  bool didViewJob;

  DateTime createdJobInfoAt;

  DateTime? createdJobScoringAt;

  DateTime? createdJobAiResponsesAt;

  /// Returns a shallow copy of this [JobAnalysisState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAnalysisState copyWith({
    int? id,
    int? jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobScore? score,
    _i4.JobProposal? proposal,
    bool? didViewJob,
    DateTime? createdJobInfoAt,
    DateTime? createdJobScoringAt,
    DateTime? createdJobAiResponsesAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAnalysisState',
      if (id != null) 'id': id,
      'jobInfoId': jobInfoId,
      if (jobInfo != null) 'jobInfo': jobInfo?.toJson(),
      if (score != null) 'score': score?.toJson(),
      if (proposal != null) 'proposal': proposal?.toJson(),
      'didViewJob': didViewJob,
      'createdJobInfoAt': createdJobInfoAt.toJson(),
      if (createdJobScoringAt != null)
        'createdJobScoringAt': createdJobScoringAt?.toJson(),
      if (createdJobAiResponsesAt != null)
        'createdJobAiResponsesAt': createdJobAiResponsesAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobAnalysisStateImpl extends JobAnalysisState {
  _JobAnalysisStateImpl({
    int? id,
    required int jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobScore? score,
    _i4.JobProposal? proposal,
    bool? didViewJob,
    required DateTime createdJobInfoAt,
    DateTime? createdJobScoringAt,
    DateTime? createdJobAiResponsesAt,
  }) : super._(
         id: id,
         jobInfoId: jobInfoId,
         jobInfo: jobInfo,
         score: score,
         proposal: proposal,
         didViewJob: didViewJob,
         createdJobInfoAt: createdJobInfoAt,
         createdJobScoringAt: createdJobScoringAt,
         createdJobAiResponsesAt: createdJobAiResponsesAt,
       );

  /// Returns a shallow copy of this [JobAnalysisState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAnalysisState copyWith({
    Object? id = _Undefined,
    int? jobInfoId,
    Object? jobInfo = _Undefined,
    Object? score = _Undefined,
    Object? proposal = _Undefined,
    bool? didViewJob,
    DateTime? createdJobInfoAt,
    Object? createdJobScoringAt = _Undefined,
    Object? createdJobAiResponsesAt = _Undefined,
  }) {
    return JobAnalysisState(
      id: id is int? ? id : this.id,
      jobInfoId: jobInfoId ?? this.jobInfoId,
      jobInfo: jobInfo is _i2.JobInfo? ? jobInfo : this.jobInfo?.copyWith(),
      score: score is _i3.JobScore? ? score : this.score?.copyWith(),
      proposal: proposal is _i4.JobProposal?
          ? proposal
          : this.proposal?.copyWith(),
      didViewJob: didViewJob ?? this.didViewJob,
      createdJobInfoAt: createdJobInfoAt ?? this.createdJobInfoAt,
      createdJobScoringAt: createdJobScoringAt is DateTime?
          ? createdJobScoringAt
          : this.createdJobScoringAt,
      createdJobAiResponsesAt: createdJobAiResponsesAt is DateTime?
          ? createdJobAiResponsesAt
          : this.createdJobAiResponsesAt,
    );
  }
}
