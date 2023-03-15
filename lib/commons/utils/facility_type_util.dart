import 'package:flutter/material.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';

class FacilityTypeUtil {
  static final restaurantCafeCodes = <String>{'FD6', 'CE7'};
  static final healthCareCodes = <String>{'HP8', 'PM9'};
  static final cultureSportsCodes = <String>{'CT1', '헬스', '체육'};
  static final accommodationCodes = <String>{'AD5'};

  static final publicEducationCodes = <String>{'SC4', 'AC5', 'PO3', '교육'};
  static final welFareCodes = <String>{'공공', '사회'};
  static final commercialPropertyCodes = <String>{'상가'};
  static final transportationCodes = <String>{'PK6', 'OL7'};

  /// 카카오 장소 검색 결과에 대하여 카테 고리 타입 반환
  static FacilityType toEnum(String categoryGroupCode, String categoryName) {
    if (categoryGroupCode.isEmpty && categoryName.isEmpty) {
      return FacilityType.undefined;
    }

    if (restaurantCafeCodes.contains(categoryGroupCode) ||
        restaurantCafeCodes.contains(categoryName)) {
      return FacilityType.restaurantCafe;
    } else if (healthCareCodes.contains(categoryGroupCode) ||
        healthCareCodes.contains(categoryName)) {
      return FacilityType.healthCare;
    } else if (cultureSportsCodes.contains(categoryGroupCode) ||
        cultureSportsCodes.contains(categoryName)) {
      return FacilityType.cultureSports;
    } else if (accommodationCodes.contains(categoryGroupCode) ||
        accommodationCodes.contains(categoryName)) {
      return FacilityType.accommodation;
    } else if (publicEducationCodes.contains(categoryGroupCode) ||
        publicEducationCodes.contains(categoryName)) {
      return FacilityType.publicEducation;
    } else if (welFareCodes.contains(categoryGroupCode) ||
        welFareCodes.contains(categoryName)) {
      return FacilityType.welFare;
    } else if (commercialPropertyCodes.contains(categoryGroupCode) ||
        commercialPropertyCodes.contains(categoryName)) {
      return FacilityType.commercialProperty;
    } else {
      return FacilityType.transportation;
    }
  }
}
