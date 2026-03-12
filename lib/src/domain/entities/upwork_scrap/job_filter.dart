import 'package:freezed_annotation/freezed_annotation.dart';

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
    Pagination? pagination,
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

    json['page'] = pagination?.pageNumber; // "page": 2,
    json['pagesToScrape'] = pagination?.pagesToScrape; // "pagesToScrape": 5,
    json['paymentVerified'] = paymentVerified; // "paymentVerified": false,
    json['perPage'] = pagination?.resultsPerPage; // "perPage": 15,
    json['sort'] = pagination?.searchSortOrder.apiName; // "sort": "newest"

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

enum ExperienceLevel {
  entryLevel('entry'),
  intermediate('intermediate'),
  expert('expert');

  final String apiName;
  const ExperienceLevel(this.apiName);
}

enum JobType {
  fixed('fixed'),
  hourly('hourly');

  final String apiName;
  const JobType(this.apiName);
}

enum ClientHistory {
  noHires('noHires'),
  oneTonNineHires('1to9Hires'),
  tenPlusHires('10+Hires');

  final String apiName;
  const ClientHistory(this.apiName);
}

enum Region {
  africa('Africa'),
  americas('Americas'),
  antarctica('Antarctica'),
  asia('Asia'),
  europe('Europe'),
  oceania('Oceania');

  final String apiName;
  const Region(this.apiName);
}

enum SubRegion {
  australiaAndNewZealand('Australia and New Zealand'),
  caribbean('Caribbean'),
  centralAmerica('Central America'),
  centralAsia('Central Asia'),
  easternAfrica('Eastern Africa'),
  easternAsia('Eastern Asia'),
  easternEurope('Eastern Europe'),
  melanesia('Melanesia'),
  micronesia('Micronesia'),
  middleAfrica('Middle Africa'),
  northernAfrica('Northern Africa'),
  northernAmerica('Northern America'),
  northernEurope('Northern Europe'),
  polynesia('Polynesia'),
  southAmerica('South America'),
  southEasternAsia('South-Eastern Asia'),
  southernAfrica('Southern Africa'),
  southernAsia('Southern Asia'),
  southernEurope('Southern Europe'),
  westernAfrica('Western Africa'),
  westernAsia('Western Asia'),
  westernEurope('Western Europe');

  final String apiName;
  const SubRegion(this.apiName);
}

enum Country {
  albania('Albania'),
  algeria('Algeria'),
  americanSamoa('American Samoa'),
  andorra('Andorra'),
  angola('Angola'),
  anguilla('Anguilla'),
  antiguaAndBarbuda('Antigua and Barbuda'),
  argentina('Argentina'),
  armenia('Armenia'),
  aruba('Aruba'),
  australia('Australia'),
  austria('Austria'),
  azerbaijan('Azerbaijan'),
  bahamas('Bahamas'),
  bahrain('Bahrain'),
  bangladesh('Bangladesh'),
  barbados('Barbados'),
  belgium('Belgium'),
  belize('Belize'),
  benin('Benin'),
  bermuda('Bermuda'),
  bhutan('Bhutan'),
  bolivia('Bolivia'),
  bonaireSintEustatiusAndSaba('Bonaire, Sint Eustatius and Saba'),
  bosniaAndHerzegovina('Bosnia and Herzegovina'),
  botswana('Botswana'),
  bouvetIsland('Bouvet Island'),
  brazil('Brazil'),
  britishIndianOceanTerritory('British Indian Ocean Territory'),
  britishVirginIslands('British Virgin Islands'),
  bruneiDarussalam('Brunei Darussalam'),
  bulgaria('Bulgaria'),
  burkinaFaso('Burkina Faso'),
  burundi('Burundi'),
  cambodia('Cambodia'),
  cameroon('Cameroon'),
  canada('Canada'),
  capeVerde('Cape Verde'),
  caymanIslands('Cayman Islands'),
  centralAfricanRepublic('Central African Republic'),
  chad('Chad'),
  chile('Chile'),
  china('China'),
  christmasIsland('Christmas Island'),
  cocosKeelingIslands('Cocos (Keeling) Islands'),
  colombia('Colombia'),
  comoros('Comoros'),
  congo('Congo'),
  congoDemocraticRepublicOfThe('Congo, the Democratic Republic of the'),
  cookIslands('Cook Islands'),
  costaRica('Costa Rica'),
  coteDIvoire('Cote d\'Ivoire'),
  croatia('Croatia'),
  curacao('Curacao'),
  cyprus('Cyprus'),
  czechRepublic('Czech Republic'),
  denmark('Denmark'),
  djibouti('Djibouti'),
  dominica('Dominica'),
  dominicanRepublic('Dominican Republic'),
  ecuador('Ecuador'),
  egypt('Egypt'),
  elSalvador('El Salvador'),
  equatorialGuinea('Equatorial Guinea'),
  eritrea('Eritrea'),
  estonia('Estonia'),
  ethiopia('Ethiopia'),
  falklandIslands('Falkland Islands'),
  faroeIslands('Faroe Islands'),
  fiji('Fiji'),
  finland('Finland'),
  france('France'),
  frenchGuiana('French Guiana'),
  frenchPolynesia('French Polynesia'),
  frenchSouthernAndAntarcticLands('French Southern and Antarctic Lands'),
  gabon('Gabon'),
  gambia('Gambia'),
  georgia('Georgia'),
  germany('Germany'),
  ghana('Ghana'),
  gibraltar('Gibraltar'),
  greece('Greece'),
  greenland('Greenland'),
  grenada('Grenada'),
  guadeloupe('Guadeloupe'),
  guam('Guam'),
  guatemala('Guatemala'),
  guernsey('Guernsey'),
  guinea('Guinea'),
  guineaBissau('Guinea-Bissau'),
  guyana('Guyana'),
  haiti('Haiti'),
  heardIslandAndMcDonaldIslands('Heard Island and McDonald Islands'),
  holySee('Holy See'),
  honduras('Honduras'),
  hongKong('Hong Kong'),
  hungary('Hungary'),
  iceland('Iceland'),
  india('India'),
  indonesia('Indonesia'),
  ireland('Ireland'),
  isleOfMan('Isle of Man'),
  israel('Israel'),
  italy('Italy'),
  jamaica('Jamaica'),
  japan('Japan'),
  jersey('Jersey'),
  jordan('Jordan'),
  kazakhstan('Kazakhstan'),
  kenya('Kenya'),
  kiribati('Kiribati'),
  kuwait('Kuwait'),
  kyrgyzstan('Kyrgyzstan'),
  laos('Laos'),
  latvia('Latvia'),
  lebanon('Lebanon'),
  lesotho('Lesotho'),
  liechtenstein('Liechtenstein'),
  lithuania('Lithuania'),
  luxembourg('Luxembourg'),
  macao('Macao'),
  macedonia('Macedonia'),
  madagascar('Madagascar'),
  malawi('Malawi'),
  malaysia('Malaysia'),
  maldives('Maldives'),
  mali('Mali'),
  malta('Malta'),
  marshallIslands('Marshall Islands'),
  martinique('Martinique'),
  mauritania('Mauritania'),
  mauritius('Mauritius'),
  mayotte('Mayotte'),
  mexico('Mexico'),
  micronesiaFederatedStatesOf('Micronesia, Federated States of'),
  moldova('Moldova'),
  monaco('Monaco'),
  mongolia('Mongolia'),
  montenegro('Montenegro'),
  montserrat('Montserrat'),
  morocco('Morocco'),
  mozambique('Mozambique'),
  myanmar('Myanmar'),
  namibia('Namibia'),
  nauru('Nauru'),
  nepal('Nepal'),
  netherlands('Netherlands'),
  netherlandsAntilles('Netherlands Antilles'),
  newCaledonia('New Caledonia'),
  newZealand('New Zealand'),
  nicaragua('Nicaragua'),
  niger('Niger'),
  nigeria('Nigeria'),
  niue('Niue'),
  norfolkIsland('Norfolk Island'),
  northernMarianaIslands('Northern Mariana Islands'),
  norway('Norway'),
  oman('Oman'),
  pakistan('Pakistan'),
  palau('Palau'),
  palestinianTerritories('Palestinian Territories'),
  panama('Panama'),
  papuaNewGuinea('Papua New Guinea'),
  paraguay('Paraguay'),
  peru('Peru'),
  philippines('Philippines'),
  pitcairn('Pitcairn'),
  poland('Poland'),
  portugal('Portugal'),
  puertoRico('Puerto Rico'),
  qatar('Qatar'),
  reunion('Reunion'),
  romania('Romania'),
  rwanda('Rwanda'),
  saintBarthelemy('Saint Barthelemy'),
  saintHelena('Saint Helena'),
  saintKittsAndNevis('Saint Kitts and Nevis'),
  saintLucia('Saint Lucia'),
  saintMartinFrenchPart('Saint Martin (French part)'),
  saintPierreAndMiquelon('Saint Pierre and Miquelon'),
  saintVincentAndTheGrenadines('Saint Vincent and the Grenadines'),
  samoa('Samoa'),
  sanMarino('San Marino'),
  saoTomeAndPrincipe('Sao Tome and Principe'),
  saudiArabia('Saudi Arabia'),
  senegal('Senegal'),
  serbia('Serbia'),
  seychelles('Seychelles'),
  sierraLeone('Sierra Leone'),
  singapore('Singapore'),
  sintMaartenDutchPart('Sint Maarten (Dutch part)'),
  slovakia('Slovakia'),
  slovenia('Slovenia'),
  solomonIslands('Solomon Islands'),
  somalia('Somalia'),
  southAfrica('South Africa'),
  southKorea('South Korea'),
  spain('Spain'),
  sriLanka('Sri Lanka'),
  suriname('Suriname'),
  svalbardAndJanMayen('Svalbard and Jan Mayen'),
  swaziland('Swaziland'),
  sweden('Sweden'),
  switzerland('Switzerland'),
  taiwan('Taiwan'),
  tajikistan('Tajikistan'),
  tanzania('Tanzania'),
  thailand('Thailand'),
  timorLeste('Timor-Leste'),
  togo('Togo'),
  tokelau('Tokelau'),
  tonga('Tonga'),
  trinidadAndTobago('Trinidad and Tobago'),
  tunisia('Tunisia'),
  turkey('Turkey'),
  turkmenistan('Turkmenistan'),
  turksAndCaicosIslands('Turks and Caicos Islands'),
  tuvalu('Tuvalu'),
  uganda('Uganda'),
  ukraine('Ukraine'),
  unitedArabEmirates('United Arab Emirates'),
  unitedKingdom('United Kingdom'),
  unitedStates('United States'),
  unitedStatesMinorOutlyingIslands('United States Minor Outlying Islands'),
  unitedStatesVirginIslands('United States Virgin Islands'),
  uruguay('Uruguay'),
  uzbekistan('Uzbekistan'),
  vanuatu('Vanuatu'),
  venezuela('Venezuela'),
  vietnam('Vietnam'),
  wallisAndFutuna('Wallis and Futuna'),
  westernSahara('Western Sahara'),
  yemen('Yemen'),
  zambia('Zambia'),
  zimbabwe('Zimbabwe');

  final String apiName;
  const Country(this.apiName);
}
