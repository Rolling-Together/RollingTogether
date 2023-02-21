import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';

class DangerousZoneService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<DangerousZoneDto>> getDangerousZoneList(
      String latitude, String longitude) async* {
    const rangeKM = 0.005;
    final double minLat = double.parse(latitude) - rangeKM;
    final double maxLat = double.parse(latitude) + rangeKM;
    final double minLon = double.parse(longitude) - rangeKM;
    final double maxLon = double.parse(longitude) + rangeKM;

    final query = firestore.collection('DangerousZone');

    query.where("latitude", isGreaterThanOrEqualTo: minLat);

    var result = await query.get();

    if (result.docs.isNotEmpty) {
      List<DangerousZoneDto> list = [];
      for (var snapshot in result.docs) {
        list.add(DangerousZoneDto.fromSnapshot(snapshot));
      }
      yield list;
    }
  }
}
