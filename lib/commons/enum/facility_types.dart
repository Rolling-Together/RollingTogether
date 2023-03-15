enum FacilityType {
  restaurantCafe('0'),
  healthCare('1'),
  cultureSports('2'),
  accommodation('3'),
  publicEducation('4'),
  welFare('5'),
  commercialProperty('6'),
  transportation('7'),
  undefined('-1');

  const FacilityType(this.id);

  final String id;

  factory FacilityType.getByFieldName(String fieldName) => FacilityType.values
      .firstWhere((element) => element.id == fieldName,
          orElse: () => FacilityType.undefined);
}
