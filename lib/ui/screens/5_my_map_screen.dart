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
          myLocationButtonEnabled: true,
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
                spacing: 6.0,
                children: [
                  SharedDataCategory.dangerousZone,
                  SharedDataCategory.facility,
                  SharedDataCategory.publicTransport
                ].map((e) => addChips(e)).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0 ,left: 10.0),
                child: Visibility(
                    visible: widget.myMapController.lastSelectedCategorySet
                        .contains(SharedDataCategory.facility),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 6.0,
                        children: SharedDataCategory.toList()
                            .map((e) => addChips(e))
                            .toList(),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
      Obx(() => widget.myMapController.isClickedReportDangerousZone.value
          ? Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/welfare_marker_icon.png'),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            widget.myMapController.isClickedReportDangerousZone
                                .value = false;
                          });
                          Get.to(LocationScreen(), arguments: {
                            'latlng': widget.myMapController.currentCoords
                          });
                        },
                        child: const Text('여기로 위치 지정'),
                      ),
                      CloseButton(
                        onPressed: () {
                          setState(() {
                            widget.myMapController.isClickedReportDangerousZone
                                .value = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox()),
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
    ]));
  }


  FilterChip addChips(SharedDataCategory category) => FilterChip(

        label: Text(category.name),
        avatar: Icon(category.iconData),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
        selected:
            widget.myMapController.lastSelectedCategorySet.contains(category),
        selectedColor: Colors.purple.withOpacity(0.1),


        shadowColor: Colors.grey,
        surfaceTintColor: Colors.grey.withOpacity(0.1),//그림자주고 이코드없으면 탁해짐
        elevation: 7.0,
        //shadowColor: Colors.white24,
        showCheckmark: false,
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
                  Navigator.pop(context);
                  widget.myMapController.isClickedReportDangerousZone.value =
                      true;
                },
              ),
              ListTile(
                title: const Text('편의시설'),
                onTap: () {
                  Get.to(FacilityScreen(), arguments: {
                    'latlng': widget.myMapController.currentCoords
                  });
                },
              ),
              ListTile(
                title: const Text('대중교통'),
                onTap: () {
                  Get.to(TransScreen(), arguments: {
                    'latlng': widget.myMapController.currentCoords
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

