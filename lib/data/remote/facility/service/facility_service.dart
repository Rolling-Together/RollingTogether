import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rolling_together/data/remote/facility/models/facility.dart';
import 'package:rolling_together/data/remote/facility/models/review.dart';

import '../../dangerous_zone/models/enum/facility_checklist_types.dart';

class FacilityService {
  final firestore = FirebaseFirestore.instance;

  /// 해당 위/경도 근처에 있는 장소(편의 시설) 목록 로드
  Stream<List<FacilityDto>> getFacilityList(
      double latitude, double longitude) async* {
    const rangeKM = 0.005;
    final minLat = (latitude) - rangeKM;
    final maxLat = (latitude) + rangeKM;
    final minLon = (longitude) - rangeKM;
    final maxLon = (longitude) + rangeKM;

    final query = firestore.collection('Facilities');

    var result = await query.where('latlng', isGreaterThanOrEqualTo: [
      minLat,
      minLon
    ]).where('latlng', isLessThanOrEqualTo: [maxLat, maxLon]).get();

    if (result.docs.isNotEmpty) {
      List<FacilityDto> list = [];
      for (var snapshot in result.docs) {
        list.add(FacilityDto.fromSnapshot(snapshot));
      }
      yield list;
    }
  }

  /// 단일 장소(편의시설) 데이터 로드
  Stream<FacilityDto> getFacility(String facilityPlaceId) async* {
    var result =
        await firestore.collection('Facilities').doc(facilityPlaceId).get();

    if (result.exists) {
      yield FacilityDto.fromSnapshot(result);
    }
  }

  /// 새로운 편의 시설 추가
  Future<void> addFacility(FacilityDto facilityDto) async {
    try {
      await firestore
          .collection('Facilities')
          .doc(facilityDto.placeId)
          .set(facilityDto.toMap());
    } catch (e) {
      rethrow;
    }
  }

  /// 편의 시설 체크 리스트 항목 별 사진 추가
  Future<void> addCheckListImgs(String facilityPlaceId,
      Map<FacilityCheckListType, List<String>> urlsMap) async {
    try {
      var updateMap = <String, Map<String, dynamic>>{};

      for (var entry in urlsMap.entries) {
        updateMap['checkListMap.${entry.key.firestoreFieldName}'] = {
          'imgUrls': FieldValue.arrayUnion(entry.value)
        };
      }

      await firestore
          .collection('Facilities')
          .doc(facilityPlaceId)
          .update(updateMap);
    } catch (e) {
      rethrow;
    }
  }



  /// 리뷰 추가
  Future<void> addReview(
      FacilityReviewDto reviewDto, String facilityPlaceId) async {
    try {
      await firestore
          .collection('Facilities')
          .doc(facilityPlaceId)
          .collection('Reviews')
          .doc()
          .set(reviewDto.toMap());
    } catch (e) {
      rethrow;
    }
  }

  ///  모든 리뷰 로드
  Stream<List<FacilityReviewDto>> getAllReviews(String facilityPlaceId) async* {
    var result = await firestore
        .collection('Facilities')
        .doc(facilityPlaceId)
        .collection('Reviews')
        .get();

    if (result.docs.isNotEmpty) {
      List<FacilityReviewDto> list = [];
      for (var snapshot in result.docs) {
        list.add(FacilityReviewDto.fromSnapshot(snapshot));
      }
      yield list;
    }
  }
}
