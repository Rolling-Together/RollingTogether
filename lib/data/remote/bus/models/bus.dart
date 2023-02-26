import 'package:cloud_firestore/cloud_firestore.dart';

class BusDto {
  late String? id;

  // 차량 번호(번호판) : 70자1042
  late String vehicleNo;
  late bool lift;
  late bool liftStatus;
  late DocumentReference reference;

  // 지역 코드 : 21(부산광역시)
  late String areaCode;

  // 노선 id : BSB5200083100(83-1번 버스)
  late String routeId;

  // 노선 번호 : 83-1
  late String routeNo;

  BusDto(
      {required this.vehicleNo, required this.lift, required this.liftStatus});

  Map<String, dynamic> toMap() =>
      {'lift': lift, 'liftStatus': liftStatus, 'vehicleNo': vehicleNo};

  BusDto.fromSnapshot(DocumentSnapshot snapshot, String _areaCode,
      String _routeId, String _routeNo) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = snapshot.reference.id;
    lift = map['lift'];
    liftStatus = map['liftStatus'];
    vehicleNo = map['vehicleNo'];

    reference = snapshot.reference;

    areaCode = _areaCode;
    routeId = _routeId;
    routeNo = _routeNo;
  }

  BusDto.fromMap(String docId, String _areaCode, String _routeId,
      String _routeNo, Map<String, dynamic>? map) {
    id = docId;
    lift = map?['lift'];
    liftStatus = map?['liftStatus'];
    vehicleNo = map?['vehicleNo'];

    areaCode = _areaCode;
    routeId = _routeId;
    routeNo = _routeNo;
  }
}
