import 'package:cloud_firestore/cloud_firestore.dart';

class BusDto {
  late String? id;

  // 차량 번호(번호판) : 70자1042
  late String vehicleNo;
  late bool lift;
  late bool liftStatus;
  late DocumentReference reference;

  // 지역 코드 : 21(부산광역시)
  late String cityCode;

  // 노선 id : BSB5200083100(83-1번 버스)
  late String routeId;

  BusDto(
      {required this.vehicleNo, required this.lift, required this.liftStatus});

  Map<String, dynamic> toMap() =>
      {'lift': lift, 'liftStatus': liftStatus, 'vehicleNo': vehicleNo};

  BusDto.fromSnapshot(
      DocumentSnapshot snapshot, String _cityCode, String _routeId) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = snapshot.reference.id;
    lift = map['lift'];
    liftStatus = map['liftStatus'];
    vehicleNo = map['vehicleNo'];

    reference = snapshot.reference;

    cityCode = _cityCode;
    routeId = _routeId;
  }

  BusDto.fromMap(String docId, String _cityCode, String _routeId,
      Map<String, dynamic>? map) {
    id = docId;
    lift = map?['lift'];
    liftStatus = map?['liftStatus'];
    vehicleNo = map?['vehicleNo'];

    cityCode = _cityCode;
    routeId = _routeId;
  }
}
