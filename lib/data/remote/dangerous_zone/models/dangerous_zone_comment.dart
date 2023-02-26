import 'package:cloud_firestore/cloud_firestore.dart';

class DangerousZoneCommentDto {
  late String? id;
  late String content;
  late String commenterId;
  late String commenterName;
  late Timestamp dateTime;
  late DocumentReference reference;

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
        'dateTime': FieldValue.serverTimestamp(),
      };

  DangerousZoneCommentDto.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    id = snapshot.reference.id;

    content = map['content'];
    commenterId = map['commenterId'];
    commenterName = map['commenterName'];
    dateTime = map['dateTime'];

    reference = snapshot.reference;
  }

  DangerousZoneCommentDto.fromMap(String docId, Map<String, dynamic>? map) {
    id = docId;
    content = map?['content'];
    commenterId = map?['commenterId'];
    commenterName = map?['commenterName'];
    dateTime = map?['dateTime'];
  }
}
