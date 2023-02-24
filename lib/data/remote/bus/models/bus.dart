import 'package:cloud_firestore/cloud_firestore.dart';

class BusDto {
  // 차량 번호(번호판)
  late String? vehicleNo;
  late bool lift;
  late bool liftStatus;
  late DocumentReference reference;

  BusDto({this.vehicleNo, required this.lift, required this.liftStatus});

  Map<String, dynamic> toMap() => {'lift': lift, 'liftStatus': liftStatus};

  BusDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    vehicleNo = snapshot.reference.id;
    lift = map['lift'];
    liftStatus = map['liftStatus'];

    reference = snapshot.reference;
  }

  BusDto.fromMap(String _id, Map<String, dynamic>? map) {
    vehicleNo = _id;
    lift = map?['lift'];
    liftStatus = map?['liftStatus'];
  }
}
