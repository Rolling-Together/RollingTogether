import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolling_together/commons/class/i_refresh_data.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';
import 'package:rolling_together/commons/utils/bottom_sheet.dart';
import 'package:rolling_together/data/local/image_asset_controller.dart';
import 'package:rolling_together/data/remote/map/controller/my_map_controller.dart';

import '13_facility_screen.dart';
import '6_dangerous_zone_screen.dart';
import '8_trans_screen.dart';

class MainMapWidget extends StatefulWidget implements OnRefreshDataListener {
  final MyMapController myMapController = Get.find<MyMapController>();

  @override
  _MainMapWidgetState createState() => _MainMapWidgetState();

  @override
  void refreshData() {
    // TODO: implement refreshData
  }
}

class _MainMapWidgetState extends State<MainMapWidget> {
  // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
  late GoogleMapController googleMapController;

  onCameraMoved(CameraPosition position) {
    widget.myMapController.currentCoords.clear();
    widget.myMapController.currentCoords
        .addAll([position.target.latitude, position.target.longitude]);

    widget.myMapController.loadAllDataList();
  }

  @override
  Widget build(BuildContext context) {
    log('Main GoogleMaps 새로고침');

    return Scaffold(
        body: Stack(children: [
      Obx(
        () => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.myMapController.currentCoords.first,
                widget.myMapController.currentCoords.last),
            zoom: 15,
          ),
          myLocationEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          markers: widget.myMapController.markerSet.value,
          onCameraMove: onCameraMoved,
          padding: const EdgeInsets.only(bottom: 100, top: 160),
          mapToolbarEnabled: false,
        ),
      ),
      Obx(() {
        if (widget.myMapController.isChangedMarkers.value) {}
        Future.delayed(Duration.zero, () {
          onChangedMarkers();
        });
        return const SizedBox.shrink();
      }),
      Positioned(
        top: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Wrap(
                spacing: 8.0,
                children: [
                  SharedDataCategory.dangerousZone,
                  SharedDataCategory.facility,
                  SharedDataCategory.publicTransport
                ].map((e) => addMainChips(e)).toList(),
              ),
              const SizedBox(height: 8.0),
              Visibility(
                  visible: widget.myMapController.lastSelectedCategorySet
                      .contains(SharedDataCategory.facility),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 6.0,
                      children: SharedDataCategory.toList()
                          .map((e) => addExtraChips(e))
                          .toList(),
                    ),
                  )),
            ],
          ),
        ),
      ),
      Obx(() => Positioned(
          right: 16,
          bottom: 24,
          child: Visibility(
            visible: !widget.myMapController.isClickedReportDangerousZone.value,
            child: FloatingActionButton(
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              elevation: 10,
              onPressed: () {
                showOptions(context);
              },
              child: const Text('글쓰기'),
            ),
          ))),
      Center(
        child: Image.asset('assets/images/center_circle.png',
            color: Colors.blueGrey, width: 26, height: 26),
      )
    ]));
  }

  FilterChip addMainChips(SharedDataCategory category) => FilterChip(
        label: Text(category.name),
        avatar: Icon(category.iconData),
        selected:
            widget.myMapController.lastSelectedCategorySet.contains(category),
        selectedColor: const Color.fromARGB(255, 222, 222, 222),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        elevation: 4.0,
        side: const BorderSide(color: Colors.transparent, width: 0.0),
        showCheckmark: false,
        shadowColor: Colors.black,
        selectedShadowColor: Colors.black,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              if (!widget.myMapController.lastSelectedCategorySet
                  .contains(category)) {
                widget.myMapController
                    .onChangedSelectedCategory([category], true);
              }
            } else {
              widget.myMapController
                  .onChangedSelectedCategory([category], false);
            }
          });
        },
      );

  FilterChip addExtraChips(SharedDataCategory category) => FilterChip(
        label: Text(
          category.name,
          style: const TextStyle(fontSize: 12.0),
        ),
        avatar: Icon(category.iconData),
        selected:
            widget.myMapController.lastSelectedCategorySet.contains(category),
        selectedColor: const Color.fromARGB(178, 204, 204, 204),
        shadowColor: Colors.black,
        selectedShadowColor: Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        elevation: 4.0,
        side: const BorderSide(color: Colors.transparent, width: 0.0),
        showCheckmark: false,
        backgroundColor: Colors.white,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              if (!widget.myMapController.lastSelectedCategorySet
                  .contains(category)) {
                widget.myMapController
                    .onChangedSelectedCategory([category], true);
              }
            } else {
              widget.myMapController
                  .onChangedSelectedCategory([category], false);
            }
          });
        },
      );

  void showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              ListTile(
                title: const Text('위험장소'),
                onTap: () {
                  Get.to(LocationScreen(), arguments: {
                    'latlng': LatLng(widget.myMapController.currentCoords.first,
                        widget.myMapController.currentCoords.last)
                  });
                },
              ),
              ListTile(
                title: const Text('편의시설'),
                onTap: () {
                  Get.to(FacilityScreen(), arguments: {
                    'latlng': LatLng(widget.myMapController.currentCoords.first,
                        widget.myMapController.currentCoords.last)
                  });
                },
              ),
              ListTile(
                title: const Text('대중교통'),
                onTap: () {
                  Get.to(TransScreen(), arguments: {
                    'latlng': LatLng(widget.myMapController.currentCoords.first,
                        widget.myMapController.currentCoords.last)
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  onChangedMarkers() {
    final newMarkers = <Marker>{};

    for (final entry in widget.myMapController.lastFacilityListMap.entries) {
      final list = entry.value;
      if (list.isEmpty) {
        continue;
      }

      newMarkers.addAll(entry.value.map((e) => Marker(
          markerId:
              MarkerId(widget.myMapController.toMarkerId(entry.key, e.placeId)),
          position: LatLng(e.latlng.first, e.latlng.last),
          infoWindow: InfoWindow(
              title: e.name,
              snippet: e.categoryName,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return FacilityInfoBottomSheet(e);
                    });
              }),
          icon: BitmapDescriptor.fromBytes(
            widget.myMapController.imageAssetLoader.markerIconsMap[entry.key]!,
          ))));
    }

    for (final dangerousZone in widget.myMapController.lastDangerousZoneList) {
      newMarkers.add(Marker(
          markerId: MarkerId(widget.myMapController
              .toMarkerId(SharedDataCategory.dangerousZone, dangerousZone.id!)),
          position:
              LatLng(dangerousZone.latlng.first, dangerousZone.latlng.last),
          infoWindow: InfoWindow(
              title: dangerousZone.description,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return DangerousZoneBottomSheet(dangerousZone);
                    });
              }),
          icon: BitmapDescriptor.fromBytes(
            widget.myMapController.imageAssetLoader
                .markerIconsMap[SharedDataCategory.dangerousZone]!,
          )));
    }

    for (final busStop in widget.myMapController.lastBusStopList) {
      newMarkers.add(Marker(
          markerId: MarkerId(widget.myMapController.toMarkerId(
              SharedDataCategory.busStop,
              '${busStop.citycode}-${busStop.nodeid}')),
          position: LatLng(
              double.parse(busStop.gpslati), double.parse(busStop.gpslong)),
          infoWindow: InfoWindow(
              title: busStop.nodenm,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BusBottomSheet(busStop);
                    });
              }),
          icon: BitmapDescriptor.fromBytes(
            widget.myMapController.imageAssetLoader
                .markerIconsMap[SharedDataCategory.busStop]!,
          )));
    }

    for (final metroStation in widget.myMapController.lastMetroStationList) {
      newMarkers.add(Marker(
          markerId: MarkerId(widget.myMapController.toMarkerId(
              SharedDataCategory.metroStation, metroStation.routeNumber)),
          position: LatLng(metroStation.latitude, metroStation.longitude),
          infoWindow: InfoWindow(
              title: metroStation.name,
              snippet: '지하철',
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SubwayBottomSheet(metroStation);
                    });
              }),
          icon: BitmapDescriptor.fromBytes(
            widget.myMapController.imageAssetLoader
                .markerIconsMap[SharedDataCategory.metroStation]!,
          )));
    }

    widget.myMapController.markerSet.value = newMarkers;
  }
}
