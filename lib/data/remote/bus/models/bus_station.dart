import 'package:cloud_firestore/cloud_firestore.dart';

class BusStationDto {
  late String? id;
  late String stationId;
  late DocumentReference reference;

  BusStationDto({this.id, required this.stationId});

  Map<String, dynamic> toMap() => {'stationId': stationId};

  BusStationDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = map['id'];
    stationId = map['stationId'];

    reference = snapshot.reference;
  }

  BusStationDto.fromMap(Map<String, dynamic>? map) {
    id = map?['id'];
    stationId = map?['stationId'];
  }
}
