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
import '../entities/others/pagination_metadata.dart' as _i3;
import 'package:pascoa_scout_client/src/protocol/protocol.dart' as _i4;

abstract class JobAnalysisPagination implements _i1.SerializableModel {
  JobAnalysisPagination._({
    required this.items,
    required this.paginationMetadata,
  });

  factory JobAnalysisPagination({
    required List<_i2.JobAnalysisState> items,
    required _i3.PaginationMetadata paginationMetadata,
  }) = _JobAnalysisPaginationImpl;

  factory JobAnalysisPagination.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return JobAnalysisPagination(
      items: _i4.Protocol().deserialize<List<_i2.JobAnalysisState>>(
        jsonSerialization['items'],
      ),
      paginationMetadata: _i4.Protocol().deserialize<_i3.PaginationMetadata>(
        jsonSerialization['paginationMetadata'],
      ),
    );
  }

  List<_i2.JobAnalysisState> items;

  _i3.PaginationMetadata paginationMetadata;

  /// Returns a shallow copy of this [JobAnalysisPagination]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JobAnalysisPagination copyWith({
    List<_i2.JobAnalysisState>? items,
    _i3.PaginationMetadata? paginationMetadata,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobAnalysisPagination',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'paginationMetadata': paginationMetadata.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _JobAnalysisPaginationImpl extends JobAnalysisPagination {
  _JobAnalysisPaginationImpl({
    required List<_i2.JobAnalysisState> items,
    required _i3.PaginationMetadata paginationMetadata,
  }) : super._(
         items: items,
         paginationMetadata: paginationMetadata,
       );

  /// Returns a shallow copy of this [JobAnalysisPagination]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JobAnalysisPagination copyWith({
    List<_i2.JobAnalysisState>? items,
    _i3.PaginationMetadata? paginationMetadata,
  }) {
    return JobAnalysisPagination(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      paginationMetadata:
          paginationMetadata ?? this.paginationMetadata.copyWith(),
    );
  }
}
