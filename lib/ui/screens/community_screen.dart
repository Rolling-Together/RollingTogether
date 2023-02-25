import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rolling_together/commons/class/location_tile.dart';
import 'package:rolling_together/commons/widgets/custom_appbar.dart';

class CommunityScreen extends StatefulWidget {
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>  {

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
          // 카테고리 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () => selectCategory("전체"),
                child: Text(
                  "전체",
                  style: TextStyle(
                    color: selectedCategory == "전체" ? Colors.blue : null,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () => selectCategory("위험 장소"),
                child: Text(
                  "위험 장소",
                  style: TextStyle(
                    color: selectedCategory == "위험 장소" ? Colors.blue : null,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () => selectCategory("음식점/카페"),
                child: Text(
                  "음식점/카페",
                  style: TextStyle(
                    color: selectedCategory == "음식점/카페" ? Colors.blue : null,
                  ),
                ),
              ),
            ],
          ),
          // 선택된 카테고리에 따라 다른 리스트 보여주기
          Expanded(
            child: ListView.builder(
                itemCount: 10, // 리스트 개수는 임의로 설정
                itemBuilder: (context, index) {
                  if (selectedCategory == "전체") {
                    return ListTile(
                      title: Text("전체 리스트 $index"),
                    );
                  } else if (selectedCategory == "위험 장소") {
                    return LocationTile(
                    );
                  } else if (selectedCategory == "음식점/카페") {
                    return ListTile(
                      title: Text("음식점/카페 리스트 $index"),
                    );
                  }
                  return Container();
                }
            ),
          ),
        ],
      ),
    );
  }
}

