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

abstract class ManualJobProposalMilestone implements _i1.SerializableModel {
  ManualJobProposalMilestone._({
    required this.positionIndex,
    required this.title,
    required this.description,
    required this.suggestedPrice,
  });

  factory ManualJobProposalMilestone({
    required int positionIndex,
    required String title,
    required String description,
    required double suggestedPrice,
  }) = _ManualJobProposalMilestoneImpl;

  factory ManualJobProposalMilestone.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ManualJobProposalMilestone(
      positionIndex: jsonSerialization['positionIndex'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      suggestedPrice: (jsonSerialization['suggestedPrice'] as num).toDouble(),
    );
  }

  int positionIndex;

  String title;

  String description;

  double suggestedPrice;

  /// Returns a shallow copy of this [ManualJobProposalMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ManualJobProposalMilestone copyWith({
    int? positionIndex,
    String? title,
    String? description,
    double? suggestedPrice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManualJobProposalMilestone',
      'positionIndex': positionIndex,
      'title': title,
      'description': description,
      'suggestedPrice': suggestedPrice,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ManualJobProposalMilestoneImpl extends ManualJobProposalMilestone {
  _ManualJobProposalMilestoneImpl({
    required int positionIndex,
    required String title,
    required String description,
    required double suggestedPrice,
  }) : super._(
         positionIndex: positionIndex,
         title: title,
         description: description,
         suggestedPrice: suggestedPrice,
       );

  /// Returns a shallow copy of this [ManualJobProposalMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ManualJobProposalMilestone copyWith({
    int? positionIndex,
    String? title,
    String? description,
    double? suggestedPrice,
  }) {
    return ManualJobProposalMilestone(
      positionIndex: positionIndex ?? this.positionIndex,
      title: title ?? this.title,
      description: description ?? this.description,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
    );
  }
}
