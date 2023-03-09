import 'dart:io';

import 'package:get/get.dart';
import 'package:rolling_together/commons/utils/img_file_utils.dart';
import 'package:rolling_together/data/remote/dangerous_zone/likes/service/likes_dangerous_zone_service.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/dangerous_zone/service/dangerous_zone_service.dart';
import 'package:rolling_together/data/remote/imgs/models/upload_img.dart';
import 'package:rolling_together/data/remote/user/service/report_list_service.dart';

import '../../imgs/service/img_upload_service.dart';
import '../models/dangerous_zone_comment.dart';

class DangerousZoneController extends GetxController {
  static const tag = 'DangerousZoneController';

  final DangerousZoneService dangerousZoneService = DangerousZoneService();
  final LikesDangerousZoneService likeListService = LikesDangerousZoneService();
  final ImgUploadService imgUploadService = ImgUploadService();
  final ReportListService reportListService = ReportListService();

  // 특정 위/경도 근처 위험 장소 리스트 맵
  final RxMap<String, DangerousZoneDto> dangerousZoneListMap =
      <String, DangerousZoneDto>{}.obs;

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

  final List<File> imageList = [];

  late List<double> latlng = [];
  late String myUIdInFirebase;
  late String myUserName;
  late DangerousZoneDto newDangerousZoneDto;

  /// 해당 위/경도 근처에 있는 위험 장소 목록 로드
  /// 공감 데이터 로드
  getDangerousZoneList(double latitude, double longitude) {
    dangerousZoneService.getDangerousZoneList(latitude, longitude).then(
        (dangerousZones) {
      // 위험 장소 목록 로드 성공
      // 위험 장소 id 목록
      final ids = dangerousZones.map((e) => e.id!).toList();

      // 공감 데이터 로드
      likeListService.getLikesDangerousZoneList(ids).then((likesMap) {
        final dangerousZoneMap = <String, DangerousZoneDto>{};

        for (final dto in dangerousZones) {
          dto.likes = likesMap[dto.id!];
          dangerousZoneMap[dto.id!] = dto;
        }

        // 모두 성공
        dangerousZoneListMap.value = dangerousZoneMap;
      }, onError: (obj) {
        dangerousZoneListMap.value = obj;
      });
    }, onError: (obj) {
      dangerousZoneListMap.value = obj;
    });
  }

  /// 단일 위험 장소 데이터 로드, 공감 데이터 로드
  getDangerousZone(String dangerousZoneDocId) {
    dangerousZoneService.getDangerousZone(dangerousZoneDocId).then(
        (dangerousZoneResult) {
      // 위험 장소 로드 성공
      // 위험 장소 id
      final docId = dangerousZoneResult.id!;

      // 공감 데이터 로드
      likeListService.getLikesDangerousZoneList([docId]).then((likesMap) {
        dangerousZoneResult.likes = likesMap[dangerousZoneResult.id!];
        // 모두 성공
        dangerousZone.value = dangerousZoneResult;
      }, onError: (obj) {
        dangerousZone.value = dangerousZoneResult;
      });
      dangerousZone.value = dangerousZoneResult;
    }, onError: (obj) {
      dangerousZone.value = null;
    });
  }

  /// 새로운 위험 장소 추가, 사진도 추가함
  addDangerousZone(DangerousZoneDto newDangerousZone, List<File> imgs) {
    final imageDtos = imgs
        .map((e) =>
            UploadImgDto(file: e, fileName: ImgFileUtils.convertFileName(e)))
        .toList();
    newDangerousZoneDto.tipOffPhotos =
        imageDtos.map((e) => e.fileName).toList();
    final result = dangerousZoneService.addDangerousZone(newDangerousZone);

    result.then((newDocId) {
      // 문서 id받음 -> 사진 추가, 유저 문서 내 위험 장소 제보 목록에 추가
      final uploadResult =
          imgUploadService.uploadImgs('dangerouszones', imageDtos);

      uploadResult.then((value) {
        reportListService
            .addDangerousZone(newDocId, newDangerousZone.informerId)
            .then((value) {
          // 문서 추가, 사진 추가, 내 제보 목록에 추가 모두 성공
          addNewDangerousZoneResult.value = true;
        }, onError: (obj) {
          // 내 목록에 추가 실패
          addNewDangerousZoneResult.value = false;
        });
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
