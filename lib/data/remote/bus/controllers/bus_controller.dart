import 'package:get/get.dart';
import 'package:rolling_together/data/remote/bus/models/bus.dart';
import 'package:rolling_together/data/remote/bus/service/bus_service.dart';
import 'package:rolling_together/data/remote/user/service/report_list_service.dart';

import '../models/jsonresponse/get_sttnacctoarvlprearngeinfolist_response'
    '.dart' as BusList;

import '../models/jsonresponse/get_crdntprxmtsttnlist_response.dart'
    as BusStopList;

class BusController extends GetxController {
  final busService = BusService();
  final reportService = ReportListService();

  // 파이어스토어에 저장된 버스 노선 별 차량 목록
  final RxList<BusDto> busList = <BusDto>[].obs;

  // 특정 버스 정류장을 경유하는 버스 목록, 버스 정류장 정보
  final RxList<BusList.Item> busStopInfo = <BusList.Item>[].obs;

  // 좌표 기반 버스 정류장 목록
  final RxList<BusStopList.Item> busStopList = <BusStopList.Item>[].obs;

  // 차량 상태 업데이트 결과
  final RxBool updateResult = false.obs;

  /// 버스 정류장 정보 로드
  /// nodeId : 정류소id, DJB8001793
  getBusListAtBusStop(String cityCode, String nodeId) {
    busService.getBusListAtBusStop(cityCode, nodeId).then((value) {
      final items = value.body?.items.item;
      busStopInfo.value = items ?? [];
    }, onError: (obj) {
      busStopInfo.value = [];
    });
  }

  /// 좌표기반근접정류소 목록조회
  /// GPS좌표를 기반으로 근처(반경 500m)에 있는 정류장을 검색한다.
  getBusStopList(double latitude, double longitude) {
    busService.getBusStopList(latitude, longitude).then((value) {
      final items = value.response.body.items.item;
      busStopList.value = items ?? [];
    }, onError: (obj) {
      busStopList.value = [];
    });
  }

  /// 해당 노선 버스 차량 목록 로드
  getCarList(String cityCode, String routeId) {
    busService.getCarList(cityCode, routeId).then((value) {
      busList.value = value;
    }, onError: (obj) {
      busList.value = obj;
    });
  }

  /// 리프트 유무/작동 여부 업데이트
  updateCarStatus(BusDto updateDto) {
    busService.updateCarStatus(updateDto).then((value) {
      reportService.updateBusInfo(updateDto).then((value) {
        updateResult.value = true;
      }, onError: (obj) {
        updateResult.value = false;
      });
    }, onError: (obj) {
      updateResult.value = false;
    });
  }
}
