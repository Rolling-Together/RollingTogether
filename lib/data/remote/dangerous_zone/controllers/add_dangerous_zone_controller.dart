import 'dart:io';

import 'package:get/get.dart';
import 'package:rolling_together/commons/utils/img_file_utils.dart';
import 'package:rolling_together/data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';
import 'package:rolling_together/data/remote/dangerous_zone/likes/service/likes_dangerous_zone_service.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/dangerous_zone/service/dangerous_zone_service.dart';
import 'package:rolling_together/data/remote/imgs/models/upload_img.dart';
import 'package:rolling_together/data/remote/user/service/report_list_service.dart';

import '../../imgs/service/img_upload_service.dart';
import '../models/dangerous_zone_comment.dart';

class AddDangerousZoneController extends DangerousZoneController {
  static const tag = 'AddDangerousZoneController';

  // 새로운 위험 장소 추가 결과
  final RxBool addNewDangerousZoneResult = false.obs;

  final imageList = <File>[];

  late var latlng = <double>[];
  late String myUIdInFirebase;
  late String myUserName;

  initData(List<double> latlng, String myUIdInFirebase, String myUserName) {
    this.latlng = latlng;
    this.myUIdInFirebase = myUIdInFirebase;
    this.myUserName = myUserName;
  }

  /// 새로운 위험 장소 추가, 사진도 추가함
  addDangerousZone(DangerousZoneDto newDangerousZone, List<File> imgs) {
    final imageDtos = imgs
        .map((e) =>
        UploadImgDto(file: e, fileName: ImgFileUtils.convertFileName(e)))
        .toList();

    newDangerousZone.tipOffPhotos =
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
}
