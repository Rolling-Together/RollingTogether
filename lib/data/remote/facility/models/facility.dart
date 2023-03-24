import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/commons/class/base_dto.dart';
import 'package:rolling_together/commons/enum/facility_checklist.dart';
import 'package:rolling_together/commons/utils/facility_type_util.dart';
import 'package:rolling_together/data/remote/facility/models/checklist.dart';

import '../../../../commons/enum/facility_types.dart';

class FacilityDto extends BaseDto {
  late String placeId;
  late String name;
  late List<double> latlng;
  late String categoryName;
  late String categoryId;
  late String categoryGroupCode;
  late String categoryGroupName;
  late String addressName;
  late String roadAddressName;
  late String placeUrl;
  late String informerId;
  late String informerName;
  late Map<String, Map<String, dynamic>> checkListMap;

  late DocumentReference reference;

  late SharedDataCategory category;

  final Map<FacilityCheckListType, FacilityCheckListDto> checkList = {};

  FacilityDto(
      {required this.placeId,
      required this.name,
      required this.latlng,
      required this.categoryName,
      required this.categoryGroupCode,
      required this.categoryGroupName,
      required this.addressName,
      required this.categoryId,
      required this.roadAddressName,
      required this.placeUrl,
      required this.informerId,
      required this.informerName,
      required this.checkListMap,
      Timestamp? dateTime})
      : super(dateTime: dateTime ?? Timestamp(0, 0));

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
        'categoryId': categoryId,
        'checkListMap': checkListMap,
        'informerName': informerName,
        'checkListLastUpdate': FieldValue.serverTimestamp(),
        'placeUrl': placeUrl
      };

  FacilityDto.fromSnapshot(DocumentSnapshot snapshot)
      : super(dateTime: Timestamp(0, 0)) {
    var map = snapshot.data() as Map<String, dynamic>;

    placeId = map['placeId'];
    name = map['name'];
    latlng =
        map['latlng'].map<double>((e) => double.parse(e.toString())).toList();
    categoryName = map['categoryName'];
    categoryGroupName = map['categoryGroupName'];
    categoryGroupCode = map['categoryGroupCode'];
    addressName = map['addressName'];
    roadAddressName = map['roadAddressName'];
    placeUrl = map['placeUrl'];
    informerId = map['informerId'];
    categoryId = map['categoryId'];
    informerName = map['informerName'];
    checkListMap = Map.castFrom(map['checkListMap']);
    dateTime = map['checkListLastUpdate'];

    category = FacilityTypeUtil.toEnum(categoryGroupCode, categoryName);

    for (var entry in checkListMap.entries) {
      final type = FacilityCheckListType.getByFieldName(entry.key);
      final bool status = entry.value['status'];
      final List<String> imgUrls = List.castFrom(entry.value['fileNames']);

      checkList[type] =
          FacilityCheckListDto(type: type, imgUrls: imgUrls, status: status);
    }

    reference = snapshot.reference;
  }

  FacilityDto.fromMap(Map<String, dynamic>? map)
      : super(dateTime: Timestamp(0, 0)) {
    placeId = map?['placeId'];
    name = map?['name'];
    latlng =
        map?['latlng'].map<double>((e) => double.parse(e.toString())).toList();
    categoryName = map?['categoryName'];
    categoryGroupName = map?['categoryGroupName'];
    categoryGroupCode = map?['categoryGroupCode'];
    addressName = map?['addressName'];
    roadAddressName = map?['roadAddressName'];
    placeUrl = map?['placeUrl'];
    categoryId = map?['categoryId'];
    informerName = map?['informerName'];
    informerId = map?['informerId'];
    checkListMap = Map.castFrom(map?['checkListMap']);
    dateTime = map?['checkListLastUpdate'];
  }
}
