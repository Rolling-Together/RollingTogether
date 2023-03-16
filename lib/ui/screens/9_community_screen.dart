import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rolling_together/commons/class/facility_tile.dart';
import 'package:rolling_together/commons/class/dangerous_zone_tile.dart';
import 'package:rolling_together/commons/class/popular_post_tile.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';
import 'package:rolling_together/commons/widgets/custom_appbar.dart';
import '../../commons/utils/button.dart';

class CommunityScreen extends StatefulWidget {
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  SharedDataCategory selectedCategory = SharedDataCategory.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
                      selectedCategory = selected ? category : SharedDataCategory.all;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );

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
  }
}
