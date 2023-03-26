import 'package:flutter/material.dart';

enum SharedDataCategory {
  /// 음식점, 카페
  restaurantCafe('0', '음식점, 카페', 'assets/images/restaurant_marker_icon.png',
      Icons.restaurant),

  /// 보건의료시설
  healthCare('1', '보건의료시설', 'assets/images/healthcare_marker_icon.png',
      Icons.local_hospital),

  /// 문화체육시설
  cultureSports('2', '문화체육시설', 'assets/images/culture_sports_marker_icon.png',
      Icons.museum),

  /// 숙박시설
  accommodation(
      '3', '숙박시설', 'assets/images/accommodation_marker_icon.png', Icons.bed),

  /// 공공교육시설
  publicEducation('4', '공공교육시설',
      'assets/images/public_education_marker_icon.png', Icons.school),

  /// 복지시설
  welFare('5', '복지 시설', 'assets/images/welfare_marker_icon.png', Icons.people),

  /// 상가시설
  commercialProperty(
      '6',
      '상가 시설',
      'assets/images/commercial_property_marker_icon'
          '.png',
      Icons.store),

  /// 교통시설
  transportation(
      '7',
      '교통 시설',
      'assets/images/transportation_marker_icon'
          '.png',
      Icons.emoji_transportation),

  /// 대중 교통
  publicTransport('8', '대중 교통', '', Icons.emoji_transportation),

  /// 편의 시설
  facility('', '편의 시설', '', Icons.local_convenience_store_rounded),

  /// 위험 장소
  dangerousZone('', '위험 장소', 'assets/images/dangerous_zone_marker_icon.png',
      Icons.dangerous_rounded),

  /// 버스 정류장
  busStop('', '버스 정류장', 'assets/images/busstop_marker_icon.png',
      Icons.directions_bus_rounded),

  /// 지하철 역
  metroStation('', '지하철 역', 'assets/images/metro_station_marker_icon.png',
      Icons.train_rounded),

  /// 정의 되지 않음
  undefined('', '정의 되지 않음', '', Icons.close),

  /// 전체
  all('100', '모두 보기', '', Icons.all_inclusive_rounded);

  const SharedDataCategory(this.id, this.name, this.iconPath, this.iconData);

  final String id;
  final String name;
  final String iconPath;
  final IconData iconData;

  factory SharedDataCategory.getByFieldName(String fieldName) =>
      SharedDataCategory.values.firstWhere((element) => element.id == fieldName,
          orElse: () => SharedDataCategory.undefined);

  static List<SharedDataCategory> toList() => [
        SharedDataCategory.all,
        SharedDataCategory.restaurantCafe,
        SharedDataCategory.healthCare,
        SharedDataCategory.cultureSports,
        SharedDataCategory.accommodation,
        SharedDataCategory.publicEducation,
        SharedDataCategory.welFare,
        SharedDataCategory.commercialProperty,
        SharedDataCategory.transportation,
      ];
}
