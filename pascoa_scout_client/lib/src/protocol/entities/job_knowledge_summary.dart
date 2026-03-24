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

abstract class JobKnowledgeSummary implements _i1.SerializableModel {
  JobKnowledgeSummary._({
    required this.hasCurriculum,
    required this.hasProposalStylePreference,
    required this.hasOpportunityPreference,
  });

  factory JobKnowledgeSummary({
    required bool hasCurriculum,
    required bool hasProposalStylePreference,
    required bool hasOpportunityPreference,
  }) = _JobKnowledgeSummaryImpl;

  factory JobKnowledgeSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobKnowledgeSummary(
      hasCurriculum: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['hasCurriculum'],
      ),
      hasProposalStylePreference: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['hasProposalStylePreference'],
      ),
      hasOpportunityPreference: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['hasOpportunityPreference'],
      ),
    );
  }

  bool hasCurriculum;

  bool hasProposalStylePreference;

  bool hasOpportunityPreference;

  /// Returns a shallow copy of this [JobKnowledgeSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobKnowledgeSummary copyWith({
    bool? hasCurriculum,
    bool? hasProposalStylePreference,
    bool? hasOpportunityPreference,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobKnowledgeSummary',
      'hasCurriculum': hasCurriculum,
      'hasProposalStylePreference': hasProposalStylePreference,
      'hasOpportunityPreference': hasOpportunityPreference,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _JobKnowledgeSummaryImpl extends JobKnowledgeSummary {
  _JobKnowledgeSummaryImpl({
    required bool hasCurriculum,
    required bool hasProposalStylePreference,
    required bool hasOpportunityPreference,
  }) : super._(
         hasCurriculum: hasCurriculum,
         hasProposalStylePreference: hasProposalStylePreference,
         hasOpportunityPreference: hasOpportunityPreference,
       );

  /// Returns a shallow copy of this [JobKnowledgeSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobKnowledgeSummary copyWith({
    bool? hasCurriculum,
    bool? hasProposalStylePreference,
    bool? hasOpportunityPreference,
  }) {
    return JobKnowledgeSummary(
      hasCurriculum: hasCurriculum ?? this.hasCurriculum,
      hasProposalStylePreference:
          hasProposalStylePreference ?? this.hasProposalStylePreference,
      hasOpportunityPreference:
          hasOpportunityPreference ?? this.hasOpportunityPreference,
    );
  }
}
