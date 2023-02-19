class LikeDangerousZoneDto {
  final String? id;
  final String userId;
  final String userName;

  LikeDangerousZoneDto({this.id, required this.userId, required this.userName});

  Map<String, dynamic> toMap() => {'userId': userId, 'userName': userName};
}
