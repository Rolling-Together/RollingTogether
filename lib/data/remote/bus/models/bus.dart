import 'package:cloud_firestore/cloud_firestore.dart';

class BusDto {
  late String? id;
  late String routeNum;
  late String carNum;
  late bool lift;
  late bool liftStatus;
  late DocumentReference reference;

  BusDto(
      {this.id,
      required this.routeNum,
      required this.carNum,
      required this.lift,
      required this.liftStatus});

  Map<String, dynamic> toMap() => {
        'routeNum': routeNum,
        'carNum': carNum,
        'lift': lift,
        'liftStatus': liftStatus
      };

  BusDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = map['id'];
    routeNum = map['routeNum'];
    carNum = map['carNum'];
    lift = map['lift'];
    liftStatus = map['liftStatus'];

    reference = snapshot.reference;
  }

  BusDto.fromMap(Map<String, dynamic>? map) {
    id = map?['id'];
    routeNum = map?['routeNum'];
    carNum = map?['carNum'];
    lift = map?['lift'];
    liftStatus = map?['liftStatus'];
  }
}
