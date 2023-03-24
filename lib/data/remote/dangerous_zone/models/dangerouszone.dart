import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/commons/class/base_dto.dart';

import '../likes/models/likes_dangerous_zone.dart';

class DangerousZoneDto extends BaseDto {
  late String? id;
  late String categoryId;
  late String description;
  late List<double> latlng;
  late String informerId;
  late String informerName;
  late List<String> tipOffPhotos;
  late String addressName;
  late int likeCounts;

  late List<String> likes;
  late DocumentReference? reference;

  DangerousZoneDto(
      {this.id,
      required this.categoryId,
      required this.description,
      required this.latlng,
      required this.informerId,
      required this.tipOffPhotos,
      required this.informerName,
      required this.addressName,
      required this.likeCounts,
      required this.likes,
      Timestamp? dateTime})
      : super(dateTime: dateTime ?? Timestamp(0, 0));

  Map<String, dynamic> toMap() => {
        'categoryId': categoryId,
        'description': description,
        'latlng': latlng,
        'informerId': informerId,
        'informerName': informerName,
        'tipOffPhotos': tipOffPhotos,
        'addressName': addressName,
        'likeCounts': likeCounts,
        'likes': likes,
        'dateTime': FieldValue.serverTimestamp(),
      };

  DangerousZoneDto.fromSnapshot(DocumentSnapshot snapshot)
      : super(dateTime: Timestamp(0, 0)) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = snapshot.reference.id;
    categoryId = map['categoryId'];
    description = map['description'];
    latlng =
        map['latlng'].map<double>((e) => double.parse(e.toString())).toList();
    informerId = map['informerId'];
    informerName = map['informerName'];
    addressName = map['addressName'];
    likeCounts = map['likeCounts'];
    tipOffPhotos =
        map['tipOffPhotos'].map<String>((e) => e.toString()).toList();
    dateTime = map['dateTime'];
    likes = map['likes'].map<String>((e) => e.toString()).toList();

    reference = snapshot.reference;
  }

  DangerousZoneDto.fromMap(String _id, Map<String, dynamic>? map)
      : super(dateTime: Timestamp(0, 0)) {
    id = _id;
    categoryId = map?['categoryId'];
    description = map?['description'];
    latlng =
        map?['latlng'].map<double>((e) => double.parse(e.toString())).toList();
    informerId = map?['informerId'];
    informerName = map?['informerName'];
    likeCounts = map?['likeCounts'];
    addressName = map?['addressName'];
    tipOffPhotos =
        map?['tipOffPhotos'].map<String>((e) => e.toString()).toList();
    dateTime = map?['dateTime'];
    likes = map?['likes'].map<String>((e) => e.toString()).toList();
  }
}
