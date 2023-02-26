import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rolling_together/commons/class/facility_tile.dart';
import 'package:rolling_together/commons/class/location_tile.dart';
import 'package:rolling_together/commons/class/popular_post_tile.dart';
import 'package:rolling_together/commons/widgets/custom_appbar.dart';
import '../../commons/utils/button.dart';

class CommunityScreen extends StatefulWidget {
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  String selectedCategory = "전체";

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                text: "위험장소",
                color: selectedCategory == "위험장소" ? Colors.blue : Colors.grey,
                onPressed: () => selectCategory("위험장소"),
              ),
              RoundedButton(
                text: "음식점/카페",
                color: selectedCategory == "음식점/카페" ? Colors.blue : Colors.grey,
                onPressed: () => selectCategory("음식점/카페"),
              ),
            ],
          ),

          selectedCategory == "음식점/카페"
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
                    return ListTile(
                      title: Text("전체 리스트 $index"),
                    );
                  } else if (selectedCategory == "위험장소") {
                    return LocationTile();
                  } else if (selectedCategory == "음식점/카페") {
                    return FacilityTile();
                  }
                  return Container();
                }),
          ),
        ],
      ),
    );
  }
}
