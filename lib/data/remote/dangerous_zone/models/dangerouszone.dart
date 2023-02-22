import 'package:cloud_firestore/cloud_firestore.dart';

class DangerousZoneDto {
  late String? id;
  late String categoryId;
  late String description;
  late double latitude;
  late double longitude;
  late String informerId;
  late String informerName;
  late DocumentReference? reference;

  DangerousZoneDto(
      {this.id,
      required this.categoryId,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.informerId,
      required this.informerName});

  Map<String, dynamic> toMap() => {
        'categoryId': categoryId,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'informerId': informerId,
        'informerName': informerName
      };

  DangerousZoneDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    //id = map['id'];
    //categoryId = map['categoryId'];
    //description = map['description'];
    latitude = map['latitude'];
    longitude = map['longitude'];
   // informerId = map['informerId'];
  //  informerName = map['informerName'];

   // reference = snapshot.reference;
  }

  DangerousZoneDto.fromMap(Map<String, dynamic>? map) {
    id = map?['id'];
    categoryId = map?['categoryId'];
    description = map?['description'];
    latitude = map?['latitude'];
    longitude = map?['longitude'];
    informerId = map?['informerId'];
    informerName = map?['informerName'];
  }
}
