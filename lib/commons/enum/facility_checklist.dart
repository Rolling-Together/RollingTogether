import 'package:flutter/material.dart';

enum FacilityCheckListType {
  wheelChair('wheelchair', '휠체어 접근 가능성', 0, Icons.accessible),
  toilet('toilet', '1층에 위치함', 1, Icons.looks_one),
  floorFirst('floor_first', '장애인 화장실', 2, Icons.wc),
  elevator('elevator', '엘리베이터', 3, Icons.elevator),
  undefined('-', '정의되지않음', -1, Icons.close);

  const FacilityCheckListType(
      this.fieldNameOnFirestore, this.description, this.idx, this.icon);

  final String fieldNameOnFirestore;
  final String description;
  final int idx;
  final IconData icon;

  factory FacilityCheckListType.getByFieldName(String fieldName) =>
      FacilityCheckListType.values.firstWhere(
          (element) => element.fieldNameOnFirestore == fieldName,
          orElse: () => FacilityCheckListType.undefined);

  static List<FacilityCheckListType> toList() => [
        FacilityCheckListType.wheelChair,
        FacilityCheckListType.toilet,
        FacilityCheckListType.floorFirst,
        FacilityCheckListType.elevator
      ];
}
