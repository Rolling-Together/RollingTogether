/* 여기 있는 것들 아이콘 넣어야함
FacilityInfo(text: '휠체어 접근 가능성', icon: Icons.accessible),
FacilityInfo(text: '장애인 엘리베이터', icon: Icons.elevator),
FacilityInfo(text: '엘리베이터 있음', icon: Icons.elevator),
FacilityInfo(text: '전동 휠체어 충전소', icon: Icons.ev_station)
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../ui/screens/7_facility_post_screen.dart';

class FacilityTile extends StatefulWidget {
  final String time; // 신고 시간
  FacilityTile({required this.time});

  _FacilityTileState createState() => _FacilityTileState();
}

class _FacilityTileState extends State<FacilityTile> {
  late Image facilityPhoto; // 사진
  late String facilityName; // 시설 이름
  late String address; // 주소

  @override
  void initState() {
    super.initState();
    getInformation();
  }

  void getInformation() {
    // comment, address, time, representativePicture 세팅하기
    setState(() {
      facilityPhoto = Image.network(
        'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
        fit: BoxFit.cover,
      );
      facilityName = "마마도마";
      address = "ㅇㅇ로 ㅇㅇ번길";
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(FacilityPostScreen(context));
      },
      child: Card(
        child: ListTile(
          horizontalTitleGap: 10, // trailing과 (title, subtitle) 간격 조절
          title: Text(
            facilityName,
            style: TextStyle(fontSize: 23),
          ),
          trailing: SizedBox(width: 80, height: 80, child: facilityPhoto),
          subtitle: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Row(children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(
                        child: Text('Icon\n1', style: TextStyle(fontSize: 10))),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(
                        child: Text('Icon\n2', style: TextStyle(fontSize: 10))),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(
                        child: Text('Icon\n3', style: TextStyle(fontSize: 10))),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(
                        child: Text('Icon\n4', style: TextStyle(fontSize: 10))),
                  ),
                ]),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(address), Text(widget.time)],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
