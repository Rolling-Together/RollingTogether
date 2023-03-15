import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolling_together/data/remote/search_places/controllers/search_places_controller.dart';

///  장소 검색 화면, 위경도 값을 받아야 함
class SearchPlacesPage extends StatefulWidget {
  const SearchPlacesPage({super.key});

  @override
  SearchPlacesPageState createState() => SearchPlacesPageState();
}

class SearchPlacesPageState extends State<SearchPlacesPage> {
  final SearchPlacesController searchController =
      Get.put(SearchPlacesController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final LatLng latlng = arguments['latlng'];

    searchController.latitude = latlng.latitude;
    searchController.longitude = latlng.longitude;

    return Scaffold(
      appBar: AppBar(
        title: const Text('검색'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController.textEditingController,
              decoration: InputDecoration(
                hintText: '검색할 장소를 입력',
                suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      searchController.searchPlaces(
                          searchController.latitude,
                          searchController.longitude,
                          searchController.textEditingController.text);
                    }),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => searchController.places.isEmpty
                ? const Center(
                    child: Text('검색'),
                  )
                : ListView.builder(
                    itemCount: searchController.places.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Column(
                          children: [
                            Text(
                              searchController.places[index].placeName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(searchController.places[index].categoryName),
                            Text(
                              searchController.places[index].addressName,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.back(result: searchController.places[index]);
                        },
                      );
                    },
                  )),
          ),
        ],
      ),
    );
  }
}
