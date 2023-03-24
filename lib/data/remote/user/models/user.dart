import 'package:cloud_firestore/cloud_firestore.dart';

import '../../grade/models/user_grade.dart';

class UserDto {
  late String? id;
  late String name;
  late String email;
  late DocumentReference reference;

  UserGradeDto? userGradeDto;

  UserDto({
    this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
      };

  UserDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = snapshot.reference.id;
    name = map['name'];
    email = map['email'];

    reference = snapshot.reference;
  }

  UserDto.fromMap(String _id, Map<String, dynamic>? map) {
    id = _id;
    name = map?['name'];
    email = map?['email'];
  }
}
