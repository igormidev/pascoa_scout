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
import '../entities/manual_job_proposal_price_kind.dart' as _i2;

abstract class ManualJobProposalRequest implements _i1.SerializableModel {
  ManualJobProposalRequest._({
    required this.title,
    required this.description,
    required this.price,
    required this.priceKind,
  });

  factory ManualJobProposalRequest({
    required String title,
    required String description,
    required double price,
    required _i2.ManualJobProposalPriceKind priceKind,
  }) = _ManualJobProposalRequestImpl;

  factory ManualJobProposalRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ManualJobProposalRequest(
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
      priceKind: _i2.ManualJobProposalPriceKind.fromJson(
        (jsonSerialization['priceKind'] as String),
      ),
    );
  }

  String title;

  String description;

  double price;

  _i2.ManualJobProposalPriceKind priceKind;

  /// Returns a shallow copy of this [ManualJobProposalRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ManualJobProposalRequest copyWith({
    String? title,
    String? description,
    double? price,
    _i2.ManualJobProposalPriceKind? priceKind,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManualJobProposalRequest',
      'title': title,
      'description': description,
      'price': price,
      'priceKind': priceKind.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ManualJobProposalRequestImpl extends ManualJobProposalRequest {
  _ManualJobProposalRequestImpl({
    required String title,
    required String description,
    required double price,
    required _i2.ManualJobProposalPriceKind priceKind,
  }) : super._(
         title: title,
         description: description,
         price: price,
         priceKind: priceKind,
       );

  /// Returns a shallow copy of this [ManualJobProposalRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ManualJobProposalRequest copyWith({
    String? title,
    String? description,
    double? price,
    _i2.ManualJobProposalPriceKind? priceKind,
  }) {
    return ManualJobProposalRequest(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      priceKind: priceKind ?? this.priceKind,
    );
  }
}
