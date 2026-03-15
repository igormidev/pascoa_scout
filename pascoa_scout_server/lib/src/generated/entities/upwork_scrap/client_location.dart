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
import '../../entities/upwork_scrap/country.dart' as _i2;
import '../../entities/upwork_scrap/region.dart' as _i3;
import '../../entities/upwork_scrap/sub_region.dart' as _i4;

abstract class ClientLocation
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ClientLocation._({
    this.country,
    this.region,
    this.subRegion,
  });

  factory ClientLocation({
    _i2.Country? country,
    _i3.Region? region,
    _i4.SubRegion? subRegion,
  }) = _ClientLocationImpl;

  factory ClientLocation.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClientLocation(
      country: jsonSerialization['country'] == null
          ? null
          : _i2.Country.fromJson((jsonSerialization['country'] as String)),
      region: jsonSerialization['region'] == null
          ? null
          : _i3.Region.fromJson((jsonSerialization['region'] as String)),
      subRegion: jsonSerialization['subRegion'] == null
          ? null
          : _i4.SubRegion.fromJson((jsonSerialization['subRegion'] as String)),
    );
  }

  _i2.Country? country;

  _i3.Region? region;

  _i4.SubRegion? subRegion;

  /// Returns a shallow copy of this [ClientLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClientLocation copyWith({
    _i2.Country? country,
    _i3.Region? region,
    _i4.SubRegion? subRegion,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClientLocation',
      if (country != null) 'country': country?.toJson(),
      if (region != null) 'region': region?.toJson(),
      if (subRegion != null) 'subRegion': subRegion?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClientLocation',
      if (country != null) 'country': country?.toJson(),
      if (region != null) 'region': region?.toJson(),
      if (subRegion != null) 'subRegion': subRegion?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClientLocationImpl extends ClientLocation {
  _ClientLocationImpl({
    _i2.Country? country,
    _i3.Region? region,
    _i4.SubRegion? subRegion,
  }) : super._(
         country: country,
         region: region,
         subRegion: subRegion,
       );

  /// Returns a shallow copy of this [ClientLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClientLocation copyWith({
    Object? country = _Undefined,
    Object? region = _Undefined,
    Object? subRegion = _Undefined,
  }) {
    return ClientLocation(
      country: country is _i2.Country? ? country : this.country,
      region: region is _i3.Region? ? region : this.region,
      subRegion: subRegion is _i4.SubRegion? ? subRegion : this.subRegion,
    );
  }
}
