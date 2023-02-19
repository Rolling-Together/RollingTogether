class UserDto {
  final String? id;
  final String name;
  final String email;
  final List<String> dangerousZoneReportList;
  final List<String> busReportList;
  final List<String> facilityReportList;
  final List<String> dangerousZoneLikeList;
  final List<String> facilityReviewList;

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
}
