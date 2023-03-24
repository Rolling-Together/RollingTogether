import 'dart:io';

import 'package:rolling_together/commons/enum/facility_checklist.dart';

class FacilityCheckListDto {
  final FacilityCheckListType type;
  final List<File> files = [];
  final List<String> imgUrls;
  bool status = false;

  FacilityCheckListDto(
      {required this.type, required this.imgUrls, required this.status});
}
