import 'package:cloud_firestore/cloud_firestore.dart';

class UserDto {
  late String? id;
  late String name;
  late String email;
  late List<String> dangerousZoneReportList;
  late List<String> busReportList;
  late List<String> facilityReportList;
  late List<String> dangerousZoneLikeList;
  late List<String> facilityReviewList;
  late DocumentReference reference;

  UserDto(
      {this.id,
      required this.name,
      required this.email,
      required this.dangerousZoneReportList,
      required this.busReportList,
      required this.facilityReportList,
      required this.dangerousZoneLikeList,
      required this.facilityReviewList});

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'dangerousZoneReportList': dangerousZoneReportList,
        'busReportList': busReportList,
        'facilityReportList': facilityReportList,
        'dangerousZoneLikeList': dangerousZoneLikeList,
        'facilityReviewList': facilityReviewList,
      };

  UserDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    id = map['id'];
    name = map['name'];
    email = map['email'];
    dangerousZoneReportList = map['dangerousZoneReportList'];
    busReportList = map['busReportList'];
    facilityReportList = map['facilityReportList'];
    dangerousZoneLikeList = map['dangerousZoneLikeList'];
    facilityReviewList = map['facilityReviewList'];

    reference = snapshot.reference;
  }

  UserDto.fromMap(Map<String, dynamic>? map) {
    id = map?['id'];
    name = map?['name'];
    email = map?['email'];
    dangerousZoneReportList = map?['dangerousZoneReportList'];
    busReportList = map?['busReportList'];
    facilityReportList = map?['facilityReportList'];
    dangerousZoneLikeList = map?['dangerousZoneLikeList'];
    facilityReviewList = map?['facilityReviewList'];
  }
}
