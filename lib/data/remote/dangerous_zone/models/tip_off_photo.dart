import 'package:cloud_firestore/cloud_firestore.dart';

class TipOffPhotoDto {
  late String? id;
  late String url;
  late Timestamp dateTime;
  late DocumentReference reference;

  TipOffPhotoDto({this.id, required this.url, Timestamp? dateTime})
      : dateTime = dateTime ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() => {'url': url, 'dateTime': dateTime};

  TipOffPhotoDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    id = map['id'];
    url = map['url'];
    dateTime = map['dateTime'];

    reference = snapshot.reference;
  }

  TipOffPhotoDto.fromMap(Map<String, dynamic>? map) {
    id = map?['id'];
    url = map?['url'];
    dateTime = map?['dateTime'];
  }
}
