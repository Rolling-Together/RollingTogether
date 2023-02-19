import 'package:rolling_together/data/remote/facility/models/checklist.dart';

class FacilityDto {
  final String placeId;
  final String name;
  final String latitude;
  final String longitude;
  final String categoryName;
  final String categoryGroupCode;
  final String categoryGroupName;
  final String addressName;
  final String roadAddressName;
  final String placeUrl;

  FacilityDto(
      {required this.placeId,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.categoryName,
      required this.categoryGroupCode,
      required this.categoryGroupName,
      required this.addressName,
      required this.roadAddressName,
      required this.placeUrl});

  Map<String, dynamic> toMap() => {
        'placeId': placeId,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'categoryName': categoryName,
        'categoryGroupName': categoryGroupName,
        'categoryGroupCode': categoryGroupCode,
        'addressName': addressName,
        'roadAddressName': roadAddressName,
        'placeUrl': placeUrl
      };
}
