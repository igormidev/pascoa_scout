// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobFilter _$JobFilterFromJson(Map<String, dynamic> json) => _JobFilter(
  searchQueryTerm: json['searchQueryTerm'] as String,
  experienceLevel: (json['experienceLevel'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$ExperienceLevelEnumMap, e))
      .toList(),
  clientHistory: (json['clientHistory'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$ClientHistoryEnumMap, e))
      .toList(),
  jobType: (json['jobType'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$JobTypeEnumMap, e))
      .toList(),
  paymentVerified: json['paymentVerified'] as bool? ?? false,
  fixedPriceRange: json['fixedPriceRange'] == null
      ? null
      : MinMax.fromJson(json['fixedPriceRange'] as Map<String, dynamic>),
  hourlyRateRange: json['hourlyRateRange'] == null
      ? null
      : MinMax.fromJson(json['hourlyRateRange'] as Map<String, dynamic>),
  countries: (json['countries'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$CountryEnumMap, e))
      .toList(),
  regions: (json['regions'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$RegionEnumMap, e))
      .toList(),
  subRegions: (json['subRegions'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$SubRegionEnumMap, e))
      .toList(),
  jobAgeFilter: json['jobAgeFilter'] == null
      ? null
      : MaximumJobAge.fromJson(json['jobAgeFilter'] as Map<String, dynamic>),
  customFilters: (json['customFilters'] as List<dynamic>?)
      ?.map((e) => CustomFilter.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JobFilterToJson(
  _JobFilter instance,
) => <String, dynamic>{
  'searchQueryTerm': instance.searchQueryTerm,
  'experienceLevel': instance.experienceLevel
      ?.map((e) => _$ExperienceLevelEnumMap[e]!)
      .toList(),
  'clientHistory': instance.clientHistory
      ?.map((e) => _$ClientHistoryEnumMap[e]!)
      .toList(),
  'jobType': instance.jobType?.map((e) => _$JobTypeEnumMap[e]!).toList(),
  'paymentVerified': instance.paymentVerified,
  'fixedPriceRange': instance.fixedPriceRange,
  'hourlyRateRange': instance.hourlyRateRange,
  'countries': instance.countries?.map((e) => _$CountryEnumMap[e]!).toList(),
  'regions': instance.regions?.map((e) => _$RegionEnumMap[e]!).toList(),
  'subRegions': instance.subRegions
      ?.map((e) => _$SubRegionEnumMap[e]!)
      .toList(),
  'jobAgeFilter': instance.jobAgeFilter,
  'customFilters': instance.customFilters,
};

const _$ExperienceLevelEnumMap = {
  ExperienceLevel.entryLevel: 'entryLevel',
  ExperienceLevel.intermediate: 'intermediate',
  ExperienceLevel.expert: 'expert',
};

const _$ClientHistoryEnumMap = {
  ClientHistory.noHires: 'noHires',
  ClientHistory.oneTonNineHires: 'oneTonNineHires',
  ClientHistory.tenPlusHires: 'tenPlusHires',
};

const _$JobTypeEnumMap = {JobType.fixed: 'fixed', JobType.hourly: 'hourly'};

const _$CountryEnumMap = {
  Country.albania: 'albania',
  Country.algeria: 'algeria',
  Country.americanSamoa: 'americanSamoa',
  Country.andorra: 'andorra',
  Country.angola: 'angola',
  Country.anguilla: 'anguilla',
  Country.antiguaAndBarbuda: 'antiguaAndBarbuda',
  Country.argentina: 'argentina',
  Country.armenia: 'armenia',
  Country.aruba: 'aruba',
  Country.australia: 'australia',
  Country.austria: 'austria',
  Country.azerbaijan: 'azerbaijan',
  Country.bahamas: 'bahamas',
  Country.bahrain: 'bahrain',
  Country.bangladesh: 'bangladesh',
  Country.barbados: 'barbados',
  Country.belgium: 'belgium',
  Country.belize: 'belize',
  Country.benin: 'benin',
  Country.bermuda: 'bermuda',
  Country.bhutan: 'bhutan',
  Country.bolivia: 'bolivia',
  Country.bonaireSintEustatiusAndSaba: 'bonaireSintEustatiusAndSaba',
  Country.bosniaAndHerzegovina: 'bosniaAndHerzegovina',
  Country.botswana: 'botswana',
  Country.bouvetIsland: 'bouvetIsland',
  Country.brazil: 'brazil',
  Country.britishIndianOceanTerritory: 'britishIndianOceanTerritory',
  Country.britishVirginIslands: 'britishVirginIslands',
  Country.bruneiDarussalam: 'bruneiDarussalam',
  Country.bulgaria: 'bulgaria',
  Country.burkinaFaso: 'burkinaFaso',
  Country.burundi: 'burundi',
  Country.cambodia: 'cambodia',
  Country.cameroon: 'cameroon',
  Country.canada: 'canada',
  Country.capeVerde: 'capeVerde',
  Country.caymanIslands: 'caymanIslands',
  Country.centralAfricanRepublic: 'centralAfricanRepublic',
  Country.chad: 'chad',
  Country.chile: 'chile',
  Country.china: 'china',
  Country.christmasIsland: 'christmasIsland',
  Country.cocosKeelingIslands: 'cocosKeelingIslands',
  Country.colombia: 'colombia',
  Country.comoros: 'comoros',
  Country.congo: 'congo',
  Country.congoDemocraticRepublicOfThe: 'congoDemocraticRepublicOfThe',
  Country.cookIslands: 'cookIslands',
  Country.costaRica: 'costaRica',
  Country.coteDIvoire: 'coteDIvoire',
  Country.croatia: 'croatia',
  Country.curacao: 'curacao',
  Country.cyprus: 'cyprus',
  Country.czechRepublic: 'czechRepublic',
  Country.denmark: 'denmark',
  Country.djibouti: 'djibouti',
  Country.dominica: 'dominica',
  Country.dominicanRepublic: 'dominicanRepublic',
  Country.ecuador: 'ecuador',
  Country.egypt: 'egypt',
  Country.elSalvador: 'elSalvador',
  Country.equatorialGuinea: 'equatorialGuinea',
  Country.eritrea: 'eritrea',
  Country.estonia: 'estonia',
  Country.ethiopia: 'ethiopia',
  Country.falklandIslands: 'falklandIslands',
  Country.faroeIslands: 'faroeIslands',
  Country.fiji: 'fiji',
  Country.finland: 'finland',
  Country.france: 'france',
  Country.frenchGuiana: 'frenchGuiana',
  Country.frenchPolynesia: 'frenchPolynesia',
  Country.frenchSouthernAndAntarcticLands: 'frenchSouthernAndAntarcticLands',
  Country.gabon: 'gabon',
  Country.gambia: 'gambia',
  Country.georgia: 'georgia',
  Country.germany: 'germany',
  Country.ghana: 'ghana',
  Country.gibraltar: 'gibraltar',
  Country.greece: 'greece',
  Country.greenland: 'greenland',
  Country.grenada: 'grenada',
  Country.guadeloupe: 'guadeloupe',
  Country.guam: 'guam',
  Country.guatemala: 'guatemala',
  Country.guernsey: 'guernsey',
  Country.guinea: 'guinea',
  Country.guineaBissau: 'guineaBissau',
  Country.guyana: 'guyana',
  Country.haiti: 'haiti',
  Country.heardIslandAndMcDonaldIslands: 'heardIslandAndMcDonaldIslands',
  Country.holySee: 'holySee',
  Country.honduras: 'honduras',
  Country.hongKong: 'hongKong',
  Country.hungary: 'hungary',
  Country.iceland: 'iceland',
  Country.india: 'india',
  Country.indonesia: 'indonesia',
  Country.ireland: 'ireland',
  Country.isleOfMan: 'isleOfMan',
  Country.israel: 'israel',
  Country.italy: 'italy',
  Country.jamaica: 'jamaica',
  Country.japan: 'japan',
  Country.jersey: 'jersey',
  Country.jordan: 'jordan',
  Country.kazakhstan: 'kazakhstan',
  Country.kenya: 'kenya',
  Country.kiribati: 'kiribati',
  Country.kuwait: 'kuwait',
  Country.kyrgyzstan: 'kyrgyzstan',
  Country.laos: 'laos',
  Country.latvia: 'latvia',
  Country.lebanon: 'lebanon',
  Country.lesotho: 'lesotho',
  Country.liechtenstein: 'liechtenstein',
  Country.lithuania: 'lithuania',
  Country.luxembourg: 'luxembourg',
  Country.macao: 'macao',
  Country.macedonia: 'macedonia',
  Country.madagascar: 'madagascar',
  Country.malawi: 'malawi',
  Country.malaysia: 'malaysia',
  Country.maldives: 'maldives',
  Country.mali: 'mali',
  Country.malta: 'malta',
  Country.marshallIslands: 'marshallIslands',
  Country.martinique: 'martinique',
  Country.mauritania: 'mauritania',
  Country.mauritius: 'mauritius',
  Country.mayotte: 'mayotte',
  Country.mexico: 'mexico',
  Country.micronesiaFederatedStatesOf: 'micronesiaFederatedStatesOf',
  Country.moldova: 'moldova',
  Country.monaco: 'monaco',
  Country.mongolia: 'mongolia',
  Country.montenegro: 'montenegro',
  Country.montserrat: 'montserrat',
  Country.morocco: 'morocco',
  Country.mozambique: 'mozambique',
  Country.myanmar: 'myanmar',
  Country.namibia: 'namibia',
  Country.nauru: 'nauru',
  Country.nepal: 'nepal',
  Country.netherlands: 'netherlands',
  Country.netherlandsAntilles: 'netherlandsAntilles',
  Country.newCaledonia: 'newCaledonia',
  Country.newZealand: 'newZealand',
  Country.nicaragua: 'nicaragua',
  Country.niger: 'niger',
  Country.nigeria: 'nigeria',
  Country.niue: 'niue',
  Country.norfolkIsland: 'norfolkIsland',
  Country.northernMarianaIslands: 'northernMarianaIslands',
  Country.norway: 'norway',
  Country.oman: 'oman',
  Country.pakistan: 'pakistan',
  Country.palau: 'palau',
  Country.palestinianTerritories: 'palestinianTerritories',
  Country.panama: 'panama',
  Country.papuaNewGuinea: 'papuaNewGuinea',
  Country.paraguay: 'paraguay',
  Country.peru: 'peru',
  Country.philippines: 'philippines',
  Country.pitcairn: 'pitcairn',
  Country.poland: 'poland',
  Country.portugal: 'portugal',
  Country.puertoRico: 'puertoRico',
  Country.qatar: 'qatar',
  Country.reunion: 'reunion',
  Country.romania: 'romania',
  Country.rwanda: 'rwanda',
  Country.saintBarthelemy: 'saintBarthelemy',
  Country.saintHelena: 'saintHelena',
  Country.saintKittsAndNevis: 'saintKittsAndNevis',
  Country.saintLucia: 'saintLucia',
  Country.saintMartinFrenchPart: 'saintMartinFrenchPart',
  Country.saintPierreAndMiquelon: 'saintPierreAndMiquelon',
  Country.saintVincentAndTheGrenadines: 'saintVincentAndTheGrenadines',
  Country.samoa: 'samoa',
  Country.sanMarino: 'sanMarino',
  Country.saoTomeAndPrincipe: 'saoTomeAndPrincipe',
  Country.saudiArabia: 'saudiArabia',
  Country.senegal: 'senegal',
  Country.serbia: 'serbia',
  Country.seychelles: 'seychelles',
  Country.sierraLeone: 'sierraLeone',
  Country.singapore: 'singapore',
  Country.sintMaartenDutchPart: 'sintMaartenDutchPart',
  Country.slovakia: 'slovakia',
  Country.slovenia: 'slovenia',
  Country.solomonIslands: 'solomonIslands',
  Country.somalia: 'somalia',
  Country.southAfrica: 'southAfrica',
  Country.southKorea: 'southKorea',
  Country.spain: 'spain',
  Country.sriLanka: 'sriLanka',
  Country.suriname: 'suriname',
  Country.svalbardAndJanMayen: 'svalbardAndJanMayen',
  Country.swaziland: 'swaziland',
  Country.sweden: 'sweden',
  Country.switzerland: 'switzerland',
  Country.taiwan: 'taiwan',
  Country.tajikistan: 'tajikistan',
  Country.tanzania: 'tanzania',
  Country.thailand: 'thailand',
  Country.timorLeste: 'timorLeste',
  Country.togo: 'togo',
  Country.tokelau: 'tokelau',
  Country.tonga: 'tonga',
  Country.trinidadAndTobago: 'trinidadAndTobago',
  Country.tunisia: 'tunisia',
  Country.turkey: 'turkey',
  Country.turkmenistan: 'turkmenistan',
  Country.turksAndCaicosIslands: 'turksAndCaicosIslands',
  Country.tuvalu: 'tuvalu',
  Country.uganda: 'uganda',
  Country.ukraine: 'ukraine',
  Country.unitedArabEmirates: 'unitedArabEmirates',
  Country.unitedKingdom: 'unitedKingdom',
  Country.unitedStates: 'unitedStates',
  Country.unitedStatesMinorOutlyingIslands: 'unitedStatesMinorOutlyingIslands',
  Country.unitedStatesVirginIslands: 'unitedStatesVirginIslands',
  Country.uruguay: 'uruguay',
  Country.uzbekistan: 'uzbekistan',
  Country.vanuatu: 'vanuatu',
  Country.venezuela: 'venezuela',
  Country.vietnam: 'vietnam',
  Country.wallisAndFutuna: 'wallisAndFutuna',
  Country.westernSahara: 'westernSahara',
  Country.yemen: 'yemen',
  Country.zambia: 'zambia',
  Country.zimbabwe: 'zimbabwe',
};

const _$RegionEnumMap = {
  Region.africa: 'africa',
  Region.americas: 'americas',
  Region.antarctica: 'antarctica',
  Region.asia: 'asia',
  Region.europe: 'europe',
  Region.oceania: 'oceania',
};

const _$SubRegionEnumMap = {
  SubRegion.australiaAndNewZealand: 'australiaAndNewZealand',
  SubRegion.caribbean: 'caribbean',
  SubRegion.centralAmerica: 'centralAmerica',
  SubRegion.centralAsia: 'centralAsia',
  SubRegion.easternAfrica: 'easternAfrica',
  SubRegion.easternAsia: 'easternAsia',
  SubRegion.easternEurope: 'easternEurope',
  SubRegion.melanesia: 'melanesia',
  SubRegion.micronesia: 'micronesia',
  SubRegion.middleAfrica: 'middleAfrica',
  SubRegion.northernAfrica: 'northernAfrica',
  SubRegion.northernAmerica: 'northernAmerica',
  SubRegion.northernEurope: 'northernEurope',
  SubRegion.polynesia: 'polynesia',
  SubRegion.southAmerica: 'southAmerica',
  SubRegion.southEasternAsia: 'southEasternAsia',
  SubRegion.southernAfrica: 'southernAfrica',
  SubRegion.southernAsia: 'southernAsia',
  SubRegion.southernEurope: 'southernEurope',
  SubRegion.westernAfrica: 'westernAfrica',
  SubRegion.westernAsia: 'westernAsia',
  SubRegion.westernEurope: 'westernEurope',
};

_MinMax _$MinMaxFromJson(Map<String, dynamic> json) => _MinMax(
  min: (json['min'] as num).toInt(),
  max: (json['max'] as num).toInt(),
);

Map<String, dynamic> _$MinMaxToJson(_MinMax instance) => <String, dynamic>{
  'min': instance.min,
  'max': instance.max,
};

_MaximumJobAge _$MaximumJobAgeFromJson(Map<String, dynamic> json) =>
    _MaximumJobAge(
      unit: $enumDecode(_$JobAgeUnitEnumMap, json['unit']),
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$MaximumJobAgeToJson(_MaximumJobAge instance) =>
    <String, dynamic>{
      'unit': _$JobAgeUnitEnumMap[instance.unit]!,
      'value': instance.value,
    };

const _$JobAgeUnitEnumMap = {
  JobAgeUnit.minutes: 'minutes',
  JobAgeUnit.hours: 'hours',
  JobAgeUnit.days: 'days',
  JobAgeUnit.weeks: 'weeks',
};

_Pagination _$PaginationFromJson(Map<String, dynamic> json) => _Pagination(
  pageNumber: (json['pageNumber'] as num).toInt(),
  pagesToScrape: (json['pagesToScrape'] as num).toInt(),
  resultsPerPage: (json['resultsPerPage'] as num).toInt(),
  searchSortOrder: $enumDecode(
    _$SearchSortOrderEnumMap,
    json['searchSortOrder'],
  ),
);

Map<String, dynamic> _$PaginationToJson(_Pagination instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pagesToScrape': instance.pagesToScrape,
      'resultsPerPage': instance.resultsPerPage,
      'searchSortOrder': _$SearchSortOrderEnumMap[instance.searchSortOrder]!,
    };

const _$SearchSortOrderEnumMap = {
  SearchSortOrder.relevance: 'relevance',
  SearchSortOrder.newest: 'newest',
};

_CustomFilter _$CustomFilterFromJson(Map<String, dynamic> json) =>
    _CustomFilter(
      properties: $enumDecode(_$AvailablePropertiesEnumMap, json['properties']),
      operators: $enumDecode(_$AvailableOperatorsEnumMap, json['operators']),
      values: (json['values'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CustomFilterToJson(_CustomFilter instance) =>
    <String, dynamic>{
      'properties': _$AvailablePropertiesEnumMap[instance.properties]!,
      'operators': _$AvailableOperatorsEnumMap[instance.operators]!,
      'values': instance.values,
    };

const _$AvailablePropertiesEnumMap = {
  AvailableProperties.title: 'title',
  AvailableProperties.description: 'description',
  AvailableProperties.jobType: 'jobType',
  AvailableProperties.experienceLevel: 'experienceLevel',
  AvailableProperties.budget: 'budget',
  AvailableProperties.tags: 'tags',
  AvailableProperties.relativeDate: 'relativeDate',
  AvailableProperties.absoluteDate: 'absoluteDate',
  AvailableProperties.paymentVerified: 'paymentVerified',
  AvailableProperties.clientLocation: 'clientLocation',
  AvailableProperties.allowedApplicantCountries: 'allowedApplicantCountries',
};

const _$AvailableOperatorsEnumMap = {
  AvailableOperators.includes: 'includes',
  AvailableOperators.equals: 'equals',
  AvailableOperators.notIncludes: 'notIncludes',
  AvailableOperators.notEquals: 'notEquals',
};
