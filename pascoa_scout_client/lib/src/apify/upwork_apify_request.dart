import 'dart:convert';

import 'upwork_scrap_labels.dart';

const String upworkApifyRunEndpoint =
    'https://api.apify.com/v2/acts/neatrat~upwork-job-scraper/run-sync-get-dataset-items';

const Map<String, String> _jobTypeApifyValues = {
  'fixed': 'fixed',
  'hourly': 'hourly',
};

const Map<String, String> _experienceLevelApifyValues = {
  'entryLevel': 'entry',
  'intermediate': 'intermediate',
  'expert': 'expert',
};

const Map<String, String> _clientHistoryApifyValues = {
  'noHires': 'noHires',
  'oneTonNineHires': '1to9Hires',
  'tenPlusHires': '10+Hires',
};

const Map<String, String> _searchSortOrderApifyValues = {
  'relevance': 'relevance',
  'newest': 'newest',
};

const Map<String, String> _jobAgeUnitApifyValues = {
  'minutes': 'minutes',
  'hours': 'hours',
  'days': 'days',
  'weeks': 'weeks',
};

const Map<String, String> _availableOperatorApifyValues = {
  'includes': 'includes',
  'equals': 'equals',
  'notIncludes': 'notIncludes',
  'notEquals': 'notEquals',
};

const Map<String, String> _availablePropertyApifyValues = {
  'title': 'title',
  'description': 'description',
  'jobType': 'jobType',
  'experienceLevel': 'experienceLevel',
  'budget': 'budget',
  'tags': 'tags',
  'relativeDate': 'relativeDate',
  'absoluteDate': 'absoluteDate',
  'paymentVerified': 'paymentVerified',
  'clientLocation': 'clientLocation',
  'allowedApplicantCountries': 'allowedApplicantCountries',
};

Map<String, dynamic> buildUpworkApifyRequestBody({
  required Map<String, dynamic> filterJson,
  required Map<String, dynamic> paginationJson,
}) {
  final rawUrl = (filterJson['rawUrl'] ?? '').toString().trim();
  final json = <String, dynamic>{
    'paymentVerified': filterJson['paymentVerified'] == true,
  };
  if (rawUrl.isNotEmpty) {
    json['rawUrl'] = rawUrl;
  } else {
    json['query'] = (filterJson['searchQueryTerm'] ?? '').toString();
  }

  final clientHistory = _mapEnumList(
    filterJson['clientHistory'],
    _clientHistoryApifyValues,
  );
  if (clientHistory.isNotEmpty) {
    json['clientHistory'] = clientHistory;
  }

  final experienceLevel = _mapEnumList(
    filterJson['experienceLevel'],
    _experienceLevelApifyValues,
  );
  if (experienceLevel.isNotEmpty) {
    json['experienceLevel'] = experienceLevel;
  }

  final jobType = _mapEnumList(filterJson['jobType'], _jobTypeApifyValues);
  if (jobType.isNotEmpty) {
    json['jobType'] = jobType;
  }

  final fixedPriceRange = _readMap(filterJson['fixedPriceRange']);
  if (fixedPriceRange != null) {
    json['fixedPriceRange'] = [
      '${fixedPriceRange['min']}',
      '${fixedPriceRange['max']}',
    ];
  }

  final hourlyRateRange = _readMap(filterJson['hourlyRateRange']);
  if (hourlyRateRange != null) {
    json['hourlyRateRange'] = [
      '${hourlyRateRange['min']}',
      '${hourlyRateRange['max']}',
    ];
  }

  final locations = <String>[
    for (final value in _readStringList(filterJson['countries']))
      countryDisplayNameFromRawValue(value),
    for (final value in _readStringList(filterJson['regions']))
      regionDisplayNameFromRawValue(value),
    for (final value in _readStringList(filterJson['subRegions']))
      subRegionDisplayNameFromRawValue(value),
  ];
  if (locations.isNotEmpty) {
    json['location'] = locations;
  }

  final jobAgeFilter = _readMap(filterJson['jobAgeFilter']);
  if (jobAgeFilter != null) {
    final rawUnit = jobAgeFilter['unit']?.toString();
    if (rawUnit != null) {
      json['maxJobAge'] = <String, dynamic>{
        'unit': _jobAgeUnitApifyValues[rawUnit] ?? rawUnit,
        'value': jobAgeFilter['value'],
      };
    }
  }

  final customFilters = _readMapList(filterJson['customFilters'])
      .map((filter) {
        final rawProperty = filter['properties']?.toString();
        final rawOperator = filter['operators']?.toString();
        if (rawProperty == null || rawOperator == null) {
          return null;
        }

        return <String, dynamic>{
          'key': _availablePropertyApifyValues[rawProperty] ?? rawProperty,
          'operator': _availableOperatorApifyValues[rawOperator] ?? rawOperator,
          'value': _readStringList(filter['values']),
        };
      })
      .whereType<Map<String, dynamic>>()
      .toList(growable: false);
  if (customFilters.isNotEmpty) {
    json['customFilters'] = customFilters;
  }

  json.addAll(_paginationToApifyJson(paginationJson));
  return json;
}

Uri buildUpworkApifyRunUri() {
  return Uri.parse(upworkApifyRunEndpoint).replace(
    queryParameters: const <String, String>{
      'format': 'json',
      'clean': 'true',
    },
  );
}

String buildUpworkApifyCurl({
  required Map<String, dynamic> filterJson,
  required Map<String, dynamic> paginationJson,
  required String apifyToken,
}) {
  final requestBody = buildUpworkApifyRequestBody(
    filterJson: filterJson,
    paginationJson: paginationJson,
  );
  final requestBodyJson = const JsonEncoder.withIndent(
    '  ',
  ).convert(requestBody);

  return [
    'curl --request POST \\',
    '  --url ${_shellQuote(buildUpworkApifyRunUri().toString())} \\',
    '  --header ${_shellQuote('Authorization: Bearer $apifyToken')} \\',
    '  --header ${_shellQuote('Content-Type: application/json')} \\',
    '  --data ${_shellQuote(requestBodyJson)}',
  ].join('\n');
}

Map<String, dynamic> _paginationToApifyJson(
  Map<String, dynamic> paginationJson,
) {
  final rawSortOrder = paginationJson['searchSortOrder']?.toString();

  return <String, dynamic>{
    'page': paginationJson['pageNumber'],
    'pagesToScrape': paginationJson['pagesToScrape'],
    'perPage': paginationJson['resultsPerPage'],
    'sort': rawSortOrder == null
        ? null
        : _searchSortOrderApifyValues[rawSortOrder] ?? rawSortOrder,
  }..removeWhere((_, value) => value == null);
}

List<String> _mapEnumList(dynamic rawValue, Map<String, String> mapping) {
  return _readStringList(
    rawValue,
  ).map((value) => mapping[value] ?? value).toList(growable: false);
}

Map<String, dynamic>? _readMap(dynamic rawValue) {
  if (rawValue is! Map) {
    return null;
  }

  return Map<String, dynamic>.from(rawValue);
}

List<Map<String, dynamic>> _readMapList(dynamic rawValue) {
  if (rawValue is! List) {
    return const <Map<String, dynamic>>[];
  }

  return rawValue
      .whereType<Map>()
      .map((entry) => Map<String, dynamic>.from(entry))
      .toList(growable: false);
}

List<String> _readStringList(dynamic rawValue) {
  if (rawValue is! List) {
    return const <String>[];
  }

  return rawValue.map((entry) => entry.toString()).toList(growable: false);
}

String _shellQuote(String value) {
  return "'${value.replaceAll("'", "'\"'\"'")}'";
}
