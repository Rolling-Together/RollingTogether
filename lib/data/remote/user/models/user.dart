import 'package:cloud_firestore/cloud_firestore.dart';

class UserDto {
  late String? id;
  late String name;
  late String email;
  late List<String> dangerousZoneReportList;
  late List<String> facilityReportList;
  late List<String> dangerousZoneLikeList;
  late List<String> facilityReviewList;
  late DocumentReference reference;

  UserDto(
      {this.id,
      required this.name,
      required this.email,
      required this.dangerousZoneReportList,
      required this.facilityReportList,
      required this.dangerousZoneLikeList,
      required this.facilityReviewList});

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'dangerousZoneReportList': dangerousZoneReportList,
        'facilityReportList': facilityReportList,
        'dangerousZoneLikeList': dangerousZoneLikeList,
        'facilityReviewList': facilityReviewList,
      };

  UserDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = snapshot.reference.id;
    name = map['name'];
    email = map['email'];
    dangerousZoneReportList = map['dangerousZoneReportList'];
    facilityReportList = map['facilityReportList'];
    dangerousZoneLikeList = map['dangerousZoneLikeList'];
    facilityReviewList = map['facilityReviewList'];

    reference = snapshot.reference;
  }

  UserDto.fromMap(String _id, Map<String, dynamic>? map) {
    id = _id;
    name = map?['name'];
    email = map?['email'];
    dangerousZoneReportList = map?['dangerousZoneReportList'];
    facilityReportList = map?['facilityReportList'];
    dangerousZoneLikeList = map?['dangerousZoneLikeList'];
    facilityReviewList = map?['facilityReviewList'];
  }
}
