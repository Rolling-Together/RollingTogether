import 'package:get/get.dart';
import 'package:rolling_together/data/remote/grade/models/user_grade.dart';
import 'package:rolling_together/data/remote/grade/service/user_grade_service.dart';

class UserGradeController extends GetxController {
  final userGradeService = UserGradeService();

  // 유저 등급
  final Rx<UserGradeDto?> userGrade =
      UserGradeDto(userId: '', reportCount: 0).obs;

  // 유저 등급 로드
  getUserGrade(String userId) {
    userGradeService.getUserGrade(userId).then((value) {
      userGrade.value = value;
    }, onError: (obj) {
      userGrade.value = null;
    });
  }
}
