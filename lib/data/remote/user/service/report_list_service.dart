import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/user/models/user.dart';

import '../../dangerous_zone/models/dangerouszone.dart';
import '../../facility/models/facility.dart';

class ReportListService {
  final firestore = FirebaseFirestore.instance;

  /// 내 정보 로드
  Future<UserDto?> loadMyUserData(String myUid) async {
    try {
      final result = await firestore.collection('Users').doc(myUid).get();
      return Future.value(UserDto.fromSnapshot(result));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 내가 공감한 위험 장소 목록 로드
  Future<List<DangerousZoneDto>> loadMyLikeDangerousZone(String myUid) async {
    try {
      final response = await firestore
          .collection('DangerousZone')
          .where('likes', arrayContains: myUid)
          .get();

      return Future.value(
          response.docs.map((e) => DangerousZoneDto.fromSnapshot(e)).toList());
    } catch (e) {
      return Future.value(List.empty());
    }
  }

  /// 내가 공유한 게시글 목록 로드
  Future<List<DangerousZoneDto>> loadMySharedDangerousZone(String myUid) async {
    try {
      final response = await firestore
          .collection('DangerousZone')
          .where('informerId', isEqualTo: myUid)
          .get();

      return Future.value(
          response.docs.map((e) => DangerousZoneDto.fromSnapshot(e)).toList());
    } catch (e) {
      return Future.value(List.empty());
    }
  }
}
