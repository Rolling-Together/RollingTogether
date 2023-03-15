import 'package:get/get.dart';
import 'package:rolling_together/data/remote/reverse_geocoding/models/reverse_geocoding_response.dart';
import 'package:rolling_together/data/remote/reverse_geocoding/service/reverse_geocoding_service.dart';

class ReverseGeocodingController extends GetxController {
  final reverseGeocodingService = ReverseGeocodingService();

  final Rx<Document?> addressResult = Document().obs;

  /// 위경도 -> 주소
  coordToAddress(double latitude, double longitude) {
    reverseGeocodingService.coordToAddress(latitude, longitude).then((result) {
      addressResult.value = result.documents.first;
    }, onError: (obj) {
      addressResult.value = null;
    });
  }
}
