import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/community/controller/community_controller.dart';
import 'package:rolling_together/data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';

import '../../../commons/class/dangerous_zone_tile.dart';
import '../../../commons/class/popular_post_tile.dart';

class DangerousZoneListScreen extends StatefulWidget {
  @override
  DangerousZoneListScreenState createState() => DangerousZoneListScreenState();
}

class DangerousZoneListScreenState extends State<DangerousZoneListScreen> {
  final DangerousZoneController dangerousZoneController =
      Get.find<DangerousZoneController>();

  final CommunityController communityController =
      Get.find<CommunityController>();

  @override
  void dispose() {
    dangerousZoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dangerousZoneController.getMostLikesDangerousZoneList(
      communityController.lastCoords.first,
      communityController.lastCoords.last,
    );

    dangerousZoneController.getDangerousZoneList(
        communityController.lastCoords.first,
        communityController.lastCoords.last,
        false);

    return Scaffold(
      body: Column(children: [
        Obx(() => Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final entry in dangerousZoneController
                    .mostLikesDangerousZoneListMap.entries)
                  PopularPostTile(dangerousZoneDto: entry.value)
              ],
            ))),
        Obx(() {
          final dangerousZoneTiles = <DangerousZoneTile>[];
          for (final entry
              in dangerousZoneController.dangerousZoneListMap.entries) {
            dangerousZoneTiles.add(DangerousZoneTile(dto: entry.value));
          }

          return Expanded(
              child: ListView.builder(
                  itemCount: dangerousZoneTiles.length,
                  itemBuilder: (context, index) {
                    return dangerousZoneTiles[index];
                  }));
        }),
      ]),
    );
  }
}
