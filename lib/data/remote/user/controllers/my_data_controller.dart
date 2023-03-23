import 'package:get/get.dart';
import 'package:rolling_together/data/remote/auth/controller/firebase_auth_controller.dart';
import 'package:rolling_together/data/remote/grade/service/user_grade_service.dart';
import 'package:rolling_together/data/remote/user/service/report_list_service.dart';
import '../../dangerous_zone/likes/service/likes_dangerous_zone_service.dart';
import '../../dangerous_zone/models/dangerouszone.dart';
import '../models/user.dart';

class MyDataController extends GetxController {
  final ReportListService reportListService = ReportListService();
  final UserGradeService userGradeService = UserGradeService();
  final LikesDangerousZoneService likesDangerousZoneService =
      LikesDangerousZoneService();

  final String myUid = AuthController.to.myUserDto.value!.id!;

  final RxList<DangerousZoneDto> myLikesDangerousZoneList =
      RxList<DangerousZoneDto>();
  final RxList<DangerousZoneDto> mySharedDangerousZoneList =
      RxList<DangerousZoneDto>();


  /// 내가 공감한 위험 장소 목록 로드
  loadMyLikeDangerousZone() {
    reportListService.loadMyLikeDangerousZone(myUid).then((value) {
      myLikesDangerousZoneList.value = value;
    }, onError: (error) {
      myLikesDangerousZoneList.value = error;
    });
  }

  /// 내가 공유한 게시글 목록 로드
  loadMySharedDangerousZone() {
    reportListService.loadMySharedDangerousZone(myUid).then((value) {
      mySharedDangerousZoneList.value = value;
    }, onError: (error) {
      mySharedDangerousZoneList.value = error;
    });
  }

  /// 위험 장소 공감 클릭 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  likeDangerousZone(String dangerousZoneDocId, String userId) {
    likesDangerousZoneService
        .likeDangerousZone(dangerousZoneDocId, userId)
        .then((result) {
      // 위험 장소 데이터 리로드
      loadMySharedDangerousZone();
      loadMyLikeDangerousZone();
    }, onError: (obj) {});
  }

  /// 위험 장소 공감 클릭 해제 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  unlikeDangerousZone(String dangerousZoneDocId, String userId) {
    likesDangerousZoneService
        .unlikeDangerousZone(dangerousZoneDocId, userId)
        .then((result) {
      // 위험 장소 데이터 리로드
      loadMySharedDangerousZone();
      loadMyLikeDangerousZone();
    }, onError: (obj) {});
  }
}
