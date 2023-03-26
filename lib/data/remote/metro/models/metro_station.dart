class MetroStationDto {
  /// 역사명
  final String name;
  final String scode;

  /// 노선번호
  final String routeNumber;
  final double latitude;
  final double longitude;

  MetroStationDto({
    required this.name,
    required this.scode,
    required this.routeNumber,
    required this.latitude,
    required this.longitude,
  });

  factory MetroStationDto.fromJson(Map<String, dynamic> json, String scode) {
    return MetroStationDto(
      scode: scode,
      name: json['역사명'].toString(),
      routeNumber: json['노선번호'].toString(),
      latitude: json['역위도'],
      longitude: json['역경도'],
    );
  }
}
