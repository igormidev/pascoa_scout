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
import '../../entities/upwork_scrap/job_info.dart' as _i2;
import '../../entities/job_proposal_answer_to_question.dart' as _i3;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i4;

abstract class Question implements _i1.SerializableModel {
  Question._({
    this.id,
    required this.question,
    required this.positionIndex,
    this.jobInfoId,
    this.jobInfo,
    this.proposalAnswer,
  });

  factory Question({
    int? id,
    required String question,
    required int positionIndex,
    int? jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobProposalAnswerToQuestion? proposalAnswer,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      question: jsonSerialization['question'] as String,
      positionIndex: jsonSerialization['positionIndex'] as int,
      jobInfoId: jsonSerialization['jobInfoId'] as int?,
      jobInfo: jsonSerialization['jobInfo'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.JobInfo>(
              jsonSerialization['jobInfo'],
            ),
      proposalAnswer: jsonSerialization['proposalAnswer'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.JobProposalAnswerToQuestion>(
              jsonSerialization['proposalAnswer'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String question;

  int positionIndex;

  int? jobInfoId;

  _i2.JobInfo? jobInfo;

  _i3.JobProposalAnswerToQuestion? proposalAnswer;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Question copyWith({
    int? id,
    String? question,
    int? positionIndex,
    int? jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobProposalAnswerToQuestion? proposalAnswer,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'question': question,
      'positionIndex': positionIndex,
      if (jobInfoId != null) 'jobInfoId': jobInfoId,
      if (jobInfo != null) 'jobInfo': jobInfo?.toJson(),
      if (proposalAnswer != null) 'proposalAnswer': proposalAnswer?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required String question,
    required int positionIndex,
    int? jobInfoId,
    _i2.JobInfo? jobInfo,
    _i3.JobProposalAnswerToQuestion? proposalAnswer,
  }) : super._(
         id: id,
         question: question,
         positionIndex: positionIndex,
         jobInfoId: jobInfoId,
         jobInfo: jobInfo,
         proposalAnswer: proposalAnswer,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    String? question,
    int? positionIndex,
    Object? jobInfoId = _Undefined,
    Object? jobInfo = _Undefined,
    Object? proposalAnswer = _Undefined,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      question: question ?? this.question,
      positionIndex: positionIndex ?? this.positionIndex,
      jobInfoId: jobInfoId is int? ? jobInfoId : this.jobInfoId,
      jobInfo: jobInfo is _i2.JobInfo? ? jobInfo : this.jobInfo?.copyWith(),
      proposalAnswer: proposalAnswer is _i3.JobProposalAnswerToQuestion?
          ? proposalAnswer
          : this.proposalAnswer?.copyWith(),
    );
  }
}
