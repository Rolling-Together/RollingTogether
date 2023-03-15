import 'package:get/get.dart';
import 'package:rolling_together/data/remote/metro/models'
    '/busan_metro_station_convenience.dart' as busan_metro_response;
import 'package:rolling_together/data/remote/metro/models/metro_station.dart';
import 'package:rolling_together/data/remote/metro/service/metro_service.dart';

class MetroController extends GetxController {
  final metroService = MetroService();

  // 지하철 역 목록(부산)
  // 키 : 역 코드
  final metroStationMap = <String, MetroStationDto>{}.obs;

  // 지하철 역 장애인 편의 시설 정보
  final Rxn<busan_metro_response.Item> convenienceInfoInMetroStation = Rxn();

  /// 부산 지하철 역 목록 맵 반환
  loadMetroStationMap() {
    metroService.loadMetroStationMap().then((value) {
      metroStationMap.value = value;
    });
  }

  /// 부산 도시 철도 장애인 편의 시설 정보 로드
  /// scode : 역 코드
  getConvenienceInfoBusanMetro(String sCode) {
    metroService.getConvenienceInfoBusanMetro(sCode).then((value) {
      convenienceInfoInMetroStation.value = value;
    }, onError: (obj) {
      convenienceInfoInMetroStation.value = null;
    });
  }
}
