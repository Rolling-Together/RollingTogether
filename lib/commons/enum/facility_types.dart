import 'package:rolling_together/commons/class/facility_tile.dart';

enum FacilityType {
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
  undefined('-1', '정의되지않음');

  const FacilityType(this.id, this.name);

  final String id;
  final String name;

  factory FacilityType.getByFieldName(String fieldName) =>
      FacilityType.values.firstWhere((element) => element.id == fieldName,
          orElse: () => FacilityType.undefined);
}
