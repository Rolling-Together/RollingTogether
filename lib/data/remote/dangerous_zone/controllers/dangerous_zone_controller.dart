import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rolling_together/commons/utils/coords_dist_util.dart';
import 'package:rolling_together/data/remote/dangerous_zone/likes/service/likes_dangerous_zone_service.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/dangerous_zone/service/dangerous_zone_service.dart';

import '../../imgs/service/img_upload_service.dart';
import '../models/dangerous_zone_comment.dart';

class DangerousZoneController extends GetxController {
  static const tag = 'DangerousZoneController';

  final DangerousZoneService dangerousZoneService = DangerousZoneService();
  final LikesDangerousZoneService likeListService = LikesDangerousZoneService();
  final ImgUploadService imgUploadService = ImgUploadService();

  // 특정 위/경도 근처 위험 장소 리스트 맵
  final RxMap<String, DangerousZoneDto> dangerousZoneListMap =
      <String, DangerousZoneDto>{}.obs;

  // 조회한 단일 위험 장소
  final Rxn<DangerousZoneDto> dangerousZone = Rxn();

  // 댓글 등록 결과
  final RxBool addCommentResult = false.obs;

  // 댓글 목록
  final RxList<DangerousZoneCommentDto> commentList =
      <DangerousZoneCommentDto>[].obs;

  /// 지도 중심부 마지막 위경도
  Rx<List<double>> lastLatLng = Rx([35.4348, 129.1009]);

  /// 해당 위/경도 근처에 있는 위험 장소 목록 로드
  getDangerousZoneList(double latitude, double longitude, bool force) {
    // 마지막 지도 중심 좌표 값과의 거리가 1km 내외면 업데이트 안함
    if (!force) {
      final dist = haversineDistance(
          lastLatLng.value[0], lastLatLng.value[1], latitude, longitude);
      if (dist < 1000.0) {
        return;
      }
    }

    lastLatLng.value = [latitude, longitude];

    dangerousZoneService.getDangerousZoneList(latitude, longitude).then(
        (dangerousZones) {
      // 위험 장소 목록 로드 성공
      // 위험 장소 id 목록

      final dangerousZoneMap = <String, DangerousZoneDto>{};

      for (final dto in dangerousZones) {
        dangerousZoneMap[dto.id!] = dto;
      }

      //  성공
      dangerousZoneListMap.value = dangerousZoneMap;
    }, onError: (obj) {
      dangerousZoneListMap.value = obj;
    });
  }

  /// 단일 위험 장소 데이터 로드, 공감 데이터 로드
  getDangerousZone(String dangerousZoneDocId) {
    dangerousZoneService.getDangerousZone(dangerousZoneDocId).then(
        (dangerousZoneResult) {
      // 위험 장소 로드 성공

      dangerousZone.value = dangerousZoneResult;
    }, onError: (obj) {
      dangerousZone.value = null;
    });
  }

  /// 댓글 추가
  addComment(DangerousZoneCommentDto commentDto, String dangerousZoneDocId) {
    dangerousZoneService.addComment(commentDto, dangerousZoneDocId).then(
        (value) {
      addCommentResult.value = true;
    }, onError: (obj) {
      addCommentResult.value = false;
    });
  }

  /// 모든 댓글 내용 로드
  getAllComments(String dangerousZoneDocId) {
    dangerousZoneService.getAllComments(dangerousZoneDocId).then((value) {
      commentList.value = value;
    }, onError: (obj) {
      commentList.value = obj;
    });
  }

  /// 위험 장소 공감 클릭 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  likeDangerousZone(String dangerousZoneDocId, String userId, String userName) {
    likeListService
        .likeDangerousZone(dangerousZoneDocId, userId, userName)
        .then((result) {
      // 위험 장소 데이터 리로드
      getDangerousZone(dangerousZoneDocId);
    }, onError: (obj) {});
  }

  /// 위험 장소 공감 클릭 해제 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  unlikeDangerousZone(String dangerousZoneDocId, String userId) {
    likeListService.unlikeDangerousZone(dangerousZoneDocId, userId).then(
        (result) {
      // 위험 장소 데이터 리로드
      getDangerousZone(dangerousZoneDocId);
    }, onError: (obj) {});
  }
}
