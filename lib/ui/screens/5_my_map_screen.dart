import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../commons/utils/bottom_sheet.dart';
import '../../commons/widgets/custom_chip.dart';
import '13_facility_screen.dart';
import '6_dangerous_zone_screen.dart';
import '8_trans_screen.dart';

class MapSample extends StatefulWidget {
  late final String title;

  @override
  _MapSampleState createState() => _MapSampleState();
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
            child: /*Image.asset('assets/images/Icon1.png', height: 50, width: 10),*/
            Icon(Icons.icecream_rounded)
        ),
        Positioned(
          top: 50,
          left: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TransparentButton(
                label: "위험장소",
                icon: Icon(Icons.dangerous),
                onPressed: () {},
              ),
              SizedBox(width: 5),
              TransparentButton(
                label: "편의시설",
                icon: Icon(Icons.place),
                onPressed: () {
                  setState(() {
                    _showAdditionalChips = !_showAdditionalChips;
                  });
                },
              ),
              SizedBox(width: 5),
              TransparentButton(
                label: "대중교통",
                icon: Icon(Icons.bus_alert_rounded),
                onPressed: () {
                  // Do something when the button is pressed
                },
              )

            ],
          ),
        ),
        Positioned(
          top: 80,
          child: Visibility(
            visible: _showAdditionalChips,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  TransparentButton(
                    label: "식당",
                    icon: Icon(Icons.fastfood),
                    onPressed: () {},
                  ),
                  TransparentButton(
                    label: "식당",
                    icon: Icon(Icons.fastfood),
                    onPressed: () {},
                  ),TransparentButton(
                    label: "식당",
                    icon: Icon(Icons.fastfood),
                    onPressed: () {},
                  ),TransparentButton(
                    label: "식당",
                    icon: Icon(Icons.fastfood),
                    onPressed: () {},
                  ),
                  TransparentButton(
                    label: "식당",
                    icon: Icon(Icons.fastfood),
                    onPressed: () {},
                  ),
                  TransparentButton(
                    label: "식당",
                    icon: Icon(Icons.fastfood),
                    onPressed: () {},
                  ),
                  SizedBox(width: 5),
                  TransparentButton(
                    label: "편의시설",
                    icon: Icon(Icons.place),
                    onPressed: () {
                      setState(() {
                        _showAdditionalChips = !_showAdditionalChips;
                      });
                    },
                  ),
                  SizedBox(width: 5),
                  TransparentButton(
                    label: "대중교통",
                    icon: Icon(Icons.bus_alert_rounded),
                    onPressed: () {
                      // Do something when the button is pressed
                    },
                  )

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




class CustomChip extends StatelessWidget {
  final String label;
  final Icon icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color labelColor;

  const CustomChip({
    Key? key,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    this.borderColor = Colors.black,
    this.labelColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: borderColor, width: 2.0),
      ),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          SizedBox(width: 4.0),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
            ),
          ),
        ],
      ),
    );
  }
}


class TransparentButton extends StatefulWidget {
  final String label;
  final Icon icon;
  final VoidCallback onPressed;

  TransparentButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  _TransparentButtonState createState() => _TransparentButtonState();
}

class _TransparentButtonState extends State<TransparentButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isSelected ? Colors.blue.withOpacity(0.6) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _isSelected = !_isSelected;
          });
          widget.onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            SizedBox(width: 8.0),
            Text(
              widget.label,
              style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
