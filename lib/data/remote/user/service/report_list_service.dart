import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/bus/models/bus.dart';

class ReportListService {
  final firestore = FirebaseFirestore.instance;

  /// 위험 장소 추가 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> addDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      return await Future.value(
          firestore.collection('Users').doc(userId).update({
        'dangerousZoneReportList': FieldValue.arrayUnion([dangerousZoneDocId])
      }));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 위험 장소 제거 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> removeDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      return await Future.value(
          firestore.collection('Users').doc(userId).update({
        'dangerousZoneReportList': FieldValue.arrayRemove([dangerousZoneDocId])
      }));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 편의시설 추가 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> addFacility(String placeId, String userId) async {
    try {
      return await Future.value(
          firestore.collection('Users').doc(userId).update({
        'facilityReportList': FieldValue.arrayUnion([placeId])
      }));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 편의시설 제거 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> removeFacility(String placeId, String userId) async {
    try {
      return await Future.value(
          firestore.collection('Users').doc(userId).update({
        'facilityReportList': FieldValue.arrayRemove([placeId])
      }));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 버스 정보 추가 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> updateBusInfo(BusDto busDto) async {
    try {
      return await Future.value(
          firestore.collection('Users').doc(busDto.informerId).set({
        'busReportListMap.${busDto.id}': {
          'cityCode': busDto.cityCode,
          'routeId': busDto.routeId
        }
      }));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 버스 정보 제거 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> removeBusInfo(String carDocId, String userId) async {
    try {
      return await Future.value(firestore
          .collection('Users')
          .doc(userId)
          .update({'busReportListMap.$carDocId': FieldValue.delete()}));
    } catch (e) {
      return Future.error('failed');
    }
  }
}
