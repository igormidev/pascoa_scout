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
import '../entities/job_proposal.dart' as _i2;
import '../entities/upwork_scrap/question.dart' as _i3;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i4;

abstract class JobProposalAnswerToQuestion implements _i1.SerializableModel {
  JobProposalAnswerToQuestion._({
    this.id,
    required this.jobProposalId,
    this.jobProposal,
    required this.relatedQuestionId,
    this.relatedQuestion,
    required this.aiGeneratedAnswerText,
  });

  factory JobProposalAnswerToQuestion({
    int? id,
    required int jobProposalId,
    _i2.JobProposal? jobProposal,
    required int relatedQuestionId,
    _i3.Question? relatedQuestion,
    required String aiGeneratedAnswerText,
  }) = _JobProposalAnswerToQuestionImpl;

  factory JobProposalAnswerToQuestion.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobProposalAnswerToQuestion(
      id: jsonSerialization['id'] as int?,
      jobProposalId: jsonSerialization['jobProposalId'] as int,
      jobProposal: jsonSerialization['jobProposal'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.JobProposal>(
              jsonSerialization['jobProposal'],
            ),
      relatedQuestionId: jsonSerialization['relatedQuestionId'] as int,
      relatedQuestion: jsonSerialization['relatedQuestion'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Question>(
              jsonSerialization['relatedQuestion'],
            ),
      aiGeneratedAnswerText:
          jsonSerialization['aiGeneratedAnswerText'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobProposalId;

  _i2.JobProposal? jobProposal;

  int relatedQuestionId;

  _i3.Question? relatedQuestion;

  String aiGeneratedAnswerText;

  /// Returns a shallow copy of this [JobProposalAnswerToQuestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobProposalAnswerToQuestion copyWith({
    int? id,
    int? jobProposalId,
    _i2.JobProposal? jobProposal,
    int? relatedQuestionId,
    _i3.Question? relatedQuestion,
    String? aiGeneratedAnswerText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobProposalAnswerToQuestion',
      if (id != null) 'id': id,
      'jobProposalId': jobProposalId,
      if (jobProposal != null) 'jobProposal': jobProposal?.toJson(),
      'relatedQuestionId': relatedQuestionId,
      if (relatedQuestion != null) 'relatedQuestion': relatedQuestion?.toJson(),
      'aiGeneratedAnswerText': aiGeneratedAnswerText,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobProposalAnswerToQuestionImpl extends JobProposalAnswerToQuestion {
  _JobProposalAnswerToQuestionImpl({
    int? id,
    required int jobProposalId,
    _i2.JobProposal? jobProposal,
    required int relatedQuestionId,
    _i3.Question? relatedQuestion,
    required String aiGeneratedAnswerText,
  }) : super._(
         id: id,
         jobProposalId: jobProposalId,
         jobProposal: jobProposal,
         relatedQuestionId: relatedQuestionId,
         relatedQuestion: relatedQuestion,
         aiGeneratedAnswerText: aiGeneratedAnswerText,
       );

  /// Returns a shallow copy of this [JobProposalAnswerToQuestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobProposalAnswerToQuestion copyWith({
    Object? id = _Undefined,
    int? jobProposalId,
    Object? jobProposal = _Undefined,
    int? relatedQuestionId,
    Object? relatedQuestion = _Undefined,
    String? aiGeneratedAnswerText,
  }) {
    return JobProposalAnswerToQuestion(
      id: id is int? ? id : this.id,
      jobProposalId: jobProposalId ?? this.jobProposalId,
      jobProposal: jobProposal is _i2.JobProposal?
          ? jobProposal
          : this.jobProposal?.copyWith(),
      relatedQuestionId: relatedQuestionId ?? this.relatedQuestionId,
      relatedQuestion: relatedQuestion is _i3.Question?
          ? relatedQuestion
          : this.relatedQuestion?.copyWith(),
      aiGeneratedAnswerText:
          aiGeneratedAnswerText ?? this.aiGeneratedAnswerText,
    );
  }
}
