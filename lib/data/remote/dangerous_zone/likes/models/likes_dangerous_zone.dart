import 'package:cloud_firestore/cloud_firestore.dart';

class LikesDangerousZoneDto {
  late String? id;
  late String dangerousZoneDocId;

  // key : 유저uid, value : 유저명
  late Map<String, String> likes;

  late List<double> latlng;

  late DocumentReference reference;

  LikesDangerousZoneDto(
      {this.id, required this.dangerousZoneDocId, required this.likes});

  Map<String, dynamic> toMap() => {
        'dangerousZoneDocId': dangerousZoneDocId,
        'likes': likes,
        'latlng': latlng,
      };

  LikesDangerousZoneDto.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    id = snapshot.reference.id;

    dangerousZoneDocId = map['dangerousZoneDocId'];
    likes = map['likes'];
    latlng = map['latlng'];

    reference = snapshot.reference;
  }

  LikesDangerousZoneDto.fromMap(String docId, Map<String, dynamic>? map) {
    id = docId;
    dangerousZoneDocId = map?['dangerousZoneDocId'];
    likes = map?['likes'];
    latlng = map?['latlng'];
  }
}
