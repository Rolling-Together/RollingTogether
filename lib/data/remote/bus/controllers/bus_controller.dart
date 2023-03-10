import 'package:get/get.dart';
import 'package:rolling_together/data/remote/bus/models/bus.dart';
import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_car_list_tago.dart';
import 'package:rolling_together/data/remote/bus/service/bus_service.dart';
import 'package:rolling_together/data/remote/user/service/report_list_service.dart';

import '../models/jsonresponse/get_car_list_tago.dart' as car_list_of_route;

import '../models/jsonresponse/get_bus_list_at_bus_stop_response.dart'
    as bus_list_at_bus_stop_response;

import '../models/jsonresponse/get_bus_stop_list_around_latlng_response.dart'
    as bus_stop_list_response;

class BusController extends GetxController {
  final busService = BusService();
  final reportService = ReportListService();

  ///  파이어스토어에 저장된 버스 노선 별 차량 목록
  final RxList<BusDto> carList = <BusDto>[].obs;

  ///  특정 버스 정류장을 경유하는 버스 목록, 버스 정류장 정보
  final RxList<bus_list_at_bus_stop_response.Item> busStopInfo =
      <bus_list_at_bus_stop_response.Item>[].obs;

  ///  좌표 기반 버스 정류장 목록
  final RxList<bus_stop_list_response.Item> busStopList =
      <bus_stop_list_response.Item>[].obs;

  ///  차량 상태 업데이트 결과
  final RxBool updateResult = false.obs;

  ///  노선 운행 차량 목록
  final RxMap<String, BusDto> busCarListMap = RxMap();

  String cityCode = '';

  late var latlng = <double>[];
  late String myUIdInFirebase;
  late String myUserName;

  final editedCarMaps = <String, BusDto>{};

  /// 버스 정류장 정보 로드
  /// nodeId : 정류소id, DJB8001793
  getBusListAtBusStop(String cityCode, String nodeId) {
    editedCarMaps.clear();
    busStopInfo.value = [];

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
    busStopList.value = [];
    busStopInfo.value = [];
    editedCarMaps.clear();

    busService.getBusStopList(latitude, longitude).then((value) {
      final items = value.response.body.items.item;
      busStopList.value = items ?? [];
    }, onError: (obj) {
      busStopList.value = [];
    });
  }

  /// 노선 별 버스 위치 목록 조회, 차량 목록 조회
  /// 동시에 파이어 스토어 데이터도 가져 와서 정리 한다
  getCarListFromTago(String cityCode, String routeId) async {
    editedCarMaps.clear();
    busCarListMap.value = {};

    busService.getCarListFromTago(cityCode, routeId).then((value) {
      final carsFromTago = value.response.body.items.item;

      busService.getCarListFromFs(cityCode, routeId).then((carsFromFs) {
        final cars = <String, BusDto>{};
        for (final car in carsFromTago) {
          cars[car.vehicleno] = BusDto(
              vehicleNo: car.vehicleno,
              lift: false,
              liftStatus: false,
              informerId: '',
              timestamp: null,
              cityCode: cityCode,
              routeId: routeId);
        }

        for (final car in carsFromFs) {
          if (cars.containsKey(car.vehicleNo)) {
            cars[car.vehicleNo]?.liftStatus = car.liftStatus;
            cars[car.vehicleNo]?.lift = car.lift;
            cars[car.vehicleNo]?.updated = car.updated;
            cars[car.vehicleNo]?.id = car.id;
          }
        }

        busCarListMap.value = cars;
      }, onError: (obj) {});
    }, onError: (obj) {
      busCarListMap.value = {};
    });
  }

  /// 해당 노선 버스 차량 목록 로드
  getCarListFromFs(String cityCode, String routeId) {
    editedCarMaps.clear();
    busService.getCarListFromFs(cityCode, routeId).then((value) {
      carList.value = value;
    }, onError: (obj) {
      carList.value = obj;
    });
  }

  /// 리프트 유무/작동 여부 업데이트
  updateCarStatus(List<BusDto> list) {
    if (list.isEmpty) {
      updateResult.value = true;
      return;
    }

    for (var bus in list) {
      bus.informerId = myUIdInFirebase;
    }

    busService.updateCarStatus(list).then((value) {
      updateResult.value = true;
    }, onError: (obj) {
      updateResult.value = false;
    });
  }
}
