import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  _MyMapScreenState createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen>
    with AutomaticKeepAliveClientMixin<MyMapScreen> {
  final TextEditingController _textController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    initMarkers();

    return PageStorage(
      bucket: PageStorageBucket(),
      child: Stack(
        children: [
          GoogleMap(
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.422, -122.084),
              zoom: 12,
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
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              Expanded(
                child: Image.network("assets/images/~~"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: "텍스트입력하세요",
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
          height: MediaQuery.of(context).size.height / 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.favorite),
              Icon(Icons.share),
              Icon(Icons.delete),
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
          height: MediaQuery.of(context).size.height / 4,
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
}
