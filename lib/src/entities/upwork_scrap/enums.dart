import 'package:pascoa_scout/src/core/extensions/string_extensions.dart';

enum JobType {
  fixed('fixed'),
  hourly('hourly');

  final String apiName;
  const JobType(this.apiName);

  static JobType fromApifyName(Map<String, dynamic> json) {
    return JobType.values.firstWhere(
      (e) => e.apiName == (json['jobType'] as String),
      orElse: () => throw ArgumentError('Unknown job type: ${json['jobType']}'),
    );
  }
}

enum ExperienceLevel {
  entryLevel('entry'),
  intermediate('intermediate'),
  expert('expert');

  final String apiName;
  const ExperienceLevel(this.apiName);

  static ExperienceLevel fromApifyName(Map<String, dynamic> json) {
    return ExperienceLevel.values.firstWhere(
      (e) => e.apiName == (json['experienceLevel'] as String),
      orElse: () => throw ArgumentError(
        'Unknown experience level: ${json['experienceLevel']}',
      ),
    );
  }
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

  static Region? fromName(String name) {
    final normalizedName = name.normalized;
    return Region.values.firstWhere(
      (e) => e.apiName.normalized == normalizedName,
      orElse: () => throw ArgumentError('Unknown region: $name'),
    );
  }

  static Region? fromApifyJson(Map<String, dynamic> json) {
    final clientLocalization = (json['clientLocation'] as String).normalized;
    return Region.fromName(clientLocalization);
  }
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

  static SubRegion? fromName(String name) {
    final normalizedName = name.normalized;
    return SubRegion.values.firstWhere(
      (e) => e.apiName.normalized == normalizedName,
      orElse: () => throw ArgumentError('Unknown subregion: $name'),
    );
  }

  static SubRegion? fromApifyJson(Map<String, dynamic> json) {
    final clientLocalization = (json['clientLocation'] as String).normalized;
    return SubRegion.fromName(clientLocalization);
  }
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

  static Country? fromName(String name) {
    final normalizedJson = name.normalized;
    return Country.values.firstWhere(
      (e) => e.apiName.normalized == normalizedJson,
      orElse: () => throw ArgumentError('Unknown country: $name'),
    );
  }

  static Country? fromApifyJson(Map<String, dynamic> json) {
    final clientLocalization = (json['clientLocation'] as String).normalized;
    return Country.fromName(clientLocalization);
  }
}
