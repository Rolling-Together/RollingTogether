import 'dart:io';

import 'package:get/get.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/dangerous_zone/service/dangerous_zone_service.dart';
import 'package:rolling_together/data/remote/imgs/img_upload_service.dart';
import 'package:rolling_together/data/remote/user/service/like_list_service.dart';

import '../models/dangerous_zone_comment.dart';

class DangerousZoneController extends GetxController {
  final DangerousZoneService dangerousZoneService = DangerousZoneService();
  final LikeListService likeListService = LikeListService();
  final ImgUploadService imgUploadService = ImgUploadService();

  // 위경도 근처 내 위험 장소 리스트
  final RxList<DangerousZoneDto> dangerousZoneList = <DangerousZoneDto>[].obs;

  // 조회한 단일 위험 장소
  final Rx<DangerousZoneDto?> dangerousZone = DangerousZoneDto(
          categoryId: '',
          description: '',
          latlng: [],
          informerId: '',
          tipOffPhotos: [],
          informerName: '')
      .obs;

  // 새로운 위험 장소 추가 결과
  final RxBool addNewDangerousZoneResult = false.obs;

  // 댓글 등록 결과
  final RxBool addCommentResult = false.obs;

  // 댓글 목록
  final RxList<DangerousZoneCommentDto> commentList =
      <DangerousZoneCommentDto>[].obs;

  /// 해당 위/경도 근처에 있는 위험 장소 목록 로드
  getDangerousZoneList(double latitude, double longitude) {
    final list = dangerousZoneService.getDangerousZoneList(latitude, longitude);

    list.then((value) {
      dangerousZoneList.value = value;
    }, onError: (obj) {
      dangerousZoneList.value = obj;
    });
  }

  /// 단일 위험 장소 데이터 로드
  getDangerousZone(String dangerousZoneDocId) {
    final result = dangerousZoneService.getDangerousZone(dangerousZoneDocId);

    result.then((value) {
      dangerousZone.value = value;
    }, onError: (obj) {
      dangerousZone.value = null;
    });
  }

  /// 새로운 위험 장소 추가
  /// 사진도 추가함
  addDangerousZone(DangerousZoneDto newDangerousZone, List<File> imgs) {
    final result = dangerousZoneService.addDangerousZone(newDangerousZone);

    result.then((newDocId) {
      // 문서 id받음 -> 사진 추가
      final uploadResult = imgUploadService.uploadImgs('dangerouszones', imgs);

      uploadResult.then((value) {
        // 문서 추가, 사진 추가 모두 성공
        addNewDangerousZoneResult.value = true;
      }, onError: (obj) {
        // 사진 추가 실패
        addNewDangerousZoneResult.value = false;
      });
    }, onError: (obj) {
      // 문서 추가 실패
      addNewDangerousZoneResult.value = false;
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
}
