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

enum JobAnalysisOrderBy implements _i1.SerializableModel {
  highestScore,
  highestHourlyRate,
  lowestHourlyRate,
  highestFixedPrice,
  lowestFixedPrice,
  newestRelativeDate,
  newestAbsoluteDate,
  mostRecentJobInfoCreatedAt,
  mostRecentScoringCreatedAt,
  mostRecentAiResponsesCreatedAt,
  highestClientHireRate,
  highestClientAverageHourlyRate,
  highestClientNameConfidence,
  highestClientRating,
  highestClientTotalSpent;

  static JobAnalysisOrderBy fromJson(String name) {
    switch (name) {
      case 'highestScore':
        return JobAnalysisOrderBy.highestScore;
      case 'highestHourlyRate':
        return JobAnalysisOrderBy.highestHourlyRate;
      case 'lowestHourlyRate':
        return JobAnalysisOrderBy.lowestHourlyRate;
      case 'highestFixedPrice':
        return JobAnalysisOrderBy.highestFixedPrice;
      case 'lowestFixedPrice':
        return JobAnalysisOrderBy.lowestFixedPrice;
      case 'newestRelativeDate':
        return JobAnalysisOrderBy.newestRelativeDate;
      case 'newestAbsoluteDate':
        return JobAnalysisOrderBy.newestAbsoluteDate;
      case 'mostRecentJobInfoCreatedAt':
        return JobAnalysisOrderBy.mostRecentJobInfoCreatedAt;
      case 'mostRecentScoringCreatedAt':
        return JobAnalysisOrderBy.mostRecentScoringCreatedAt;
      case 'mostRecentAiResponsesCreatedAt':
        return JobAnalysisOrderBy.mostRecentAiResponsesCreatedAt;
      case 'highestClientHireRate':
        return JobAnalysisOrderBy.highestClientHireRate;
      case 'highestClientAverageHourlyRate':
        return JobAnalysisOrderBy.highestClientAverageHourlyRate;
      case 'highestClientNameConfidence':
        return JobAnalysisOrderBy.highestClientNameConfidence;
      case 'highestClientRating':
        return JobAnalysisOrderBy.highestClientRating;
      case 'highestClientTotalSpent':
        return JobAnalysisOrderBy.highestClientTotalSpent;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "JobAnalysisOrderBy"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
