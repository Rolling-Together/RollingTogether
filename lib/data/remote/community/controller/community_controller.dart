import 'package:get/get.dart';
import 'package:rolling_together/data/remote/reverse_geocoding/controllers/reverse_geocoding_controller.dart';
import 'package:rolling_together/data/remote/reverse_geocoding/service/reverse_geocoding_service.dart';

class CommunityController extends GetxController {
  ReverseGeocodingService reverseGeocodingService = ReverseGeocodingService();

  final RxList<double> lastCoords = RxList([]);
  final Rx<String> lastAddress = Rx('');

  reverseGeocoding() {
    reverseGeocodingService
        .coordToAddress(lastCoords.first, lastCoords.last)
        .then((value) {
      lastAddress.value = value.documents.first.address.addressName;
    }, onError: (error) {});
  }
}
