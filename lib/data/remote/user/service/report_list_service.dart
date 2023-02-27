import 'package:cloud_firestore/cloud_firestore.dart';

class ReportListService {
  final firestore = FirebaseFirestore.instance;

  /// 위험 장소 추가 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> addDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      await firestore.collection('Users').doc(userId).update({
        'dangerousZoneReportList': FieldValue.arrayUnion([dangerousZoneDocId])
      });
    } catch (e) {
      rethrow;
    }
  }

  /// 위험 장소 제거 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> removeDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      await firestore.collection('Users').doc(userId).update({
        'dangerousZoneReportList': FieldValue.arrayRemove([dangerousZoneDocId])
      });
    } catch (e) {
      rethrow;
    }
  }

  /// 편의시설 추가 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> addFacility(String placeId, String userId) async {
    try {
      await firestore.collection('Users').doc(userId).update({
        'facilityReportList': FieldValue.arrayUnion([placeId])
      });
    } catch (e) {
      rethrow;
    }
  }

  /// 편의시설 제거 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> removeFacility(String placeId, String userId) async {
    try {
      await firestore.collection('Users').doc(userId).update({
        'facilityReportList': FieldValue.arrayRemove([placeId])
      });
    } catch (e) {
      rethrow;
    }
  }

  /// 버스 정보 추가 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> addBusInfo(
      String carDocId, String areaCode, String routeId, String userId) async {
    try {
      await firestore.collection('Users').doc(userId).update({
        'busReportListMap.$carDocId': {'areaCode': areaCode, 'routeId': routeId}
      });
    } catch (e) {
      rethrow;
    }
  }

  /// 버스 정보 제거 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> removeBusInfo(
      String carDocId, String areaCode, String routeId, String userId) async {
    try {
      await firestore
          .collection('Users')
          .doc(userId)
          .update({'busReportListMap.$carDocId': FieldValue.delete()});
    } catch (e) {
      rethrow;
    }
  }
}
