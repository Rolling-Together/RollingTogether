import 'package:cloud_firestore/cloud_firestore.dart';

class DangerousZoneCommentDto {
  late String? id;
  late String content;
  late String commenterId;
  late String commenterName;
  late Timestamp dateTime;
  late DocumentReference reference;

  DangerousZoneCommentDto({this.id,
    required this.content,
    required this.commenterId,
    required this.commenterName,
    Timestamp? dateTime})
      : dateTime = dateTime ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() =>
      {
        'content': content,
        'commenterId': commenterId,
        'commenterName': commenterName,
        'dateTime': dateTime
      };


  DangerousZoneCommentDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    id = map['id'];
    content = map['content'];
    commenterId = map['commenterId'];
    commenterName = map['commenterName'];
    dateTime = map['dateTime'];

    reference = snapshot.reference;
  }

  DangerousZoneCommentDto.fromMap(Map<String, dynamic>? map) {
    id = map?['id'];
    content = map?['content'];
    commenterId = map?['commenterId'];
    commenterName = map?['commenterName'];
    dateTime = map?['dateTime'];
  }
}
