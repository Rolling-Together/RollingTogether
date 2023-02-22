import 'package:cloud_firestore/cloud_firestore.dart';

class FacilityCheckList {
  late bool toilet;
  late bool elevator;
  //문턱
  late bool threshold;
  //경사로
  late bool ramp;

  late DocumentReference reference;

  FacilityCheckList(
      {required this.toilet,
      required this.elevator,
      required this.threshold,
      required this.ramp});

  Map<String, dynamic> toMap() => {
        'toilet': toilet,
        'elevator': elevator,
        'threshold': threshold,
        'ramp': ramp
      };

  FacilityCheckList.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    toilet = map['toilet'];
    elevator = map['elevator'];
    threshold = map['threshold'];
    ramp = map['ramp'];

    reference = snapshot.reference;
  }

  FacilityCheckList.fromMap(Map<String, dynamic>? map) {
    toilet = map?['toilet'];
    elevator = map?['elevator'];
    threshold = map?['threshold'];
    ramp = map?['ramp'];
  }
}
