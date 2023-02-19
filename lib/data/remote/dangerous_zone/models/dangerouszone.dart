import 'package:cloud_firestore/cloud_firestore.dart';

class DangerousZoneDto {
  String? id;
  String categoryId;
  String description;
  String latitude;
  String longitude;
  String informerId;
  String informerName;

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

  DangerousZoneDto.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    categoryId = snapshot['categoryId'];
    description = snapshot['description'];
    latitude = snapshot['latitude'];
    longitude = snapshot['longitude'];
    informerId = snapshot['informerId'];
    informerName = snapshot['informerName'];
  }
}
