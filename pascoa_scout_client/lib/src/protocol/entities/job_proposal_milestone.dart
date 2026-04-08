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
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i3;

abstract class JobProposalMilestone implements _i1.SerializableModel {
  JobProposalMilestone._({
    this.id,
    required this.jobProposalId,
    this.jobProposal,
    required this.positionIndex,
    required this.title,
    required this.description,
    required this.suggestedPrice,
  });

  factory JobProposalMilestone({
    int? id,
    required int jobProposalId,
    _i2.JobProposal? jobProposal,
    required int positionIndex,
    required String title,
    required String description,
    required double suggestedPrice,
  }) = _JobProposalMilestoneImpl;

  factory JobProposalMilestone.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobProposalMilestone(
      id: jsonSerialization['id'] as int?,
      jobProposalId: jsonSerialization['jobProposalId'] as int,
      jobProposal: jsonSerialization['jobProposal'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.JobProposal>(
              jsonSerialization['jobProposal'],
            ),
      positionIndex: jsonSerialization['positionIndex'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      suggestedPrice: (jsonSerialization['suggestedPrice'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobProposalId;

  _i2.JobProposal? jobProposal;

  int positionIndex;

  String title;

  String description;

  double suggestedPrice;

  /// Returns a shallow copy of this [JobProposalMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobProposalMilestone copyWith({
    int? id,
    int? jobProposalId,
    _i2.JobProposal? jobProposal,
    int? positionIndex,
    String? title,
    String? description,
    double? suggestedPrice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobProposalMilestone',
      if (id != null) 'id': id,
      'jobProposalId': jobProposalId,
      if (jobProposal != null) 'jobProposal': jobProposal?.toJson(),
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

class _Undefined {}

class _JobProposalMilestoneImpl extends JobProposalMilestone {
  _JobProposalMilestoneImpl({
    int? id,
    required int jobProposalId,
    _i2.JobProposal? jobProposal,
    required int positionIndex,
    required String title,
    required String description,
    required double suggestedPrice,
  }) : super._(
         id: id,
         jobProposalId: jobProposalId,
         jobProposal: jobProposal,
         positionIndex: positionIndex,
         title: title,
         description: description,
         suggestedPrice: suggestedPrice,
       );

  /// Returns a shallow copy of this [JobProposalMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobProposalMilestone copyWith({
    Object? id = _Undefined,
    int? jobProposalId,
    Object? jobProposal = _Undefined,
    int? positionIndex,
    String? title,
    String? description,
    double? suggestedPrice,
  }) {
    return JobProposalMilestone(
      id: id is int? ? id : this.id,
      jobProposalId: jobProposalId ?? this.jobProposalId,
      jobProposal: jobProposal is _i2.JobProposal?
          ? jobProposal
          : this.jobProposal?.copyWith(),
      positionIndex: positionIndex ?? this.positionIndex,
      title: title ?? this.title,
      description: description ?? this.description,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
    );
  }
}
