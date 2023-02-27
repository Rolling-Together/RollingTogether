import 'package:cloud_firestore/cloud_firestore.dart';

class LikeListService {
  final firestore = FirebaseFirestore.instance;

  /// 위험 장소 공감 클릭 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> likeDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      await firestore.collection('Users').doc(userId).update({
        'dangerousZoneLikeList': FieldValue.arrayUnion([dangerousZoneDocId])
      });
    } catch (e) {
      rethrow;
    }
  }

  /// 위험 장소 공감 클릭 해제 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> unlikeDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      await firestore.collection('Users').doc(userId).update({
        'dangerousZoneLikeList': FieldValue.arrayRemove([dangerousZoneDocId])
      });
    } catch (e) {
      rethrow;
    }
  }


}
