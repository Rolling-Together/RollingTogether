import 'package:cloud_firestore/cloud_firestore.dart';

class TipOffPhotoDto {
  final String? id;
  final String url;
  final Timestamp dateTime;

  TipOffPhotoDto({this.id, required this.url, Timestamp? dateTime})
      : dateTime = dateTime ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() => {'url': url, 'dateTime': dateTime};
}
