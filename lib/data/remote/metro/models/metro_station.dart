class MetroStationDto {
  // 역사명
  final String name;

  // 노선번호
  final String routeNumber;
  final double latitude;
  final double longitude;

  MetroStationDto({
    required this.name,
    required this.routeNumber,
    required this.latitude,
    required this.longitude,
  });

  factory MetroStationDto.fromJson(Map<String, dynamic> json) {
    return MetroStationDto(
      name: json['역사명'],
      routeNumber: json['노선번호'],
      latitude: json['역위도'],
      longitude: json['역경도'],
    );
  }
}
