import 'package:cloud_firestore/cloud_firestore.dart';

class FacilityDto {
  late String placeId;
  late String name;
  late String latitude;
  late String longitude;
  late String categoryName;
  late String categoryGroupCode;
  late String categoryGroupName;
  late String addressName;
  late String roadAddressName;
  late String placeUrl;
  late Map<String, Map<String, dynamic>> checkListMap;
  late Timestamp checkListLastUpdate;
  late DocumentReference reference;

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
      required this.placeUrl,
      required this.checkListMap,
      Timestamp? checkListLastUpdate})
      : checkListLastUpdate = checkListLastUpdate ?? Timestamp(0, 0);

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
        'checkListMap': checkListMap,
        'checkListLastUpdate': FieldValue.serverTimestamp(),
        'placeUrl': placeUrl
      };

  FacilityDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    placeId = map['placeId'];
    name = map['name'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    categoryName = map['categoryName'];
    categoryGroupName = map['categoryGroupName'];
    categoryGroupCode = map['categoryGroupCode'];
    addressName = map['addressName'];
    roadAddressName = map['roadAddressName'];
    placeUrl = map['placeUrl'];
    checkListMap = map['checkListMap'];
    checkListLastUpdate = map['checkListLastUpdate'];

    reference = snapshot.reference;
  }

  FacilityDto.fromMap(Map<String, dynamic>? map) {
    placeId = map?['placeId'];
    name = map?['name'];
    latitude = map?['latitude'];
    longitude = map?['longitude'];
    categoryName = map?['categoryName'];
    categoryGroupName = map?['categoryGroupName'];
    categoryGroupCode = map?['categoryGroupCode'];
    addressName = map?['addressName'];
    roadAddressName = map?['roadAddressName'];
    placeUrl = map?['placeUrl'];
    checkListMap = map?['checkListMap'];
    checkListLastUpdate = map?['checkListLastUpdate'];
  }
}
