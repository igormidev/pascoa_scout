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

abstract class JobKnowledgeDraft implements _i1.SerializableModel {
  JobKnowledgeDraft._({
    this.curriculumMarkdownText,
    this.proposalStyleMarkdownText,
    this.opportunityPreferenceMarkdownText,
  });

  factory JobKnowledgeDraft({
    String? curriculumMarkdownText,
    String? proposalStyleMarkdownText,
    String? opportunityPreferenceMarkdownText,
  }) = _JobKnowledgeDraftImpl;

  factory JobKnowledgeDraft.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobKnowledgeDraft(
      curriculumMarkdownText:
          jsonSerialization['curriculumMarkdownText'] as String?,
      proposalStyleMarkdownText:
          jsonSerialization['proposalStyleMarkdownText'] as String?,
      opportunityPreferenceMarkdownText:
          jsonSerialization['opportunityPreferenceMarkdownText'] as String?,
    );
  }

  String? curriculumMarkdownText;

  String? proposalStyleMarkdownText;

  String? opportunityPreferenceMarkdownText;

  /// Returns a shallow copy of this [JobKnowledgeDraft]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobKnowledgeDraft copyWith({
    String? curriculumMarkdownText,
    String? proposalStyleMarkdownText,
    String? opportunityPreferenceMarkdownText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobKnowledgeDraft',
      if (curriculumMarkdownText != null)
        'curriculumMarkdownText': curriculumMarkdownText,
      if (proposalStyleMarkdownText != null)
        'proposalStyleMarkdownText': proposalStyleMarkdownText,
      if (opportunityPreferenceMarkdownText != null)
        'opportunityPreferenceMarkdownText': opportunityPreferenceMarkdownText,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobKnowledgeDraftImpl extends JobKnowledgeDraft {
  _JobKnowledgeDraftImpl({
    String? curriculumMarkdownText,
    String? proposalStyleMarkdownText,
    String? opportunityPreferenceMarkdownText,
  }) : super._(
         curriculumMarkdownText: curriculumMarkdownText,
         proposalStyleMarkdownText: proposalStyleMarkdownText,
         opportunityPreferenceMarkdownText: opportunityPreferenceMarkdownText,
       );

  /// Returns a shallow copy of this [JobKnowledgeDraft]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobKnowledgeDraft copyWith({
    Object? curriculumMarkdownText = _Undefined,
    Object? proposalStyleMarkdownText = _Undefined,
    Object? opportunityPreferenceMarkdownText = _Undefined,
  }) {
    return JobKnowledgeDraft(
      curriculumMarkdownText: curriculumMarkdownText is String?
          ? curriculumMarkdownText
          : this.curriculumMarkdownText,
      proposalStyleMarkdownText: proposalStyleMarkdownText is String?
          ? proposalStyleMarkdownText
          : this.proposalStyleMarkdownText,
      opportunityPreferenceMarkdownText:
          opportunityPreferenceMarkdownText is String?
          ? opportunityPreferenceMarkdownText
          : this.opportunityPreferenceMarkdownText,
    );
  }
}
