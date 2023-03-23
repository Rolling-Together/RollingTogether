import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/commons/class/facility_tile.dart';
import 'package:rolling_together/data/remote/facility/controllers'
    '/facility_controller.dart';
import '../../../commons/enum/facility_types.dart';

import '../../../data/remote/community/controller/community_controller.dart';

class FacilityListScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateFacilityListScreenWidget();
}

class StateFacilityListScreenWidget extends State<FacilityListScreenWidget> {
  final FacilityController facilityController = Get.find<FacilityController>();
  final CommunityController communityController =
      Get.find<CommunityController>();

  @override
  void dispose() {
    facilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    facilityController.getFacilityList(
      SharedDataCategory.toList(),
      communityController.lastCoords.first,
      communityController.lastCoords.last,
    );

    return Scaffold(
        body: Obx(
      () => facilityController.facilityList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: facilityController.facilityList.length,
              itemBuilder: (BuildContext context, int index) {
                return FacilityTile(
                  facilityDto: facilityController.facilityList[index],
                );
              },
            ),
    ));
  }
}
