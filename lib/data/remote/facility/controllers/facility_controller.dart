import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolling_together/commons/utils/img_file_utils.dart';
import 'package:rolling_together/data/remote/facility/models/checklist.dart';
import 'package:rolling_together/data/remote/facility/service/facility_service.dart';
import 'package:rolling_together/data/remote/imgs/models/upload_img.dart';
import 'package:rolling_together/data/remote/search_places/models/places_response.dart';
import 'package:rolling_together/data/remote/user/service/report_list_service.dart';

import '../../../../commons/enum/facility_checklist.dart';
import '../../../../commons/enum/facility_types.dart';
import '../../imgs/service/img_upload_service.dart';
import '../models/facility.dart';
import '../models/review.dart';

class FacilityController extends GetxController {
  final imgUploadService = ImgUploadService();
  final facilityService = FacilityService();

  final TextEditingController reviewTextEditingController =
      TextEditingController();

  // 편의 시설 목록
  final RxList<FacilityDto> facilityList = <FacilityDto>[].obs;

  // 편의 시설
  final Rxn<FacilityDto> facility = Rxn();

  // 편의 시설 추가
  final RxBool updateFacilityResult = false.obs;

  // 모든 리뷰 목록
  final RxList<FacilityReviewDto> reviewList = <FacilityReviewDto>[].obs;

  LatLng? latLng;

  // 장소 검색 결과 선택한 장소
  Rxn<Place> selectedPlace = Rxn();

  FacilityDto? facilityDto;

  /// 체크 리스트 업데 이트 데이터
  Map<FacilityCheckListType, FacilityCheckListDto> newCheckListMap = {
    for (var key in FacilityCheckListType.toList())
      key: FacilityCheckListDto(type: key, imgUrls: [], status: false)
  };

  /// 해당 위/경도 근처에 있는 장소(편의 시설) 목록 로드
  getFacilityList(List<SharedDataCategory> facilityTypes, double latitude,
      double longitude) {
    final categoryIds = facilityTypes.map((e) => e.id).toList();
    facilityService.getFacilityList(categoryIds, latitude, longitude).then(
        (value) {
      facilityList.value = value;
    }, onError: (obj) {
      facilityList.value = obj;
    });
  }

  /// 단일 장소(편의 시설) 데이터 로드
  getFacility(String facilityPlaceId) {
    facilityService.getFacility(facilityPlaceId).then((value) {
      facility.value = value;
    }, onError: (obj) {
      facility.value = null;
    });
  }

  ///  편의 시설 정보 업데이트
  ///  장소 데이터가 fs에 있는지 확인
  ///  있으면 체크리스트는 업데이트, 없으면 새로 넣음
  updateFacility(FacilityDto facilityDto,
      Map<FacilityCheckListType, FacilityCheckListDto> checkListMap) {
    final Map<String, List<UploadImgDto>> imagesMap =
        createCheckListImgMap(checkListMap);

    // 모든 이미지 파일
    final images = <UploadImgDto>[];
    for (final value in imagesMap.values) {
      images.addAll(value);
    }

    final finalCheckListMap = <String, Map<String, dynamic>>{};

    for (final entry in newCheckListMap.entries) {
      finalCheckListMap[entry.key.fieldNameOnFirestore] = {
        'fileNames': imagesMap[entry.key.fieldNameOnFirestore]!
            .map((e) => e.fileName)
            .toList(),
        'status': entry.value.status
      };
    }

    facilityDto.checkListMap = finalCheckListMap;

    facilityService.updateFacility(facilityDto).then((value) {
      // 편의시설 업데이트 완료 -> 이미지 업로드

      imgUploadService.uploadImgs('facilitychecklist', images).then((value) {
        updateFacilityResult.value = true;
      }, onError: (obj) {
        updateFacilityResult.value = true;
      });
    }, onError: (obj) {
      updateFacilityResult.value = false;
    });
  }

  /// 리뷰 추가
  addReview(FacilityReviewDto reviewDto, String facilityPlaceId) {
    facilityService.addReview(reviewDto, facilityPlaceId).then((value) {
      getAllReviews(facilityPlaceId);
    }, onError: (obj) {});
  }

  ///  모든 리뷰 로드
  getAllReviews(String facilityPlaceId) {
    facilityService.getAllReviews(facilityPlaceId).then((value) {
      reviewList.value = value;
    }, onError: (obj) {
      reviewList.value = obj;
    });
  }

  /// 체크 리스트 항목 별로 이미지 파일 목록 맵을 받음
  /// 항목 별로 이미지 파일 데이터(파일, 파일명)을 가진 맵을 반환
  createCheckListImgMap(Map<FacilityCheckListType, FacilityCheckListDto> map) {
    Map<String, List<UploadImgDto>> imageFileNamesMap = {};

    for (var entry in map.entries) {
      imageFileNamesMap[entry.key.fieldNameOnFirestore] = [];

      for (var value in entry.value.files) {
        imageFileNamesMap[entry.key.fieldNameOnFirestore]!.add(UploadImgDto(
            file: value, fileName: ImgFileUtils.convertFileName(value)));
      }
    }

    return imageFileNamesMap;
  }
}
