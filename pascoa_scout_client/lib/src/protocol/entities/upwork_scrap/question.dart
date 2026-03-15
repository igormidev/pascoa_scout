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

abstract class Question implements _i1.SerializableModel {
  Question._({
    required this.question,
    required this.positionIndex,
  });

  factory Question({
    required String question,
    required int positionIndex,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      question: jsonSerialization['question'] as String,
      positionIndex: jsonSerialization['positionIndex'] as int,
    );
  }

  String question;

  int positionIndex;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Question copyWith({
    String? question,
    int? positionIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      'question': question,
      'positionIndex': positionIndex,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuestionImpl extends Question {
  _QuestionImpl({
    required String question,
    required int positionIndex,
  }) : super._(
         question: question,
         positionIndex: positionIndex,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Question copyWith({
    String? question,
    int? positionIndex,
  }) {
    return Question(
      question: question ?? this.question,
      positionIndex: positionIndex ?? this.positionIndex,
    );
  }
}
