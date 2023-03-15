import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerous_zone_comment.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';

class DangerousZoneService {
  final firestore = FirebaseFirestore.instance;

  /// 해당 위/경도 근처에 있는 위험 장소 목록 로드
  Future<List<DangerousZoneDto>> getDangerousZoneList(
      double latitude, double longitude) async {
    const rangeKM = 0.005;
    final minLat = (latitude) - rangeKM;
    final maxLat = (latitude) + rangeKM;
    final minLon = (longitude) - rangeKM;
    final maxLon = (longitude) + rangeKM;

    final query = firestore.collection('DangerousZone');

    final result = await query.where('latlng', isGreaterThanOrEqualTo: [
      minLat,
      minLon
    ]).where('latlng', isLessThanOrEqualTo: [maxLat, maxLon]).get();

    if (result.docs.isNotEmpty) {
      List<DangerousZoneDto> list = [];
      for (var snapshot in result.docs) {
        list.add(DangerousZoneDto.fromSnapshot(snapshot));
      }
      return Future.value(list);
    } else {
      return Future.value(List.empty());
    }
  }

  /// 단일 위험 장소 데이터 로드
  Future<DangerousZoneDto> getDangerousZone(String dangerousZoneDocId) async {
    var result = await firestore
        .collection('DangerousZone')
        .doc(dangerousZoneDocId)
        .get();

    if (result.exists) {
      return Future.value(DangerousZoneDto.fromSnapshot(result));
    } else {
      return Future.error('failed');
    }
  }

  /// 새로운 위험 장소 추가
  /// 추가 생공 시 문서 id 반환
  Future<String> addDangerousZone(DangerousZoneDto newDangerousZone) async {
    try {
      final newDoc = await firestore
          .collection('DangerousZone')
          .add(newDangerousZone.toMap());

      return Future.value(newDoc.id);
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 위험 장소 사진 추가
  Future<void> addDangerousZoneImgUrls(
      String dangerousZoneDocId, List<String> urls) async {
    try {
      return await Future.value(firestore
          .collection('DangerousZone')
          .doc(dangerousZoneDocId)
          .update({'tipoffphotos': FieldValue.arrayUnion(urls)}));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 댓글 추가
  Future<void> addComment(
      DangerousZoneCommentDto commentDto, String dangerousZoneDocId) async {
    try {
      return await Future.value(firestore
          .collection('DangerousZone')
          .doc(dangerousZoneDocId)
          .collection('Comments')
          .doc()
          .set(commentDto.toMap()));
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 모든 댓글 내용 로드
  Future<List<DangerousZoneCommentDto>> getAllComments(
      String dangerousZoneDocId) async {
    var result = await firestore
        .collection('DangerousZone')
        .doc(dangerousZoneDocId)
        .collection('Comments')
        .get();

    if (result.docs.isNotEmpty) {
      List<DangerousZoneCommentDto> list = [];
      for (var snapshot in result.docs) {
        list.add(DangerousZoneCommentDto.fromSnapshot(snapshot));
      }
      return Future.value(list);
    } else {
      return Future.error(List.empty());
    }
  }
}
