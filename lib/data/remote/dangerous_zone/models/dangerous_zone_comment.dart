import 'package:cloud_firestore/cloud_firestore.dart';

class DangerousZoneCommentDto {
  final String? id;
  final String content;
  final String commenterId;
  final String commenterName;
  final Timestamp dateTime;

  DangerousZoneCommentDto(
      {this.id,
      required this.content,
      required this.commenterId,
      required this.commenterName,
      Timestamp? dateTime})
      : dateTime = dateTime ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() => {
        'content': content,
        'commenterId': commenterId,
        'commenterName': commenterName,
        'dateTime': dateTime
      };
}
