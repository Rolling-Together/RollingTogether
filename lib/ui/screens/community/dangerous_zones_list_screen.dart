import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';

import '../../../commons/class/dangerous_zone_tile.dart';

class DangerousZoneListScreen extends StatefulWidget {
  @override
  DangerousZoneListScreenState createState() => DangerousZoneListScreenState();
}

class DangerousZoneListScreenState extends State<DangerousZoneListScreen> {
  final DangerousZoneController dangerousZoneController =
      Get.put(DangerousZoneController());

  @override
  void dispose() {
    dangerousZoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          final dangerousZoneTiles = <DangerousZoneTile>[];
          for (final entry
              in dangerousZoneController.dangerousZoneListMap.entries) {
            dangerousZoneTiles.add(DangerousZoneTile(dto: entry.value));
          }

          // 리스트에 LocationTile을 추가할 때, 시간 정보를 기준으로 정렬
          // dangerousZoneTiles.sort((a, b) => b.time.compareTo(a.time));

          return ListView.builder(
              itemCount: dangerousZoneTiles.length,
              itemBuilder: (context, index) {
                return dangerousZoneTiles[index];
              });
          // return dangerousZoneTiles[index]; //ListView.builder()의
          // itemBuilder에서 정렬된 locationTiles를 사용
        }),
      ),
    );
  }
}
