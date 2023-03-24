import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_grade.dart';

class UserGradeService {
  final firestore = FirebaseFirestore.instance;

  /// 유저 등급을 반환
  Future<UserGradeDto> getUserGrade(String userId) async {
    try {
      final response = await firestore
          .collection('DangerousZone')
          .where('informerId', isEqualTo: userId)
          .get();

      final reportCount = response.size;
      int r = 0;
      int g = 0;
      int b = 0;

      // 제보 10개 이상 : 금 255 215 0
      // 제보 10개 미만 3개 초과 : 은 192 192 192
      // 제보 3개 이하 : 동 205 127 50
      if (reportCount >= 10) {
        r = 255;
        g = 215;
        b = 0;
      } else if (reportCount > 3) {
        r = 192;
        g = 192;
        b = 192;
      } else {
        r = 205;
        g = 127;
        b = 50;
      }

      final userGrade = UserGradeDto(
          userId: userId,
          reportCount: reportCount,
          iconColor: Color.fromARGB(255, r, g, b));
      return Future.value(userGrade);
    } catch (e) {
      return Future.error('failed');
    }
  }
}
