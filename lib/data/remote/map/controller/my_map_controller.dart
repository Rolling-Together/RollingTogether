import 'package:get/get.dart';
import 'package:rolling_together/data/remote/bus/models/jsonresponse'
    '/get_bus_stop_list_around_latlng_response.dart' as bus_stop_response;
import 'package:rolling_together/data/remote/bus/service/bus_service.dart';
import 'package:rolling_together/data/remote/dangerous_zone/service/dangerous_zone_service.dart';
import 'package:rolling_together/data/remote/facility/models/facility.dart';
import 'package:rolling_together/data/remote/facility/service/facility_service.dart';
import 'package:rolling_together/data/remote/metro/models/metro_station.dart';
import 'package:rolling_together/data/remote/metro/service/metro_service.dart';

import '../../../../commons/enum/facility_types.dart';
import '../../dangerous_zone/models/dangerouszone.dart';

class MyMapController extends GetxController {
  final DangerousZoneService dangerousZoneService = DangerousZoneService();
  final FacilityService facilityService = FacilityService();
  final MetroService metroService = MetroService();
  final BusService busService = BusService();

  /// 하위 4개 위젯 에서 구독.
  /// 바뀌면 모든 마커를 다시 생성
  final RxList<bus_stop_response.Item> busStopList = RxList();
  final RxList<MetroStationDto> metroStationList = RxList();
  final RxMap<SharedDataCategory, List<FacilityDto>> facilityListMap = RxMap();
  final RxList<DangerousZoneDto> dangerousZoneList = RxList();

  /// 지도에서 보여줄 데이터 타입
  final RxSet<SharedDataCategory> selectedCategorySet = RxSet();

  /// 지도 중심부 좌표, 지도 카메라 변경 될 때 마다 값 업데 이트
  final RxList<double> lastCoords = RxList([35.1343, 129.0884]);

  loadDataList(List<SharedDataCategory> selectedCategoryList, bool show) {
    if (!show) {
      selectedCategorySet.removeAll(selectedCategoryList);
      final facilityCategories = <SharedDataCategory>[];

      for (var category in selectedCategoryList) {
        if (selectedCategorySet.contains(category)) {
          switch (category) {
            case SharedDataCategory.publicTransport:
              busStopList.clear();
              metroStationList.clear();
              break;
            case SharedDataCategory.dangerousZone:
              dangerousZoneList.clear();
              break;
            default:
              facilityCategories.add(category);
              break;
          }
        }
      }

      if (facilityCategories.isNotEmpty) {
        var map = facilityListMap;
        for (var category in facilityCategories) {
          map.remove(category);
        }
        facilityListMap.value = map;
      }
      return;
    }

    selectedCategorySet.addAll(selectedCategoryList);
    final facilityCategories = <SharedDataCategory>[];

    for (var category in selectedCategoryList) {
      if (selectedCategorySet.contains(category)) {
        switch (category) {
          case SharedDataCategory.publicTransport:
            loadBusStopList();
            loadMetroStationList();
            break;
          case SharedDataCategory.dangerousZone:
            loadDangerousZoneList();
            break;
          default:
            facilityCategories.add(category);
            break;
        }
      }
    }

    if (facilityCategories.isNotEmpty) {
      loadFacilities(facilityCategories);
    }
  }

  loadBusStopList() {
    busService
        .getBusStopList(lastCoords.value.first, lastCoords.value.last)
        .then((response) {
      busStopList.value = response.response.body.items.item;
    }, onError: (error) {
      busStopList.value = [];
    });
  }

  loadMetroStationList() {
    metroService
        .loadAroundStations(lastCoords.value.first, lastCoords.value.last)
        .then((response) {
      metroStationList.value = response;
    }, onError: (error) {
      metroStationList.value = [];
    });
  }

  loadFacilities(List<SharedDataCategory> categoryList) {
    facilityService
        .getFacilityList(categoryList.map((e) => e.id).toList(),
            lastCoords.value.first, lastCoords.value.last)
        .then((response) {
      Map<SharedDataCategory, List<FacilityDto>> responseMap = {};

      for (var r in response) {
        if (!responseMap.containsKey(r.category)) {
          responseMap[r.category] = [];
        }
        responseMap[r.category]!.add(r);
      }

      var map = facilityListMap;
      for (var entry in responseMap.entries) {
        map[entry.key] = entry.value;
      }

      facilityListMap.value = map;
    }, onError: (error) {});
  }

  loadDangerousZoneList() {
    dangerousZoneService
        .getDangerousZoneList(lastCoords.value.first, lastCoords.value.last)
        .then((response) {
      dangerousZoneList.value = response;
    }, onError: (error) {
      dangerousZoneList.value = [];
    });
  }
}
