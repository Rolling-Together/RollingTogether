import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';

class DangerousZoneService {
  final firestore = FirebaseFirestore.instance;

  /// 해당 위/경도 근처에 있는 위험 장소 목록 로드
  Stream<List<DangerousZoneDto>> getDangerousZoneList(
      double latitude, double longitude) async* {
    const rangeKM = 0.005;
    final minLat = (latitude) - rangeKM;
    final maxLat = (latitude) + rangeKM;
    final minLon = (longitude) - rangeKM;
    final maxLon = (longitude) + rangeKM;

    final query = firestore.collection('DangerousZone');

    var result = await query.where('latlng', isGreaterThanOrEqualTo: [
      minLat,
      minLon
    ]).where('latlng', isLessThanOrEqualTo: [maxLat, maxLon]).get();

    if (result.docs.isNotEmpty) {
      List<DangerousZoneDto> list = [];
      for (var snapshot in result.docs) {
        list.add(DangerousZoneDto.fromSnapshot(snapshot));
      }
      yield list;
    }
  }

  /// 새로운 위험 장소 추가
  Future<void> addDangerousZone(DangerousZoneDto newDangerousZone) async {
    try {
      await firestore
          .collection('DangerousZone')
          .doc()
          .set(newDangerousZone.toMap());
    } catch (e) {
      rethrow;
    }
  }

  /// 위험 장소 사진 추가
  Future<void> addDangerousZoneImgUrls(
      String dangerousZoneDocId, List<String> urls) async {
    try {
      await firestore
          .collection('DangerousZone')
          .doc(dangerousZoneDocId)
          .update({'tipoffphotos': FieldValue.arrayUnion(urls)});
    } catch (e) {
      rethrow;
    }
  }

  /// 위험 장소 공감 클릭 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> likeDangerousZone(
      String dangerousZoneDocId, String userId, String userName) async {
    try {
      await firestore
          .collection('DangerousZone')
          .doc(dangerousZoneDocId)
          .update({'like.$userId': userName});
    } catch (e) {
      rethrow;
    }
  }

  /// 위험 장소 공감 클릭 해제 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> unlikeDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      await firestore
          .collection('DangerousZone')
          .doc(dangerousZoneDocId)
          .update({'like.$userId': FieldValue.delete()});
    } catch (e) {
      rethrow;
    }
  }
}
