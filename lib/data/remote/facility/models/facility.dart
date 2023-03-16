import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/commons/utils/facility_type_util.dart';

import '../../../../commons/enum/facility_types.dart';

class FacilityDto {
  late String placeId;
  late String name;
  late List<double> latlng;
  late String categoryName;
  late String categoryGroupCode;
  late String categoryGroupName;
  late String addressName;
  late String roadAddressName;
  late String placeUrl;
  late String informerId;
  late Map<String, Map<String, dynamic>> checkListMap;
  late Timestamp checkListLastUpdate;
  late DocumentReference reference;

  late SharedDataCategory category;

  FacilityDto(
      {required this.placeId,
      required this.name,
      required this.latlng,
      required this.categoryName,
      required this.categoryGroupCode,
      required this.categoryGroupName,
      required this.addressName,
      required this.roadAddressName,
      required this.placeUrl,
      required this.informerId,
      required this.checkListMap,
      Timestamp? checkListLastUpdate})
      : checkListLastUpdate = checkListLastUpdate ?? Timestamp(0, 0);

  Map<String, dynamic> toMap() => {
        'placeId': placeId,
        'name': name,
        'latlng': latlng,
        'categoryName': categoryName,
        'categoryGroupName': categoryGroupName,
        'categoryGroupCode': categoryGroupCode,
        'addressName': addressName,
        'informerId': informerId,
        'roadAddressName': roadAddressName,
        'checkListMap': checkListMap,
        'checkListLastUpdate': FieldValue.serverTimestamp(),
        'placeUrl': placeUrl
      };

  FacilityDto.fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    placeId = map['placeId'];
    name = map['name'];
    latlng = map['latlng'];
    categoryName = map['categoryName'];
    categoryGroupName = map['categoryGroupName'];
    categoryGroupCode = map['categoryGroupCode'];
    addressName = map['addressName'];
    roadAddressName = map['roadAddressName'];
    placeUrl = map['placeUrl'];
    informerId = map['informerId'];
    checkListMap = map['checkListMap'];
    checkListLastUpdate = map['checkListLastUpdate'];

    category = FacilityTypeUtil.toEnum(categoryGroupCode, categoryName);

    reference = snapshot.reference;
  }

  FacilityDto.fromMap(Map<String, dynamic>? map) {
    placeId = map?['placeId'];
    name = map?['name'];
    latlng = map?['latlng'];
    categoryName = map?['categoryName'];
    categoryGroupName = map?['categoryGroupName'];
    categoryGroupCode = map?['categoryGroupCode'];
    addressName = map?['addressName'];
    roadAddressName = map?['roadAddressName'];
    placeUrl = map?['placeUrl'];
    informerId = map?['informerId'];
    checkListMap = map?['checkListMap'];
    checkListLastUpdate = map?['checkListLastUpdate'];
  }
}
