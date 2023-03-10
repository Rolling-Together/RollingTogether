import 'package:cloud_firestore/cloud_firestore.dart';

class FacilityReviewDto {
  late String? id;
  late String userId;
  late String userName;
  late Timestamp dateTime;
  late String content;
  late DocumentReference reference;

  FacilityReviewDto(
      {this.id,
      required this.userId,
      required this.userName,
      required this.content,
      Timestamp? dateTime})
      : dateTime = dateTime ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'userName': userName,
        'dateTime': FieldValue.serverTimestamp(),
        'content': content
      };

  FacilityReviewDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    id = snapshot.reference.id;
    userId = map['userId'];
    userName = map['userName'];
    dateTime = map['dateTime'];
    content = map['content'];

    reference = snapshot.reference;
  }

  FacilityReviewDto.fromMap(String _id, Map<String, dynamic>? map) {
    id = _id;
    userId = map?['userId'];
    userName = map?['userName'];
    dateTime = map?['dateTime'];
    content = map?['content'];
  }
}
