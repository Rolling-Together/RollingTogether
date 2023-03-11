import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rolling_together/ui/screens/13_facility_screen.dart';
import 'package:rolling_together/ui/screens/6_dangerous_zone_screen.dart';
import 'package:rolling_together/ui/screens/8_trans_screen.dart';
import '../../commons/widgets/custom_chip.dart';
import 'package:get/get.dart';
import 'new_page.dart';
import 'option_page.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  _MyMapScreenState createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen>
    with AutomaticKeepAliveClientMixin<MyMapScreen> {
  final TextEditingController _textController = TextEditingController();
  late GoogleMapController _controller;
  Location _location = Location();
  bool _showAdditionalChips = false;

  LatLng centerCoords = LatLng(0.0, 0.0);

  Future<LocationData?> getCurrentLocation() async {
    try {
      return await _location.getLocation();
    } catch (e) {
      return null;
    }
  }

  // initialize markers
  Set<Marker> _markers = {};

  @override
  bool get wantKeepAlive => true;

  initMarkers() {
    _markers = {
      Marker(
        markerId: MarkerId("blue_marker"),
        position: LatLng(37.422, -122.084),
        onTap: () {
          _showBlueMarkerBottomSheet();
        },
      ),
      Marker(
        markerId: MarkerId("red_marker"),
        position: LatLng(37.432, -122.094),
        onTap: () {
          _showRedMarkerBottomSheet();
        },
      ),
      Marker(
        markerId: MarkerId("yellow_marker"),
        position: LatLng(37.442, -122.104),
        onTap: () {
          _showYellowMarkerBottomSheet();
        },
      ),
    };
  }

  onCameraMoved(CameraPosition position) {
    centerCoords = position.target;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    initMarkers();
    //final screenWidth = MediaQuery.of(context).size.width;

    return PageStorage(
      bucket: PageStorageBucket(),
      child: Stack(
        children: [
          Container(),
          GoogleMap(
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            onCameraMove: onCameraMoved,
            initialCameraPosition: CameraPosition(
              target: LatLng(35.1348, 129.1009),
              zoom: 12,
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
                    child:
                        CostomChip('편의시설', Icon(Icons.place), Colors.yellow)),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewPage()),
                        );
                      },
                      child:
                          CostomChip('식당', Icon(Icons.fastfood), Colors.yellow),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewPage()),
                        );
                      },
                      child: CostomChip(
                          '카페', Icon(Icons.emoji_food_beverage), Colors.yellow),
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
                showOptions(context);
              },
              child: Text('글쓰기'),
            ),
          ),
          Positioned(
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
          ),
        ],
      ), // Unique bucket for this page
    );
  }

  _showBlueMarkerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  'https://th.bing.com/th/id/OIP.kEyTyMJU1dubq8WTztPsCgHaFj?w=262&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                      Text(
                        'Title 3',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Description 3'),
                      Text(
                        'Title 4',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Description 4'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showRedMarkerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Title 1',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Description 1'),
                        ],
                      ),
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
        );
      },
    );
  }

  _showYellowMarkerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.edit),
              Icon(Icons.done),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void showOptions(BuildContext context) {
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
                  Get.to(FacilityScreen(),  arguments: {'latlng': centerCoords});
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
