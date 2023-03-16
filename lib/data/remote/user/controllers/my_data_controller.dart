import 'package:get/get.dart';
import 'package:rolling_together/data/remote/auth/controller/firebase_auth_controller.dart';
import 'package:rolling_together/data/remote/grade/service/user_grade_service.dart';
import 'package:rolling_together/data/remote/user/service/report_list_service.dart';

import '../../dangerous_zone/models/dangerouszone.dart';
import '../models/user.dart';

class MyDataController extends GetxController {
  final ReportListService reportListService = ReportListService();
  final UserGradeService userGradeService = UserGradeService();

  final Rxn<UserDto> myUserDto = Rxn();

  final RxList<DangerousZoneDto> myLikesDangerousZoneList =
      RxList<DangerousZoneDto>();
  final RxList<DangerousZoneDto> mySharedDangerousZoneList =
      RxList<DangerousZoneDto>();

  @override
  void onInit() {
    loadMyUserData();
    super.onInit();
  }

  loadMyUserData() {
    final String myUid = AuthController.to.user!.uid;

    reportListService.loadMyUserData(myUid).then((myUserData) {
      userGradeService.getUserGrade(myUid).then((grade) {
        myUserData?.userGradeDto = grade;
        myUserDto.value = myUserData;
      }, onError: (obj) {});
    }, onError: (error) {
      Get.snackbar("내 정보 로드 실패", error.toString());
    });
  }

  /// 내가 공감한 위험 장소 목록 로드
  loadMyLikeDangerousZone() async {
    reportListService.loadMyLikeDangerousZone(AuthController.to.user!.uid).then(
        (value) {
      myLikesDangerousZoneList.value = value;
    }, onError: (error) {
      myLikesDangerousZoneList.value = error;
    });
  }

  /// 내가 공유한 게시글 목록 로드
  loadMySharedDangerousZone() {
    reportListService
        .loadMySharedDangerousZone(AuthController.to.user!.uid)
        .then((value) {
      mySharedDangerousZoneList.value = value;
    }, onError: (error) {
      mySharedDangerousZoneList.value = error;
    });
  }
}
