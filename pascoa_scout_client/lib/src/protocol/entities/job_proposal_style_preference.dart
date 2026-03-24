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

abstract class JobProposalStylePreference implements _i1.SerializableModel {
  JobProposalStylePreference._({
    this.id,
    required this.singletonKey,
    required this.markdownText,
    required this.updatedAt,
  });

  factory JobProposalStylePreference({
    int? id,
    required String singletonKey,
    required String markdownText,
    required DateTime updatedAt,
  }) = _JobProposalStylePreferenceImpl;

  factory JobProposalStylePreference.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobProposalStylePreference(
      id: jsonSerialization['id'] as int?,
      singletonKey: jsonSerialization['singletonKey'] as String,
      markdownText: jsonSerialization['markdownText'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String singletonKey;

  String markdownText;

  DateTime updatedAt;

  /// Returns a shallow copy of this [JobProposalStylePreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobProposalStylePreference copyWith({
    int? id,
    String? singletonKey,
    String? markdownText,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobProposalStylePreference',
      if (id != null) 'id': id,
      'singletonKey': singletonKey,
      'markdownText': markdownText,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobProposalStylePreferenceImpl extends JobProposalStylePreference {
  _JobProposalStylePreferenceImpl({
    int? id,
    required String singletonKey,
    required String markdownText,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         singletonKey: singletonKey,
         markdownText: markdownText,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [JobProposalStylePreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobProposalStylePreference copyWith({
    Object? id = _Undefined,
    String? singletonKey,
    String? markdownText,
    DateTime? updatedAt,
  }) {
    return JobProposalStylePreference(
      id: id is int? ? id : this.id,
      singletonKey: singletonKey ?? this.singletonKey,
      markdownText: markdownText ?? this.markdownText,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
