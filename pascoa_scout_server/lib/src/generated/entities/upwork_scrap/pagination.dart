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
import '../../entities/upwork_scrap/search_sort_order.dart' as _i2;

abstract class Pagination
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Pagination._({
    required this.pageNumber,
    required this.pagesToScrape,
    required this.resultsPerPage,
    required this.searchSortOrder,
  });

  factory Pagination({
    required int pageNumber,
    required int pagesToScrape,
    required int resultsPerPage,
    required _i2.SearchSortOrder searchSortOrder,
  }) = _PaginationImpl;

  factory Pagination.fromJson(Map<String, dynamic> jsonSerialization) {
    return Pagination(
      pageNumber: jsonSerialization['pageNumber'] as int,
      pagesToScrape: jsonSerialization['pagesToScrape'] as int,
      resultsPerPage: jsonSerialization['resultsPerPage'] as int,
      searchSortOrder: _i2.SearchSortOrder.fromJson(
        (jsonSerialization['searchSortOrder'] as String),
      ),
    );
  }

  int pageNumber;

  int pagesToScrape;

  int resultsPerPage;

  _i2.SearchSortOrder searchSortOrder;

  /// Returns a shallow copy of this [Pagination]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Pagination copyWith({
    int? pageNumber,
    int? pagesToScrape,
    int? resultsPerPage,
    _i2.SearchSortOrder? searchSortOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Pagination',
      'pageNumber': pageNumber,
      'pagesToScrape': pagesToScrape,
      'resultsPerPage': resultsPerPage,
      'searchSortOrder': searchSortOrder.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Pagination',
      'pageNumber': pageNumber,
      'pagesToScrape': pagesToScrape,
      'resultsPerPage': resultsPerPage,
      'searchSortOrder': searchSortOrder.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PaginationImpl extends Pagination {
  _PaginationImpl({
    required int pageNumber,
    required int pagesToScrape,
    required int resultsPerPage,
    required _i2.SearchSortOrder searchSortOrder,
  }) : super._(
         pageNumber: pageNumber,
         pagesToScrape: pagesToScrape,
         resultsPerPage: resultsPerPage,
         searchSortOrder: searchSortOrder,
       );

  /// Returns a shallow copy of this [Pagination]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Pagination copyWith({
    int? pageNumber,
    int? pagesToScrape,
    int? resultsPerPage,
    _i2.SearchSortOrder? searchSortOrder,
  }) {
    return Pagination(
      pageNumber: pageNumber ?? this.pageNumber,
      pagesToScrape: pagesToScrape ?? this.pagesToScrape,
      resultsPerPage: resultsPerPage ?? this.resultsPerPage,
      searchSortOrder: searchSortOrder ?? this.searchSortOrder,
    );
  }
}
