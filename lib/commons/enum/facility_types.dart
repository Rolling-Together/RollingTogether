enum SharedDataCategory {
  /// 음식점, 카페
  restaurantCafe('0', '음식점, 카페'),

  /// 보건의료시설
  healthCare('1', '보건의료시설'),

  /// 문화체육시설
  cultureSports('2', '문화체육시설'),

  /// 숙박시설
  accommodation('3', '숙박시설'),

  /// 공공교육시설
  publicEducation('4', '공공교육시설'),

  /// 복지시설
  welFare('5', '복지시설'),

  /// 상가시설
  commercialProperty('6', '상가시설'),

  /// 교통시설
  transportation('7', '교통시설'),

  /// 대중 교통
  publicTransport('8', '대중 교통'),

  /// 편의 시설
  facility('9', '편의 시설'),

  /// 위험 장소
  dangerousZone('10', '위험 장소'),

  /// 정의 되지 않음
  undefined('-1', '정의 되지 않음'),

  /// 전체
  all('11', '전체');

  const SharedDataCategory(this.id, this.name);

  final String id;
  final String name;

  factory SharedDataCategory.getByFieldName(String fieldName) =>
      SharedDataCategory.values.firstWhere((element) => element.id == fieldName,
          orElse: () => SharedDataCategory.undefined);

  static List<SharedDataCategory> toList() => [
        SharedDataCategory.restaurantCafe,
        SharedDataCategory.healthCare,
        SharedDataCategory.cultureSports,
        SharedDataCategory.accommodation,
        SharedDataCategory.publicEducation,
        SharedDataCategory.welFare,
        SharedDataCategory.commercialProperty,
        SharedDataCategory.transportation,
        SharedDataCategory.publicTransport
      ];
}
