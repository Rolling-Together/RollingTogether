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
            Row(
              children: [
                const Text('인기 게시글'),
                Icon(Icons.favorite_border)
              ],
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
/*
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),

          /// 카테고리 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundedButton(
                text: "전체",
                color: selectedCategory == "전체" ? Colors.blue : Colors.grey,
                onPressed: () => selectCategory("전체"),
              ),
              RoundedButton(
                text: "위험 장소",
                color: selectedCategory == "위험 장소" ? Colors.blue : Colors.grey,
                onPressed: () => selectCategory("위험 장소"),
              ),
              RoundedButton(
                text: "편의 시설",
                color: selectedCategory == "편의 시설" ? Colors.blue : Colors.grey,
                onPressed: () => selectCategory("편의 시설"),
              ),
            ],
          ),
          selectedCategory == "위험 장소"
              ? Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopularPostTile(),
                      PopularPostTile(),
                      PopularPostTile(),
                    ],
                  ))
              : SizedBox(
                  height: 0,
                ),

          /// 선택된 카테고리에 따라 다른 리스트 보여주기
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10, // 리스트 개수는 임의로 설정
                itemBuilder: (context, index) {
                  if (selectedCategory == "전체") {
                    if (index < dangerousZoneTiles.length) {
                      return dangerousZoneTiles[index];
                    } else if (index <
                        dangerousZoneTiles.length + facilityTiles.length) {
                      return facilityTiles[index - dangerousZoneTiles.length];
                    } else {
                      return Container();
                    }
                  } else if (selectedCategory == "위험 장소") {
                  } else if (selectedCategory == "음식점/카페") {
                    DateTime now = DateTime.now();
                    DateTime time = DateTime(now.year, 1, 1)
                        .add(Duration(
                            days: Random().nextInt(
                                365))) // 1월 1일부터 365일 중 랜덤한 일 수를 더해줍니다.
                        .add(Duration(
                            hours: Random().nextInt(24))) // 랜덤한 시간을 더해줍니다.
                        .add(Duration(
                            minutes: Random().nextInt(60))); // 랜덤한 분을 더해줍니다.

                    while (time.isAfter(now)) {
                      // 생성된 시간이 현재 시간 이후인 동안 반복합니다.
                      time = DateTime(now.year, 1, 1)
                          .add(Duration(days: Random().nextInt(365)))
                          .add(Duration(hours: Random().nextInt(24)))
                          .add(Duration(minutes: Random().nextInt(60)));
                    }

                    String formattedtime =
                        DateFormat('yy/MM/dd  HH:mm').format(time);

                    facilityTiles
                        .add(FacilityTile(time: formattedtime.toString()));
                    // 리스트에 LocationTile을 추가할 때, 시간 정보를 기준으로 정렬
                    facilityTiles.sort((a, b) => b.time.compareTo(a.time));

                    return facilityTiles[
                        index]; //ListView.builder()의 itemBuilder에서 정렬된 locationTiles를 사용
                  }
                  return Container();
                }),
          ),
        ],
      ),
    );
 */
  }
}
