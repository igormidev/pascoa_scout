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

enum AvailableProperties implements _i1.SerializableModel {
  title,
  description,
  jobType,
  experienceLevel,
  budget,
  tags,
  relativeDate,
  absoluteDate,
  paymentVerified,
  clientLocation,
  allowedApplicantCountries;

  static AvailableProperties fromJson(String name) {
    switch (name) {
      case 'title':
        return AvailableProperties.title;
      case 'description':
        return AvailableProperties.description;
      case 'jobType':
        return AvailableProperties.jobType;
      case 'experienceLevel':
        return AvailableProperties.experienceLevel;
      case 'budget':
        return AvailableProperties.budget;
      case 'tags':
        return AvailableProperties.tags;
      case 'relativeDate':
        return AvailableProperties.relativeDate;
      case 'absoluteDate':
        return AvailableProperties.absoluteDate;
      case 'paymentVerified':
        return AvailableProperties.paymentVerified;
      case 'clientLocation':
        return AvailableProperties.clientLocation;
      case 'allowedApplicantCountries':
        return AvailableProperties.allowedApplicantCountries;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "AvailableProperties"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
