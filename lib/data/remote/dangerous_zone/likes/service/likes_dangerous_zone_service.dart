import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/dangerous_zone/likes/models/likes_dangerous_zone.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';

class LikesDangerousZoneService {
  final firestore = FirebaseFirestore.instance;

  /// 위험 장소 공감 클릭 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> likeDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      return await Future.value(
          firestore.collection('DangerousZone').doc(dangerousZoneDocId).update({
        'likes': FieldValue.arrayUnion([userId]),
        'likeCounts': FieldValue.increment(1),
      }));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 위험 장소 공감 클릭 해제 시 로직
  /// 매개변수 : userId - 유저UID(이메일X)
  Future<void> unlikeDangerousZone(
      String dangerousZoneDocId, String userId) async {
    try {
      return await Future.value(
          firestore.collection('DangerousZone').doc(dangerousZoneDocId).update({
        'likes': FieldValue.arrayRemove([userId]),
        'likeCounts': FieldValue.increment(-1),
      }));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 위험 장소 공감 순 top3 정렬 후 반환
  Future<List<DangerousZoneDto>> getMostLikesDangerousZoneList(
      double latitude, double longitude) async {
    const rangeKM = 0.01;
    final minLat = (latitude) - rangeKM;
    final maxLat = (latitude) + rangeKM;
    final minLon = (longitude) - rangeKM;
    final maxLon = (longitude) + rangeKM;

    final query = firestore.collection('DangerousZone');

    var result = await query.where('latlng', isGreaterThanOrEqualTo: [
      minLat,
      minLon
    ]).where('latlng', isLessThan: [maxLat, maxLon]).limit(3).get();

    if (result.docs.isNotEmpty) {
      List<DangerousZoneDto> list = [];
      for (var snapshot in result.docs) {
        list.add(DangerousZoneDto.fromSnapshot(snapshot));
      }

      list.sort((a, b) => b.likeCounts.compareTo(a.likeCounts));
      return Future.value(list);
    } else {
      return Future.error(List.empty());
    }
  }
}
