import 'package:cloud_firestore/cloud_firestore.dart';

import '../likes/models/likes_dangerous_zone.dart';

class DangerousZoneDto {
  late String? id;
  late String categoryId;
  late String description;
  late List<double> latlng;
  late String informerId;
  late String informerName;
  late List<String> tipOffPhotos;
  late String addressName;

  late Map<String, String> likes;
  late Timestamp dateTime;
  late DocumentReference? reference;

  DangerousZoneDto({this.id,
    required this.categoryId,
    required this.description,
    required this.latlng,
    required this.informerId,
    required this.tipOffPhotos,
    required this.informerName,
    required this.addressName,
    required this.likes,
    Timestamp? dateTime})
      : dateTime = dateTime ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() =>
      {
        'categoryId': categoryId,
        'description': description,
        'latlng': latlng,
        'informerId': informerId,
        'informerName': informerName,
        'tipOffPhotos': tipOffPhotos,
        'addressName': addressName,
        'likes': likes,
        'dateTime': FieldValue.serverTimestamp(),
      };

  DangerousZoneDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = snapshot.reference.id;
    categoryId = map['categoryId'];
    description = map['description'];
    latlng = map['latlng'];
    informerId = map['informerId'];
    informerName = map['informerName'];
    addressName = map['addressName'];
    tipOffPhotos = map['tipOffPhotos'];
    dateTime = map['dateTime'];
    likes = map['likes'];

    reference = snapshot.reference;
  }

  DangerousZoneDto.fromMap(String _id, Map<String, dynamic>? map) {
    id = _id;
    categoryId = map?['categoryId'];
    description = map?['description'];
    latlng = map?['latlng'];
    informerId = map?['informerId'];
    informerName = map?['informerName'];
    addressName = map?['addressName'];
    tipOffPhotos = map?['tipOffPhotos'];
    dateTime = map?['dateTime'];
    likes = map?['likes'];
  }
}
