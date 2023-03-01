import 'dart:io';
import 'dart:js_util';

import 'package:get/get.dart';
import 'package:rolling_together/data/remote/facility/service/facility_service.dart';
import 'package:rolling_together/data/remote/user/service/like_list_service.dart';

import '../../../../commons/enum/facility_types.dart';
import '../../dangerous_zone/models/enum/facility_checklist_types.dart';
import '../../imgs/img_upload_service.dart';
import '../models/facility.dart';
import '../models/review.dart';

class FacilityController extends GetxController {
  final LikeListService likeListService = LikeListService();
  final ImgUploadService imgUploadService = ImgUploadService();
  final FacilityService facilityService = FacilityService();

  // 편의 시설 목록
  final RxList<FacilityDto> facilityList = <FacilityDto>[].obs;

  // 편의 시설
  final Rx<FacilityDto?> facility = FacilityDto(
      placeId: '',
      name: '',
      latitude: '',
      longitude: '',
      categoryName: '',
      categoryGroupCode: '',
      categoryGroupName: '',
      addressName: '',
      roadAddressName: '',
      placeUrl: '',
      checkListMap: {}).obs;

  // 편의 시설 추가
  final RxBool addFacilityResult = false.obs;

  // 편의 시설 체크 리스트 업데이트
  final RxBool updateCheckListResult = false.obs;

  // 리뷰 추가
  final RxBool addReviewResult = false.obs;

  // 모든 리뷰 목록
  final RxList<FacilityReviewDto> reviewList = <FacilityReviewDto>[].obs;

  /// 해당 위/경도 근처에 있는 장소(편의 시설) 목록 로드
  getFacilityList(
      List<FacilityType> facilityTypes, double latitude, double longitude) {
    final categoryIds = facilityTypes.map((e) => e.id).toList();
    facilityService.getFacilityList(categoryIds, latitude, longitude).then(
        (value) {
      facilityList.value = value;
    }, onError: (obj) {
      facilityList.value = obj;
    });
  }

  /// 단일 장소(편의시설) 데이터 로드
  getFacility(String facilityPlaceId) {
    facilityService.getFacility(facilityPlaceId).then((value) {
      facility.value = value;
    }, onError: (obj) {
      facility.value = null;
    });
  }

  /// 새로운 편의 시설 추가
  addFacility(FacilityDto facilityDto, List<File> images) {
    facilityService.addFacility(facilityDto).then((value) {
      // 편의시설 추가 완료 -> 이미지 추가
      imgUploadService.uploadImgs('facilitychecklist', images).then((value) {
        addFacilityResult.value = true;
      }, onError: (obj) {
        addFacilityResult.value = true;
      });
    }, onError: (obj) {
      addFacilityResult.value = false;
    });
  }

  /// 편의 시설 체크 리스트만 업데이트
  /// 이미지도 추가
  updateCheckList(FacilityDto facilityDto, List<File> images) {
    facilityService.updateCheckList(facilityDto).then((value) {
      // 업데이트 완료 -> 이미지 추가
      imgUploadService.uploadImgs('facilitychecklist', images).then((value) {
        updateCheckListResult.value = true;
      }, onError: (obj) {
        updateCheckListResult.value = true;
      });
    }, onError: (obj) {
      updateCheckListResult.value = false;
    });
  }

  /// 리뷰 추가
  addReview(FacilityReviewDto reviewDto, String facilityPlaceId) {
    facilityService.addReview(reviewDto, facilityPlaceId).then((value) {
      addReviewResult.value = true;
    }, onError: (obj) {
      addReviewResult.value = false;
    });
  }

  ///  모든 리뷰 로드
  getAllReviews(String facilityPlaceId) {
    facilityService.getAllReviews(facilityPlaceId).then((value) {
      reviewList.value = value;
    }, onError: (obj) {
      reviewList.value = obj;
    });
  }
}
