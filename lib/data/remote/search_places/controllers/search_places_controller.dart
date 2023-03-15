import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/search_places/models/places_response.dart';
import 'package:rolling_together/data/remote/search_places/service/search_places_service.dart';

class SearchPlacesController extends GetxController {
  final searchPlacesService = SearchPlacesService();
  final TextEditingController textEditingController = TextEditingController();

  final RxList<Place> places = RxList();

  double latitude = 0.0;
  double longitude = 0.0;

  searchPlaces(double latitude, double longitude, String query) {
    searchPlacesService.searchPlaces(latitude, longitude, query).then((value) {
      places.value = value.documents;
    }, onError: (obj) {
      places.value = [];
    });
  }
}
