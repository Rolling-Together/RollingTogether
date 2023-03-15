import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../commons/widgets/custom_chip.dart';
import 'new_page.dart';
import 'option_page.dart';

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

  /*Future<LocationData?> getCurrentLocation() async {
    try {
      return await _location.getLocation();
    } catch (e) {
      return null;
    }
  }*/

  // 이 값은 지도가 시작될 때 첫 번째 위치입니다.
  final CameraPosition _initialPosition =
  CameraPosition(
      target: LatLng(35.1340990, 129.1031460),
    zoom: 14.4746,
  );

  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];

  // 마커를 탭할 때 호출되는 콜백 함수
  void onMarkerTapped(MarkerId markerId) {
    // 마커 ID를 사용하여 특정 마커를 찾음
    Marker tappedMarker = markers.firstWhere((marker) => marker.markerId == markerId);

    // If the marker with ID "1" is tapped, show the blue square
    if (markerId.value == "2") {
      //식당
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return /*Csontainer(
          height: 200,
          child: Center(
            child: Text('Marker tapped: ${tappedMarker.markerId.value}'),
          ),
        );*/
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Title 1',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 1'),
                                Text(
                                  'Title 2',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 2'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Image.network(
                              'https://th.bing.com/th/id/OIP.rRw8sYj4rXkmurs2kCtjBQHaE8?w=287&h=191&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(Icons.wheelchair_pickup),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Title 2',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 2'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Title 3',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 3'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Title 4',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 4'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
        },
      );
    } else{
      // showModalBottomSheet로 마커 정보를 표시하는 Bottom Sheet를 보여줌
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return /*Csontainer(
          height: 200,
          child: Center(
            child: Text('Marker tapped: ${tappedMarker.markerId.value}'),
          ),
        );*/
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Title 1',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 1'),
                                Text(
                                  'Title 2',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 2'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Image.network(
                              'https://th.bing.com/th/id/OIP.CWxD3nGIp_XU34nZ8G-p9AHaFj?w=263&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(Icons.wheelchair_pickup),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Title 2',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 2'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Title 3',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 3'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Title 4',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Description 4'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
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
        body: Stack(
          children: [
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
            child: Image.asset('https://th.bing.com/th/id/OIP.CWxD3nGIp_XU34nZ8G-p9AHaFj?w=263&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7',
            ),
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
                      child: CostomChip('위험장소', Icon(Icons.dangerous) ,Colors.redAccent)),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _showAdditionalChips = !_showAdditionalChips;
                        });
                      },
                      child: CostomChip('편의시설', Icon(Icons.place) ,Colors.yellow)
                  ),
                  SizedBox(width: 10),
                  CostomChip('대중교통', Icon(Icons.bus_alert_rounded) ,Colors.cyan)
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
                        onTap: () {

                        },
                        child: CostomChip('식당', Icon(Icons.fastfood), Colors.yellow),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: CostomChip('카페', Icon(Icons.emoji_food_beverage), Colors.yellow),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: CostomChip('문화', Icon(Icons.fastfood), Colors.yellow),
                     ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: CostomChip('복합', Icon(Icons.face_outlined), Colors.yellow),
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
          ]
        ),

        // floatingActionButton 클릭시 줌 아웃
        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.animateCamera(CameraUpdate.zoomOut());
          },
          child: Icon(Icons.zoom_out),
        )*/
    );
  }
}



void showOptions(BuildContext context, List<Marker> markers, GoogleMapController controller) {
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
                Marker newMarker = Marker(
                  markerId: MarkerId('8'),
                  position: LatLng(35.0, 129.0), // replace with the actual latitude and longitude of the marker
                  infoWindow: InfoWindow(title: 'Marker 8'),
                );
                markers.add(newMarker); // assuming 'markers' is the list of markers passed as a parameter
                controller.animateCamera(CameraUpdate.newLatLng(newMarker.position)); // assuming 'controller' is the map controller passed as a parameter
              },
            ),
            ListTile(
              title: Text('편의시설'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Option2Screen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('대중교통'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Option3Screen(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

