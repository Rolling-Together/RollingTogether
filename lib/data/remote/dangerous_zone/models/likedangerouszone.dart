import 'package:cloud_firestore/cloud_firestore.dart';

class LikeDangerousZoneDto {
  late String? id;
  late String userId;
  late String userName;
  late DocumentReference reference;

  LikeDangerousZoneDto({this.id, required this.userId, required this.userName});

  Map<String, dynamic> toMap() => {'userId': userId, 'userName': userName};

  LikeDangerousZoneDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    id = map['id'];
    userId = map['userId'];
    userName = map['userName'];

    reference = snapshot.reference;
  }

  LikeDangerousZoneDto.fromMap(Map<String, dynamic>? map) {
    id = map?['id'];
    userId = map?['userId'];
    userName = map?['userName'];
  }
}
