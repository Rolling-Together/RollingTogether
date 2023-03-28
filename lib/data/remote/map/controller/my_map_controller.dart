import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolling_together/data/remote/bus/models/jsonresponse'
    '/get_bus_stop_list_around_latlng_response.dart' as bus_stop_response;
import 'package:rolling_together/data/remote/bus/service/bus_service.dart';
import 'package:rolling_together/data/remote/dangerous_zone/service/dangerous_zone_service.dart';
import 'package:rolling_together/data/remote/facility/models/facility.dart';
import 'package:rolling_together/data/remote/facility/service/facility_service.dart';
import 'package:rolling_together/data/remote/metro/models/metro_station.dart';
import 'package:rolling_together/data/remote/metro/service/metro_service.dart';

import '../../../../commons/enum/facility_types.dart';
import '../../../../commons/utils/coords_dist_util.dart';
import '../../../local/image_asset_controller.dart';
import '../../dangerous_zone/models/dangerouszone.dart';

class MyMapController extends GetxController {
  final DangerousZoneService dangerousZoneService = DangerousZoneService();
  final FacilityService facilityService = FacilityService();
  final MetroService metroService = MetroService();
  final BusService busService = BusService();
  final ImageAssetLoader imageAssetLoader = ImageAssetLoader.getInstance();

  /// 하위 4개 위젯 에서 구독.
  /// 바뀌면 모든 마커를 다시 생성
  final List<bus_stop_response.Item> lastBusStopList = [];
  final List<MetroStationDto> lastMetroStationList = [];
  final Map<SharedDataCategory, List<FacilityDto>> lastFacilityListMap = {};
  final List<DangerousZoneDto> lastDangerousZoneList = [];

  /// 지도에서 보여줄 데이터 타입
  final RxSet<SharedDataCategory> lastSelectedCategorySet =
      RxSet({SharedDataCategory.dangerousZone});

  /// 지도 중심부 좌표, 지도 카메라 변경 될 때 마다 값 업데 이트
  final List<double> currentCoords = [35.1343, 129.0884];
  final lastLoadedCoords = [];

  final Rx<Set<Marker>> markerSet = Rx(<Marker>{});

  final RxBool isClickedReportDangerousZone = false.obs;

  final RxBool isChangedMarkers = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await imageAssetLoader.loadImages();
    await metroService.loadMetroStationMap();
    loadAllDataList();
  }

  onChangedSelectedCategory(
      List<SharedDataCategory> changedCategoryList, bool show) {
    if (!show) {
      for (var category in changedCategoryList) {
        switch (category) {
          case SharedDataCategory.publicTransport:
            lastBusStopList.clear();
            lastMetroStationList.clear();
            break;
          case SharedDataCategory.dangerousZone:
            lastDangerousZoneList.clear();
            break;
          case SharedDataCategory.all:
            changedCategoryList.addAll(SharedDataCategory.toList());
            lastFacilityListMap.clear();
            break;
          default:
            lastFacilityListMap.remove(category);
            break;
        }
      }

      lastSelectedCategorySet.removeAll(changedCategoryList);
      isChangedMarkers.value = !isChangedMarkers.value;
      return;
    }

    if (changedCategoryList.contains(SharedDataCategory.all)) {
      changedCategoryList.addAll(SharedDataCategory.toList());
    }

    lastSelectedCategorySet.addAll(changedCategoryList);
    final facilityCategories = <SharedDataCategory>{};

    for (var category in changedCategoryList) {
      if (lastSelectedCategorySet.contains(category)) {
        switch (category) {
          case SharedDataCategory.publicTransport:
            loadBusStopList();
            loadMetroStationList();
            break;
          case SharedDataCategory.dangerousZone:
            loadDangerousZoneList();
            break;
          case SharedDataCategory.all:
            facilityCategories.addAll(SharedDataCategory.toList());
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

    lastLoadedCoords.clear();
    lastLoadedCoords.addAll(currentCoords);
  }

  loadAllDataList() {
    if (lastLoadedCoords.isNotEmpty) {
      if (haversineDistance(currentCoords.first, currentCoords.last,
              lastLoadedCoords.first, lastLoadedCoords.last) <
          500.0) {
        return;
      }
    }

    final facilityCategories = <SharedDataCategory>{};

    for (var category in lastSelectedCategorySet) {
      switch (category) {
        case SharedDataCategory.publicTransport:
          loadBusStopList();
          loadMetroStationList();
          break;
        case SharedDataCategory.dangerousZone:
          loadDangerousZoneList();
          break;
        case SharedDataCategory.all:
          facilityCategories.addAll(SharedDataCategory.toList());
          break;
        default:
          facilityCategories.add(category);
          break;
      }
    }

    if (facilityCategories.isNotEmpty) {
      loadFacilities(facilityCategories);
    }

    lastLoadedCoords.clear();
    lastLoadedCoords.addAll(currentCoords);
  }

  loadBusStopList() {
    busService.getBusStopList(currentCoords.first, currentCoords.last).then(
        (response) {
      lastBusStopList.clear();
      lastBusStopList.addAll(response.response.body.items.item);
      isChangedMarkers.value = !isChangedMarkers.value;
    }, onError: (error) {
      lastBusStopList.clear();
    });
  }

  loadMetroStationList() {
    metroService
        .loadAroundStations(currentCoords.first, currentCoords.last)
        .then((response) {
      lastMetroStationList.clear();
      lastMetroStationList.addAll(response);
      isChangedMarkers.value = !isChangedMarkers.value;
    }, onError: (error) {
      lastMetroStationList.clear();
    });
  }

  loadFacilities(Set<SharedDataCategory> categorySet) {
    final categories = categorySet
        .where((category) => category.id.isNotEmpty)
        .map((e) => e.id)
        .toList();

    if (categories.isNotEmpty) {
      facilityService
          .getFacilityList(categories, currentCoords.first, currentCoords.last)
          .then((response) {
        final Map<SharedDataCategory, List<FacilityDto>> responseMap = {};

        for (final facility in response) {
          if (!responseMap.containsKey(facility.category)) {
            responseMap[facility.category] = [];
          }
          responseMap[facility.category]!.add(facility);
        }

        lastFacilityListMap.addAll(responseMap);
        isChangedMarkers.value = !isChangedMarkers.value;
      }, onError: (error) {});
    }
  }

  loadDangerousZoneList() {
    dangerousZoneService
        .getDangerousZoneList(currentCoords.first, currentCoords.last)
        .then((response) {
      lastDangerousZoneList.clear();
      lastDangerousZoneList.addAll(response);
      isChangedMarkers.value = !isChangedMarkers.value;
    }, onError: (error) {
      lastDangerousZoneList.clear();
    });
  }

  String toMarkerId(SharedDataCategory category, String id) =>
      "${category.id}_$id";

  /// type, docId
  List<dynamic> convMarkerId(String markerId) {
    final split = markerId.split("_");
    return [SharedDataCategory.getByFieldName(split[0]), split[1]];
  }
}
