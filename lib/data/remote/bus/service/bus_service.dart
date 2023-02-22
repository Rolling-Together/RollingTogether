import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/bus/models/bus.dart';
import 'package:rolling_together/data/remote/bus/models/bus_station.dart';

class BusService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<BusStationDto> getBusStationInfo(
      String area, String busStation) async* {
    //정류장 정보 가져오기
    final query = firestore
        .collection('bus')
        .doc(area)
        .collection('busStationList')
        .doc(busStation);
    var result = await query.get();

    if (result.data() != null) {
      var dto = BusStationDto.fromMap(result.data());
      yield dto;
    }
  }

  Stream<List<BusDto>> getBusList(
      String area, String busStation, String routeNum) async* {
    //해당 노선 내 모든 버스 목록 가져오기
    final query = firestore
        .collection('bus')
        .doc(area)
        .collection('busStationList')
        .doc(busStation)
        .collection('busList')
        .where('route_num', isEqualTo: routeNum);

    var result = await query.get();

    if (result.docs.isNotEmpty) {
      List<BusDto> list = [];
      for (var doc in result.docs) {
        var dto = BusDto.fromSnapshot(doc);
        list.add(dto);
      }
      yield list;
    }
  }
}
