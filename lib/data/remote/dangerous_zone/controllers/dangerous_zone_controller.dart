import 'package:get/get.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/dangerous_zone/service/dangerous_zone_service.dart';

class DangerousZoneController extends GetxController {
  final DangerousZoneService service = DangerousZoneService();
  final RxList<DangerousZoneDto> dangerousZoneList = <DangerousZoneDto>[].obs;

  getDangerousZoneList(String latitude, String longitude) {
    // 위험 장소 목록 가져오기
    dangerousZoneList
        .bindStream(service.getDangerousZoneList(latitude, longitude));
  }

}
