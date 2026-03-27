import '../generated/protocol.dart';
import 'upwork_scrap_labels.dart';

final RegExp _normalizePattern = RegExp(r'[^a-z0-9]+');
final RegExp _numberPattern = RegExp(r'[^0-9.-]+');

String _normalizeLabel(String value) {
  return value.toLowerCase().replaceAll(_normalizePattern, '');
}

T? _enumFromDisplayName<T extends Enum>(
  Iterable<T> values,
  String? rawValue,
  String Function(T value) displayName,
) {
  if (rawValue == null || rawValue.isEmpty) {
    return null;
  }

  final normalized = _normalizeLabel(rawValue);
  for (final value in values) {
    if (_normalizeLabel(displayName(value)) == normalized) {
      return value;
    }
  }

  return null;
}

extension JobTypeApifyX on JobType {
  String get apifyValue => switch (this) {
    JobType.fixed => 'fixed',
    JobType.hourly => 'hourly',
  };
}

extension ExperienceLevelApifyX on ExperienceLevel {
  String get apifyValue => switch (this) {
    ExperienceLevel.entryLevel => 'entry',
    ExperienceLevel.intermediate => 'intermediate',
    ExperienceLevel.expert => 'expert',
  };
}

extension ClientHistoryApifyX on ClientHistory {
  String get apifyValue => switch (this) {
    ClientHistory.noHires => 'noHires',
    ClientHistory.oneTonNineHires => '1to9Hires',
    ClientHistory.tenPlusHires => '10+Hires',
  };
}

extension SearchSortOrderApifyX on SearchSortOrder {
  String get apifyValue => switch (this) {
    SearchSortOrder.relevance => 'relevance',
    SearchSortOrder.newest => 'newest',
  };
}

extension JobAgeUnitApifyX on JobAgeUnit {
  String get apifyValue => switch (this) {
    JobAgeUnit.minutes => 'minutes',
    JobAgeUnit.hours => 'hours',
    JobAgeUnit.days => 'days',
    JobAgeUnit.weeks => 'weeks',
  };
}

extension AvailableOperatorsApifyX on AvailableOperators {
  String get apifyValue => switch (this) {
    AvailableOperators.includes => 'includes',
    AvailableOperators.equals => 'equals',
    AvailableOperators.notIncludes => 'notIncludes',
    AvailableOperators.notEquals => 'notEquals',
  };
}

extension AvailablePropertiesApifyX on AvailableProperties {
  String get apifyValue => switch (this) {
    AvailableProperties.title => 'title',
    AvailableProperties.description => 'description',
    AvailableProperties.jobType => 'jobType',
    AvailableProperties.experienceLevel => 'experienceLevel',
    AvailableProperties.budget => 'budget',
    AvailableProperties.tags => 'tags',
    AvailableProperties.relativeDate => 'relativeDate',
    AvailableProperties.absoluteDate => 'absoluteDate',
    AvailableProperties.paymentVerified => 'paymentVerified',
    AvailableProperties.clientLocation => 'clientLocation',
    AvailableProperties.allowedApplicantCountries =>
      'allowedApplicantCountries',
  };
}

extension JobFilterApifyX on JobFilter {
  Map<String, dynamic> get toApifyJson {
    final json = <String, dynamic>{
      'query': searchQueryTerm,
      'paymentVerified': paymentVerified,
    };

    if (clientHistory != null && clientHistory!.isNotEmpty) {
      json['clientHistory'] = clientHistory!
          .map((value) => value.apifyValue)
          .toList(growable: false);
    }

    if (experienceLevel != null && experienceLevel!.isNotEmpty) {
      json['experienceLevel'] = experienceLevel!
          .map((value) => value.apifyValue)
          .toList(growable: false);
    }

    if (jobType != null && jobType!.isNotEmpty) {
      json['jobType'] = jobType!
          .map((value) => value.apifyValue)
          .toList(growable: false);
    }

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

    final locations = <String>[
      if (countries != null) ...countries!.map((value) => value.displayName),
      if (regions != null) ...regions!.map((value) => value.displayName),
      if (subRegions != null) ...subRegions!.map((value) => value.displayName),
    ];

    if (locations.isNotEmpty) {
      json['location'] = locations;
    }

    if (jobAgeFilter != null) {
      json['maxJobAge'] = {
        'unit': jobAgeFilter!.unit.apifyValue,
        'value': jobAgeFilter!.value,
      };
    }

    if (customFilters != null && customFilters!.isNotEmpty) {
      json['customFilters'] = customFilters!
          .map(
            (filter) => <String, dynamic>{
              'key': filter.properties.apifyValue,
              'operator': filter.operators.apifyValue,
              'value': filter.values,
            },
          )
          .toList(growable: false);
    }

    return json;
  }
}

extension PaginationApifyX on Pagination {
  Map<String, dynamic> get toApifyJson => <String, dynamic>{
    'page': pageNumber,
    'pagesToScrape': pagesToScrape,
    'perPage': resultsPerPage,
    'sort': searchSortOrder.apifyValue,
  };
}

Pagination buildInitialPagination() {
  return Pagination(
    pageNumber: 1,
    pagesToScrape: 1,
    resultsPerPage: 15,
    searchSortOrder: SearchSortOrder.newest,
  );
}

JobInfo jobInfoFromApify(Map<String, dynamic> json) {
  final questionsRaw = (json['questions'] as List<dynamic>? ?? const []);
  final relativeDate = _emptyStringToNull(
    _nullableString(json['relativeDate']),
  );
  final absoluteDate = _emptyStringToNull(
    _nullableString(json['absoluteDate']),
  );
  final budget = _emptyStringToNull(_nullableString(json['budget']));
  final parsedBudget = _parseBudgetRange(
    budget: budget,
    jobType: _jobTypeFromApify(json['jobType']),
  );

  return JobInfo(
    upworkId: _requiredString(json, 'id'),
    subId: _nullableString(json['subId']),
    title: _requiredString(json, 'title'),
    description: _requiredString(json, 'description'),
    url: _requiredString(json, 'url'),
    relativeDate: relativeDate,
    relativeDateMinutes: _parseRelativeDateMinutes(relativeDate),
    absoluteDate: absoluteDate,
    absoluteDateTime: _parseDateTime(absoluteDate),
    budget: budget,
    fixedPriceAmount: parsedBudget.fixedPriceAmount,
    hourlyMinRate: parsedBudget.hourlyMinRate,
    hourlyMaxRate: parsedBudget.hourlyMaxRate,
    jobType: _jobTypeFromApify(json['jobType']),
    experienceLevel: _experienceLevelFromApify(json['experienceLevel']),
    clientLocation: _clientLocationFromDisplayName(
      _nullableString(json['clientLocation']),
    ),
    paymentVerifiedStatus: _paymentVerifiedStatusFromApify(
      json['paymentVerified'],
    ),
    allowedApplicantCountries: _parseCountries(
      json['allowedApplicantCountries'],
    ),
    clientName: _nullableString(json['clientName']),
    clientNameConfidencePercent: _normalizePercent(
      json['clientNameConfidence'],
    ),
    clientAvgHourlyRate: _parseNullableDouble(json['clientAvgHourlyRate']),
    clientRating: _parseNullableDouble(json['clientRating']),
    clientHireRatePercent: _normalizePercent(json['clientHireRatePercent']),
    clientTotalSpent: _parseNullableDouble(json['clientTotalSpent']),
    tags: _parseStringList(json['tags']),
    hasHired: json['hasHired'] == true,
    questions: [
      for (var index = 0; index < questionsRaw.length; index++)
        _questionFromApify(questionsRaw[index], index),
    ],
  );
}

Question _questionFromApify(dynamic rawValue, int fallbackIndex) {
  if (rawValue is! Map) {
    throw FormatException(
      'Unexpected question payload type: ${rawValue.runtimeType}',
    );
  }

  final json = Map<String, dynamic>.from(rawValue);
  return Question(
    question: _requiredString(json, 'question'),
    positionIndex: _parseNullableInt(json['position']) ?? fallbackIndex,
    jobInfoId: null,
  );
}

List<Country> _parseCountries(dynamic rawValue) {
  if (rawValue is! List) {
    return const [];
  }

  final countries = <Country>[];
  for (final item in rawValue) {
    final country = _enumFromDisplayName(
      Country.values,
      item?.toString(),
      (value) => value.displayName,
    );
    if (country != null) {
      countries.add(country);
    }
  }
  return countries;
}

List<String> _parseStringList(dynamic rawValue) {
  if (rawValue is! List) {
    return const [];
  }

  return rawValue.map((item) => item.toString()).toList(growable: false);
}

ClientLocation? _clientLocationFromDisplayName(String? rawValue) {
  final country = _enumFromDisplayName(
    Country.values,
    rawValue,
    (value) => value.displayName,
  );
  if (country != null) {
    return ClientLocation(country: country);
  }

  final region = _enumFromDisplayName(
    Region.values,
    rawValue,
    (value) => value.displayName,
  );
  if (region != null) {
    return ClientLocation(region: region);
  }

  final subRegion = _enumFromDisplayName(
    SubRegion.values,
    rawValue,
    (value) => value.displayName,
  );
  if (subRegion != null) {
    return ClientLocation(subRegion: subRegion);
  }

  return null;
}

JobType _jobTypeFromApify(dynamic rawValue) {
  return switch (_normalizeLabel(rawValue?.toString() ?? '')) {
    'fixed' || 'fixedprice' => JobType.fixed,
    'hourly' => JobType.hourly,
    _ => throw FormatException('Unknown job type: $rawValue'),
  };
}

ExperienceLevel _experienceLevelFromApify(dynamic rawValue) {
  return switch (_normalizeLabel(rawValue?.toString() ?? '')) {
    'entry' || 'entrylevel' => ExperienceLevel.entryLevel,
    'intermediate' => ExperienceLevel.intermediate,
    'expert' => ExperienceLevel.expert,
    _ => throw FormatException('Unknown experience level: $rawValue'),
  };
}

PaymentVerifiedStatus _paymentVerifiedStatusFromApify(dynamic rawValue) {
  if (rawValue == true) {
    return PaymentVerifiedStatus.verified;
  }
  if (rawValue == false) {
    return PaymentVerifiedStatus.unverified;
  }
  return PaymentVerifiedStatus.unknown;
}

double? _normalizePercent(dynamic rawValue) {
  final value = _parseNullableDouble(rawValue);
  if (value == null) {
    return null;
  }

  if (value >= 0 && value <= 1) {
    return (value * 100).clamp(0, 100).toDouble();
  }

  return value.clamp(0, 100).toDouble();
}

({double? fixedPriceAmount, double? hourlyMinRate, double? hourlyMaxRate})
_parseBudgetRange({
  required String? budget,
  required JobType jobType,
}) {
  if (budget == null || budget.trim().isEmpty) {
    return (fixedPriceAmount: null, hourlyMinRate: null, hourlyMaxRate: null);
  }

  // Apify budget strings can include thousands separators, e.g. "$2,000.00".
  // Normalize them before extracting numeric tokens so we don't split 2000 into
  // separate values such as 2 and 000.00.
  final normalizedBudget = budget.replaceAll(',', '');
  final matches = RegExp(r'\d+(?:\.\d+)?').allMatches(normalizedBudget);
  final values = [
    for (final match in matches)
      double.tryParse(match.group(0) ?? '') ?? double.nan,
  ].where((value) => !value.isNaN).toList(growable: false);

  if (values.isEmpty) {
    return (fixedPriceAmount: null, hourlyMinRate: null, hourlyMaxRate: null);
  }

  return switch (jobType) {
    JobType.fixed => (
      fixedPriceAmount: values.first,
      hourlyMinRate: null,
      hourlyMaxRate: null,
    ),
    JobType.hourly => (
      fixedPriceAmount: null,
      hourlyMinRate: values.first,
      hourlyMaxRate: values.length > 1 ? values.last : values.first,
    ),
  };
}

int? _parseRelativeDateMinutes(String? relativeDate) {
  if (relativeDate == null || relativeDate.trim().isEmpty) {
    return null;
  }

  final normalized = relativeDate.trim().toLowerCase();
  if (normalized == 'just now') {
    return 0;
  }

  final match = RegExp(r'(\d+)\s+([a-z]+)').firstMatch(normalized);
  if (match == null) {
    return null;
  }

  final value = int.tryParse(match.group(1) ?? '');
  final unit = match.group(2) ?? '';
  if (value == null) {
    return null;
  }

  if (unit.startsWith('sec')) {
    return (value / 60).ceil();
  }
  if (unit.startsWith('min')) {
    return value;
  }
  if (unit.startsWith('hour') || unit == 'hr' || unit == 'hrs') {
    return value * 60;
  }
  if (unit.startsWith('day')) {
    return value * 60 * 24;
  }
  if (unit.startsWith('week')) {
    return value * 60 * 24 * 7;
  }

  return null;
}

DateTime? _parseDateTime(String? rawValue) {
  if (rawValue == null || rawValue.trim().isEmpty) {
    return null;
  }

  return DateTime.tryParse(rawValue)?.toUtc();
}

double? _parseNullableDouble(dynamic rawValue) {
  if (rawValue == null) {
    return null;
  }

  if (rawValue is num) {
    return rawValue.toDouble();
  }

  final normalizedNumber = rawValue.toString().replaceAll(_numberPattern, '');
  if (normalizedNumber.isEmpty ||
      normalizedNumber == '-' ||
      normalizedNumber == '.' ||
      normalizedNumber == '-.') {
    return null;
  }

  return double.tryParse(normalizedNumber);
}

int? _parseNullableInt(dynamic rawValue) {
  if (rawValue == null) {
    return null;
  }

  if (rawValue is int) {
    return rawValue;
  }

  return int.tryParse(rawValue.toString());
}

String _requiredString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) {
    throw FormatException('Missing required field: $key');
  }

  return value.toString();
}

String? _nullableString(dynamic value) {
  return value?.toString();
}

String? _emptyStringToNull(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  return value;
}
