import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/commons/class/base_dto.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';
import '../../../commons/class/dangerous_zone_tile.dart';
import '../../../commons/class/facility_tile.dart';
import '../../../data/remote/community/controller/community_controller.dart';
import '../../../data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';
import '../../../data/remote/dangerous_zone/models/dangerouszone.dart';
import '../../../data/remote/facility/controllers/facility_controller.dart';
import '../../../data/remote/facility/models/facility.dart';

class AllPostListScreen extends StatelessWidget {
  final CommunityController communityController =
      Get.find<CommunityController>();
  final DangerousZoneController dangerousZoneController =
      Get.find<DangerousZoneController>();
  final FacilityController facilityController = Get.find<FacilityController>();

  @override
  Widget build(BuildContext context) {
    dangerousZoneController.getDangerousZoneList(
        communityController.lastCoords.first,
        communityController.lastCoords.last,
        true);

    facilityController.getFacilityList(
      SharedDataCategory.toList(),
      communityController.lastCoords.first,
      communityController.lastCoords.last,
    );

    return Scaffold(body: Obx(() {
      final posts = <BaseDto>[];

      for (final entry
          in dangerousZoneController.dangerousZoneListMap.entries) {
        posts.add(entry.value);
      }

      for (final v in facilityController.facilityList) {
        posts.add(v);
      }

      posts.sort((a, b) => b.dateTime.compareTo(a.dateTime));

      return posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                if (posts[index] is DangerousZoneDto) {
                  return DangerousZoneTile(
                      dto: posts[index] as DangerousZoneDto);
                } else {
                  FacilityDto dto = posts[index] as FacilityDto;
                  return FacilityTile(facilityDto: dto);
                }
              },
            );
    }));
  }
}
