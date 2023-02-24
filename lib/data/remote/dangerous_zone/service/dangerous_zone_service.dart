import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';

class DangerousZoneService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<DangerousZoneDto>> getDangerousZoneList(
      double latitude, double longitude) async* {
    // 해당 위경도 근처에 있는 위험 장소 목록 로드
    const rangeKM = 0.005;
    final minLat = (latitude) - rangeKM;
    final maxLat = (latitude) + rangeKM;
    final minLon = (longitude) - rangeKM;
    final maxLon = (longitude) + rangeKM;

    final query = firestore.collection('DangerousZone');

    var result = await query.where('latlng', isGreaterThanOrEqualTo: [minLat,minLon])
        .where('latlng', isLessThanOrEqualTo: [maxLat,maxLon]).get();

    if (result.docs.isNotEmpty) {
      List<DangerousZoneDto> list = [];
      for (var snapshot in result.docs) {
        list.add(DangerousZoneDto.fromSnapshot(snapshot));
      }
      yield list;
    }
  }
}
