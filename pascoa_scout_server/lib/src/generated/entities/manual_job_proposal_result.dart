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
import 'package:serverpod/serverpod.dart' as _i1;
import '../entities/manual_job_proposal_milestone.dart' as _i2;
import 'package:pascoa_scout_server/src/generated/protocol.dart' as _i3;

abstract class ManualJobProposalResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ManualJobProposalResult._({
    required this.aiGeneratedCoverLetterText,
    this.milestones,
  });

  factory ManualJobProposalResult({
    required String aiGeneratedCoverLetterText,
    List<_i2.ManualJobProposalMilestone>? milestones,
  }) = _ManualJobProposalResultImpl;

  factory ManualJobProposalResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ManualJobProposalResult(
      aiGeneratedCoverLetterText:
          jsonSerialization['aiGeneratedCoverLetterText'] as String,
      milestones: jsonSerialization['milestones'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.ManualJobProposalMilestone>>(
              jsonSerialization['milestones'],
            ),
    );
  }

  String aiGeneratedCoverLetterText;

  List<_i2.ManualJobProposalMilestone>? milestones;

  /// Returns a shallow copy of this [ManualJobProposalResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ManualJobProposalResult copyWith({
    String? aiGeneratedCoverLetterText,
    List<_i2.ManualJobProposalMilestone>? milestones,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManualJobProposalResult',
      'aiGeneratedCoverLetterText': aiGeneratedCoverLetterText,
      if (milestones != null)
        'milestones': milestones?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ManualJobProposalResult',
      'aiGeneratedCoverLetterText': aiGeneratedCoverLetterText,
      if (milestones != null)
        'milestones': milestones?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ManualJobProposalResultImpl extends ManualJobProposalResult {
  _ManualJobProposalResultImpl({
    required String aiGeneratedCoverLetterText,
    List<_i2.ManualJobProposalMilestone>? milestones,
  }) : super._(
         aiGeneratedCoverLetterText: aiGeneratedCoverLetterText,
         milestones: milestones,
       );

  /// Returns a shallow copy of this [ManualJobProposalResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ManualJobProposalResult copyWith({
    String? aiGeneratedCoverLetterText,
    Object? milestones = _Undefined,
  }) {
    return ManualJobProposalResult(
      aiGeneratedCoverLetterText:
          aiGeneratedCoverLetterText ?? this.aiGeneratedCoverLetterText,
      milestones: milestones is List<_i2.ManualJobProposalMilestone>?
          ? milestones
          : this.milestones?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
