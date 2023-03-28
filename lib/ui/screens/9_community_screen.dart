import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rolling_together/commons/class/i_refresh_data.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';

import '../../commons/widgets/custom_appbar.dart';
import '../../data/remote/community/controller/community_controller.dart';
import '../../data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';
import '../../data/remote/facility/controllers/facility_controller.dart';
import '../../data/remote/map/controller/my_map_controller.dart';
import 'community/all_post_list_screen.dart';
import 'community/dangerous_zones_list_screen.dart';
import 'community/facility_list_screen.dart';

class CommunityScreen extends StatefulWidget implements OnRefreshDataListener {
  final CommunityController communityController =
      Get.put(CommunityController(), permanent: true);
  final MyMapController myMapController = Get.find<MyMapController>();

  final DangerousZoneController dangerousZoneController =
      Get.put(DangerousZoneController());

  final FacilityController facilityController = Get.put(FacilityController());

  @override
  _CommunityScreenState createState() => _CommunityScreenState();

  @override
  void refreshData() {
    createState();
  }
}

class _CommunityScreenState extends State<CommunityScreen>
    implements OnRefreshDataListener {
  SharedDataCategory selectedCategory = SharedDataCategory.all;

  @override
  void refreshData() {
    // how to redraw this widget
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    widget.communityController.lastCoords.value =
        widget.myMapController.currentCoords;
    widget.communityController.reverseGeocoding();

    return Scaffold(
      appBar: AppBar(title: Obx(() {
        if (widget.communityController.lastAddress.value == '') {
          return const Text('loading...');
        } else {
          return Text(widget.communityController.lastAddress.value);
        }
      })),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              spacing: 5.0,
              children: [
                SharedDataCategory.all,
                SharedDataCategory.dangerousZone,
                SharedDataCategory.facility
              ].map((SharedDataCategory category) {
                return ChoiceChip(
                  label: Text(category.name),
                  selected: selectedCategory == category,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedCategory =
                      selected ? category : SharedDataCategory.all;
                    });
                  },
                );
              }).toList(),
            ),
            if (selectedCategory == SharedDataCategory.dangerousZone)
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 20),
                child: Row(
                  children: [
                    const Text('인기 게시글',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),),
                    const SizedBox(width: 2.0),
                    Icon(Icons.favorite_border, color: Colors.red,)
                  ],
                ),
              ),
            if (selectedCategory == SharedDataCategory.dangerousZone)
              Expanded(child: DangerousZoneListScreen())
            else if (selectedCategory == SharedDataCategory.facility)
              Expanded(child: FacilityListScreenWidget())
            else
              Expanded(child: (AllPostListScreen()))
          ],
        ),
      ),
    );
  }
}
