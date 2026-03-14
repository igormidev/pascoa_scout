import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pascoa_scout/src/entities/upwork_scrap/enums.dart';

part 'job_filter.freezed.dart';
part 'job_filter.g.dart';

@freezed
abstract class JobFilter with _$JobFilter {
  factory JobFilter({
    required String searchQueryTerm,
    List<ExperienceLevel>? experienceLevel,
    List<ClientHistory>? clientHistory,
    List<JobType>? jobType,
    @Default(false) bool paymentVerified,
    MinMax? fixedPriceRange,
    MinMax? hourlyRateRange,
    List<Country>? countries,
    List<Region>? regions,
    List<SubRegion>? subRegions,
    MaximumJobAge? jobAgeFilter,
    List<CustomFilter>? customFilters,
  }) = _JobFilter;

  factory JobFilter.fromJson(Map<String, dynamic> json) =>
      _$JobFilterFromJson(json);
}

@freezed
abstract class MinMax with _$MinMax {
  factory MinMax({required int min, required int max}) = _MinMax;

  factory MinMax.fromJson(Map<String, dynamic> json) => _$MinMaxFromJson(json);
}

@freezed
abstract class MaximumJobAge with _$MaximumJobAge {
  factory MaximumJobAge({required JobAgeUnit unit, required int value}) =
      _MaximumJobAge;
  factory MaximumJobAge.fromJson(Map<String, dynamic> json) =>
      _$MaximumJobAgeFromJson(json);
}

extension JobFilterX on JobFilter {
  Map<String, dynamic> get toApifyJson {
    final Map<String, dynamic> json = {};
    json['query'] = searchQueryTerm; // "query": "web scraping"
    if (clientHistory != null) {
      json['clientHistory'] = clientHistory!.map((e) => e.apiName).toList();
    }
    if (experienceLevel != null) {
      json['experienceLevel'] = experienceLevel!.map((e) => e.apiName).toList();
    }
    if (jobType != null) {
      json['jobType'] = jobType!.map((e) => e.apiName).toList();
    }
    json['paymentVerified'] = paymentVerified;
    if (fixedPriceRange != null) {
      json['fixedPriceRange'] = [
        fixedPriceRange!.min.toString(),
        fixedPriceRange!.max.toString(),
      ];
    }
    if (hourlyRateRange != null) {
      json['hourlyRateRange'] = [
        hourlyRateRange!.min.toString(),
        hourlyRateRange!.max.toString(),
      ];
    }
    json['location'] = <String>[
      if (countries != null) ...countries!.map((e) => e.apiName),
      if (regions != null) ...regions!.map((e) => e.apiName),
      if (subRegions != null) ...subRegions!.map((e) => e.apiName),
    ];

    if (jobAgeFilter != null) {
      json['maxJobAge'] = {
        'unit': jobAgeFilter!.unit.apiName,
        'value': jobAgeFilter!.value,
      };
    }
    json['paymentVerified'] = paymentVerified; // "paymentVerified": false,

    if (customFilters != null) {
      json['customFilters'] = customFilters!.map((filter) {
        return {
          'key': filter.properties.apiName,
          'operator': filter.operators.apiName,
          'value': filter.values,
        };
      }).toList();
    }

    return json;
  }
}

/*
USE DIRECTLY IN THE SAME JSON WHERE THE FILTER IS USED
```dart
pagination?.toApifyJson.forEach((key, value) {
  json[key] = value;
});
```
*/
@freezed
abstract class Pagination with _$Pagination {
  factory Pagination({
    /// Page number to start scraping from
    required int pageNumber,

    /// Number of pages to scrape sequentially starting from the specified page
    required int pagesToScrape,

    /// Number of results to display per page
    required int resultsPerPage,

    /// How to sort the job listings
    required SearchSortOrder searchSortOrder,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}

extension PaginationX on Pagination {
  Map<String, dynamic> get toApifyJson {
    final Map<String, dynamic> json = {};
    json['page'] = pageNumber; // "page": 2,
    json['pagesToScrape'] = pagesToScrape; // "pagesToScrape": 5,
    json['perPage'] = resultsPerPage; // "perPage": 15,
    json['sort'] = searchSortOrder.apiName; // "sort": "newest"
    return json;
  }
}

@freezed
abstract class CustomFilter with _$CustomFilter {
  factory CustomFilter({
    required AvailableProperties properties,
    required AvailableOperators operators,
    required List<String> values,
  }) = _CustomFilter;

  factory CustomFilter.fromJson(Map<String, dynamic> json) =>
      _$CustomFilterFromJson(json);
}

enum AvailableOperators {
  includes(
    'includes',
  ), // checks if the value is included in the property (supports both single string and array of strings)
  equals('equals'), // checks if the value exactly matches the property
  notIncludes(
    'notIncludes',
  ), // checks if the value is not included in the property (supports both single string and array of strings)
  notEquals(
    'notEquals',
  ); // checks if the value does not exactly match the property

  final String apiName;
  const AvailableOperators(this.apiName);
}

enum AvailableProperties {
  title('title'),
  description('description'),
  jobType('jobType'),
  experienceLevel('experienceLevel'),
  budget('budget'),
  tags('tags'),
  relativeDate('relativeDate'),
  absoluteDate('absoluteDate'),
  paymentVerified('paymentVerified'),
  clientLocation('clientLocation'),
  allowedApplicantCountries('allowedApplicantCountries');

  final String apiName;
  const AvailableProperties(this.apiName);
}

enum SearchSortOrder {
  relevance('relevance'),
  newest('newest');

  final String apiName;
  const SearchSortOrder(this.apiName);
}

enum JobAgeUnit {
  minutes('minutes'),
  hours('hours'),
  days('days'),
  weeks('weeks');

  final String apiName;
  const JobAgeUnit(this.apiName);
}

enum ClientHistory {
  noHires('noHires'),
  oneTonNineHires('1to9Hires'),
  tenPlusHires('10+Hires');

  final String apiName;
  const ClientHistory(this.apiName);
}
