import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_grade.dart';

class UserGradeService {
  final firestore = FirebaseFirestore.instance;

  /// 유저 등급을 반환
  Future<UserGradeDto> getUserGrade(String userId) async {
    try {
      final result = await firestore.collection('Users').doc(userId).get();

      if (result.exists) {
        final List<String> reportList =
            result.data()?['dangerousZoneReportList'];
        final userGrade =
            UserGradeDto(userId: userId, reportCount: reportList.length);
        // 제보 횟수에 따른 등급 분류 표가 없음

        return Future.value(userGrade);
      } else {
        return Future.error('failed');
      }
    } catch (e) {
      return Future.error('failed');
    }
  }
}
