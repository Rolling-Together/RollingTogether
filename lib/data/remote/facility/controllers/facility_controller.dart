import 'package:get/get.dart';
import 'package:rolling_together/data/remote/facility/service/facility_service.dart';
import 'package:rolling_together/data/remote/user/service/like_list_service.dart';

import '../../../../commons/enum/facility_types.dart';
import '../../imgs/img_upload_service.dart';
import '../models/facility.dart';

class FacilityController extends GetxController {
  final LikeListService likeListService = LikeListService();
  final ImgUploadService imgUploadService = ImgUploadService();
  final FacilityService facilityService = FacilityService();

  // 편의 시설 목록
  final RxList<FacilityDto> facilityList = <FacilityDto>[].obs;

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
}
