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
import '../entities/job_analysis_state.dart' as _i2;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i3;

abstract class JobScore implements _i1.SerializableModel {
  JobScore._({
    this.id,
    required this.jobAnalysisStateId,
    this.jobAnalysisState,
    required this.scorePercentage,
    required this.aiScoreJustificationText,
  });

  factory JobScore({
    int? id,
    required int jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    required int scorePercentage,
    required String aiScoreJustificationText,
  }) = _JobScoreImpl;

  factory JobScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobScore(
      id: jsonSerialization['id'] as int?,
      jobAnalysisStateId: jsonSerialization['jobAnalysisStateId'] as int,
      jobAnalysisState: jsonSerialization['jobAnalysisState'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.JobAnalysisState>(
              jsonSerialization['jobAnalysisState'],
            ),
      scorePercentage: jsonSerialization['scorePercentage'] as int,
      aiScoreJustificationText:
          jsonSerialization['aiScoreJustificationText'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobAnalysisStateId;

  _i2.JobAnalysisState? jobAnalysisState;

  int scorePercentage;

  String aiScoreJustificationText;

  /// Returns a shallow copy of this [JobScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobScore copyWith({
    int? id,
    int? jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    int? scorePercentage,
    String? aiScoreJustificationText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobScore',
      if (id != null) 'id': id,
      'jobAnalysisStateId': jobAnalysisStateId,
      if (jobAnalysisState != null)
        'jobAnalysisState': jobAnalysisState?.toJson(),
      'scorePercentage': scorePercentage,
      'aiScoreJustificationText': aiScoreJustificationText,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobScoreImpl extends JobScore {
  _JobScoreImpl({
    int? id,
    required int jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    required int scorePercentage,
    required String aiScoreJustificationText,
  }) : super._(
         id: id,
         jobAnalysisStateId: jobAnalysisStateId,
         jobAnalysisState: jobAnalysisState,
         scorePercentage: scorePercentage,
         aiScoreJustificationText: aiScoreJustificationText,
       );

  /// Returns a shallow copy of this [JobScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobScore copyWith({
    Object? id = _Undefined,
    int? jobAnalysisStateId,
    Object? jobAnalysisState = _Undefined,
    int? scorePercentage,
    String? aiScoreJustificationText,
  }) {
    return JobScore(
      id: id is int? ? id : this.id,
      jobAnalysisStateId: jobAnalysisStateId ?? this.jobAnalysisStateId,
      jobAnalysisState: jobAnalysisState is _i2.JobAnalysisState?
          ? jobAnalysisState
          : this.jobAnalysisState?.copyWith(),
      scorePercentage: scorePercentage ?? this.scorePercentage,
      aiScoreJustificationText:
          aiScoreJustificationText ?? this.aiScoreJustificationText,
    );
  }
}
