import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/facility/models/facility.dart';
import 'package:rolling_together/data/remote/facility/models/review.dart';
import 'package:rolling_together/data/remote/imgs/models/upload_img.dart';

class FacilityService {
  final firestore = FirebaseFirestore.instance;

  /// 해당 위/경도 근처에 있는 장소(편의 시설) 목록 로드
  /// 매개변수 : 카테고리 목록
  Future<List<FacilityDto>> getFacilityList(
      List<String> facilityTypes, double latitude, double longitude) async {
    const rangeKM = 0.005;
    final minLat = (latitude) - rangeKM;
    final maxLat = (latitude) + rangeKM;
    final minLon = (longitude) - rangeKM;
    final maxLon = (longitude) + rangeKM;

    final query = firestore.collection('Facilities');

    var result = await query
        .where('latlng', isGreaterThanOrEqualTo: [minLat, minLon])
        .where('latlng', isLessThanOrEqualTo: [maxLat, maxLon])
        .where('categoryId', whereIn: facilityTypes)
        .get();

    if (result.docs.isNotEmpty) {
      List<FacilityDto> list = [];
      for (var snapshot in result.docs) {
        list.add(FacilityDto.fromSnapshot(snapshot));
      }
      return Future.value(list);
    } else {
      return Future.value(List.empty());
    }
  }

  /// 단일 장소(편의시설) 데이터 로드
  Future<FacilityDto> getFacility(String facilityPlaceId) async {
    var result =
        await firestore.collection('Facilities').doc(facilityPlaceId).get();

    if (result.exists) {
      return Future.value(FacilityDto.fromSnapshot(result));
    } else {
      return Future.error('failed');
    }
  }

  /// 새로운 편의 시설 추가
  Future<void> updateFacility(FacilityDto facilityDto) async {
    try {
      final collection = firestore.collection('Facilities');
      final document = await collection.doc(facilityDto.placeId).get();
      final map = facilityDto.toMap();

      if (document.exists) {
        // 장소 문서가 존재함
        final Map<String, Map<String, dynamic>> checkListMap =
            map['checkListMap'];

        for (final key in checkListMap.keys) {
          final List<String> images = checkListMap[key]!['fileNames'];

          if (images.isNotEmpty) {
            checkListMap['checkListMap.$key'] = {
              'fileNames': FieldValue.arrayUnion(images),
            };
          }
        }

        return await Future.value(
            collection.doc(facilityDto.placeId).update(map));
      } else {
        return await Future.value(
            collection.doc(facilityDto.placeId).set(map));
      }
    } catch (e) {
      return Future.error('failed');
    }
  }

  /// 리뷰 추가
  Future<void> addReview(
      FacilityReviewDto reviewDto, String facilityPlaceId) async {
    try {
      return await Future.value(firestore
          .collection('Facilities')
          .doc(facilityPlaceId)
          .collection('Reviews')
          .doc()
          .set(reviewDto.toMap()));
    } catch (e) {
      return Future.error('failed');
    }
  }

  ///  모든 리뷰 로드
  Future<List<FacilityReviewDto>> getAllReviews(String facilityPlaceId) async {
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
      return Future.value(list);
    } else {
      return Future.value(List.empty());
    }
  }
}
