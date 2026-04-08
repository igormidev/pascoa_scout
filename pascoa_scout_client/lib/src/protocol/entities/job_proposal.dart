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
import '../entities/job_proposal_answer_to_question.dart' as _i3;
import '../entities/job_proposal_milestone.dart' as _i4;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i5;

abstract class JobProposal implements _i1.SerializableModel {
  JobProposal._({
    this.id,
    required this.jobAnalysisStateId,
    this.jobAnalysisState,
    required this.aiGeneratedCoverLetterText,
    this.answers,
    this.milestones,
  });

  factory JobProposal({
    int? id,
    required int jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    required String aiGeneratedCoverLetterText,
    List<_i3.JobProposalAnswerToQuestion>? answers,
    List<_i4.JobProposalMilestone>? milestones,
  }) = _JobProposalImpl;

  factory JobProposal.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobProposal(
      id: jsonSerialization['id'] as int?,
      jobAnalysisStateId: jsonSerialization['jobAnalysisStateId'] as int,
      jobAnalysisState: jsonSerialization['jobAnalysisState'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.JobAnalysisState>(
              jsonSerialization['jobAnalysisState'],
            ),
      aiGeneratedCoverLetterText:
          jsonSerialization['aiGeneratedCoverLetterText'] as String,
      answers: jsonSerialization['answers'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i3.JobProposalAnswerToQuestion>>(
              jsonSerialization['answers'],
            ),
      milestones: jsonSerialization['milestones'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.JobProposalMilestone>>(
              jsonSerialization['milestones'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobAnalysisStateId;

  _i2.JobAnalysisState? jobAnalysisState;

  String aiGeneratedCoverLetterText;

  List<_i3.JobProposalAnswerToQuestion>? answers;

  List<_i4.JobProposalMilestone>? milestones;

  /// Returns a shallow copy of this [JobProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobProposal copyWith({
    int? id,
    int? jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    String? aiGeneratedCoverLetterText,
    List<_i3.JobProposalAnswerToQuestion>? answers,
    List<_i4.JobProposalMilestone>? milestones,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobProposal',
      if (id != null) 'id': id,
      'jobAnalysisStateId': jobAnalysisStateId,
      if (jobAnalysisState != null)
        'jobAnalysisState': jobAnalysisState?.toJson(),
      'aiGeneratedCoverLetterText': aiGeneratedCoverLetterText,
      if (answers != null)
        'answers': answers?.toJson(valueToJson: (v) => v.toJson()),
      if (milestones != null)
        'milestones': milestones?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobProposalImpl extends JobProposal {
  _JobProposalImpl({
    int? id,
    required int jobAnalysisStateId,
    _i2.JobAnalysisState? jobAnalysisState,
    required String aiGeneratedCoverLetterText,
    List<_i3.JobProposalAnswerToQuestion>? answers,
    List<_i4.JobProposalMilestone>? milestones,
  }) : super._(
         id: id,
         jobAnalysisStateId: jobAnalysisStateId,
         jobAnalysisState: jobAnalysisState,
         aiGeneratedCoverLetterText: aiGeneratedCoverLetterText,
         answers: answers,
         milestones: milestones,
       );

  /// Returns a shallow copy of this [JobProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobProposal copyWith({
    Object? id = _Undefined,
    int? jobAnalysisStateId,
    Object? jobAnalysisState = _Undefined,
    String? aiGeneratedCoverLetterText,
    Object? answers = _Undefined,
    Object? milestones = _Undefined,
  }) {
    return JobProposal(
      id: id is int? ? id : this.id,
      jobAnalysisStateId: jobAnalysisStateId ?? this.jobAnalysisStateId,
      jobAnalysisState: jobAnalysisState is _i2.JobAnalysisState?
          ? jobAnalysisState
          : this.jobAnalysisState?.copyWith(),
      aiGeneratedCoverLetterText:
          aiGeneratedCoverLetterText ?? this.aiGeneratedCoverLetterText,
      answers: answers is List<_i3.JobProposalAnswerToQuestion>?
          ? answers
          : this.answers?.map((e0) => e0.copyWith()).toList(),
      milestones: milestones is List<_i4.JobProposalMilestone>?
          ? milestones
          : this.milestones?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
