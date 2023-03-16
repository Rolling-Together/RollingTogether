import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/dangerous_zone/likes/models/likes_dangerous_zone.dart';

class LikesDangerousZoneService {
  final firestore = FirebaseFirestore.instance;

  /// 위험 장소 공감 클릭 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> likeDangerousZone(
      String dangerousZoneDocId, String userId, String userName) async {
    try {
      return await Future.value(firestore
          .collection('DangerousZone')
          .doc(dangerousZoneDocId)
          .update({'likes.$userId': userName}));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 위험 장소 공감 클릭 해제 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> unlikeDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      return await Future.value(firestore
          .collection('DangerousZone')
          .doc(dangerousZoneDocId)
          .update({'likes.$userId': FieldValue.delete()}));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 위험 장소 공감 데이터 로드
  Future<Map<String, LikesDangerousZoneDto>> getLikesDangerousZoneList(
      String myUid) async {
    final query = firestore.collection('DangerousZone');

    var result = await query.where('likes', arrayContains: myUid).get();

    if (result.docs.isNotEmpty) {
      final Map<String, LikesDangerousZoneDto> map = {};
      for (var snapshot in result.docs) {
        final dto = LikesDangerousZoneDto.fromSnapshot(snapshot);
        map[dto.dangerousZoneDocId] = dto;
      }

      return Future.value(map);
    } else {
      return Future.error({});
    }
  }

  /// 위험 장소 공감 순 top3 정렬 후 반환
  Future<List<LikesDangerousZoneDto>> getMostLikesDangerousZoneList(
      double latitude, double longitude) async {
    const rangeKM = 0.01;
    final minLat = (latitude) - rangeKM;
    final maxLat = (latitude) + rangeKM;
    final minLon = (longitude) - rangeKM;
    final maxLon = (longitude) + rangeKM;

    final query = firestore.collection('DangerousZone');

    var result = await query
        .where('latlng', isGreaterThanOrEqualTo: [minLat, minLon])
        .where('latlng', isLessThanOrEqualTo: [maxLat, maxLon])
        .orderBy('likes', descending: true)
        .get();

    if (result.docs.isNotEmpty) {
      List<LikesDangerousZoneDto> list = [];
      for (var snapshot in result.docs) {
        list.add(LikesDangerousZoneDto.fromSnapshot(snapshot));
      }
      return Future.value(list);
    } else {
      return Future.error(List.empty());
    }
  }
}
