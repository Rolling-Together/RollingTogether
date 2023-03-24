import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolling_together/commons/class/i_refresh_data.dart';
import 'package:rolling_together/commons/enum/facility_checklist.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';

import '../../commons/utils/bottom_sheet.dart';
import '../../commons/widgets/custom_chip.dart';
import '13_facility_screen.dart';
import '6_dangerous_zone_screen.dart';
import '8_trans_screen.dart';

class MapSample extends StatefulWidget implements OnRefreshDataListener {
  late final String title;

  @override
  _MapSampleState createState() => _MapSampleState();

  @override
  void refreshData() {
    // TODO: implement refreshData
  }
}

class _MapSampleState extends State<MapSample> {
  // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
  late GoogleMapController _controller;

  //Location _location = Location();
  bool _showAdditionalChips = false;
  LatLng centerCoords = LatLng(0.0, 0.0);

  /*Future<LocationData?> getCurrentLocation() async {
    try {
      return await _location.getLocation();
    } catch (e) {
      return null;
    }
  }*/


  onCameraMoved(CameraPosition position) {
    centerCoords = position.target;
  }


  // 이 값은 지도가 시작될 때 첫 번째 위치입니다.
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.1340990, 129.1031460),
    zoom: 14.4746,
  );

  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];

  // 마커를 탭할 때 호출되는 콜백 함수
  void onMarkerTapped(MarkerId markerId) {
    // 마커 ID를 사용하여 특정 마커를 찾음
    Marker tappedMarker = markers.firstWhere((marker) => marker.markerId == markerId);

    if (markerId.value == "2") {
      //식당
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Bus_BottomSheet();
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Bus_BottomSheet();
        },
      );
    }
  }

  addMarker(cordinate) {
    int id = Random().nextInt(5);

    setState(() {
      markers.add(
        Marker(
          position: cordinate,
          markerId: MarkerId(id.toString()),
          onTap: () => onMarkerTapped(MarkerId(id.toString())),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: _initialPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          onCameraMove: onCameraMoved,
          markers: markers.toSet(),

          // 클릭한 위치가 중앙에 표시
          onTap: (cordinate) {
            _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
            addMarker(cordinate);
          },
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 50,
            height: 50,
            child: Container(
              height: 20,//식당 이미지
            )/*Image.asset(
              'https://th.bing.com/th/id/OIP.CWxD3nGIp_XU34nZ8G-p9AHaFj?w=263&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7',
            ),*/
          ),
        ),
        Positioned(
          top: 50,
          left: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
//onTap: () => ,
                  child: CostomChip(
                      '위험장소', Icon(Icons.dangerous), Colors.redAccent)),
              SizedBox(width: 10),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAdditionalChips = !_showAdditionalChips;
                    });
                  },
                  child: CostomChip('편의시설', Icon(Icons.place), Colors.yellow)),
              SizedBox(width: 10),
              CostomChip('대중교통', Icon(Icons.bus_alert_rounded), Colors.cyan)
            ],
          ),
        ),
        Positioned(
          top: 80,
          child: Visibility(
            visible: _showAdditionalChips,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child:
                    CostomChip('식당', Icon(Icons.fastfood), Colors.yellow),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: CostomChip(
                        '카페', Icon(Icons.emoji_food_beverage), Colors.yellow),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child:
                    CostomChip('문화', Icon(Icons.fastfood), Colors.yellow),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CostomChip(
                        '복합', Icon(Icons.face_outlined), Colors.yellow),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 100,
          child: FloatingActionButton(
            elevation: 10,
            onPressed: () {
              showOptions(context, markers, _controller);
            },
            child: Text('글쓰기'),
          ),
        ),
        /*Positioned(
              right: 5,
              bottom: 150,
              child: FloatingActionButton(
                onPressed: () async {
                  LocationData? locationData = await getCurrentLocation();
                  if (locationData != null) {
                    _controller.animateCamera(CameraUpdate.newLatLng(
                      LatLng(11.11, 22.22),
                    ));
                  }
                },
                child: Icon(Icons.my_location),
              ),

            ),*/
      ]),

      // floatingActionButton 클릭시 줌 아웃
      /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.animateCamera(CameraUpdate.zoomOut());
          },
          child: Icon(Icons.zoom_out),
        )*/
    );
  }

  void showOptions(BuildContext context, List<Marker> markers,
      GoogleMapController controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('위험장소'),
                onTap: () {
                  Get.to(LocationScreen(), arguments: {'latlng': centerCoords});
                },
              ),
              ListTile(
                title: Text('편의시설'),
                onTap: () {
                  Get.to(FacilityScreen(), arguments: {'latlng': centerCoords});
                },
              ),
              ListTile(
                title: Text('대중교통'),
                onTap: () {
                  Get.to(TransScreen(), arguments: {'latlng': centerCoords});
                },
              ),
            ],
          ),
        );
      },
    );
  }
}


