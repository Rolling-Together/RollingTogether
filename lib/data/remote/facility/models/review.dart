import 'package:cloud_firestore/cloud_firestore.dart';

class FacilityReview {
  final String? id;
  final String userId;
  final String userName;
  final Timestamp dateTime;
  final String content;

  FacilityReview(
      {this.id,
      required this.userId,
      required this.userName,
      required this.content,
      Timestamp? dateTime})
      : dateTime = dateTime ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'userName': userName,
        'dateTime': dateTime,
        'content': content
      };
}
