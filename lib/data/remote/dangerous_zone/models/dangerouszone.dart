import 'package:cloud_firestore/cloud_firestore.dart';

class DangerousZoneDto {
  late String? id;
  late String categoryId;
  late String description;
  late List<double> latlng;
  late String informerId;
  late String informerName;
  late List<String> tipOffPhotos;
  late Map<String, String> like;
  late Timestamp dateTime;
  late DocumentReference? reference;

  DangerousZoneDto(
      {this.id,
      required this.categoryId,
      required this.description,
      required this.latlng,
      required this.informerId,
      required this.tipOffPhotos,
      required this.like,
      required this.informerName,
      Timestamp? dateTime})
      : dateTime = dateTime ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() => {
        'categoryId': categoryId,
        'description': description,
        'latlng': latlng,
        'informerId': informerId,
        'informerName': informerName,
        'tipOffPhotos': tipOffPhotos,
        'dateTime': FieldValue.serverTimestamp(),
        'like': like,
      };

  DangerousZoneDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = snapshot.reference.id;
    categoryId = map['categoryId'];
    description = map['description'];
    latlng = map['latlng'];
    informerId = map['informerId'];
    informerName = map['informerName'];
    tipOffPhotos = map['tipOffPhotos'];
    dateTime = map['dateTime'];
    like = map['like'];

    reference = snapshot.reference;
  }

  DangerousZoneDto.fromMap(String _id, Map<String, dynamic>? map) {
    id = _id;
    categoryId = map?['categoryId'];
    description = map?['description'];
    latlng = map?['latlng'];
    informerId = map?['informerId'];
    informerName = map?['informerName'];
    tipOffPhotos = map?['tipOffPhotos'];
    dateTime = map?['dateTime'];
    like = map?['like'];
  }
}
