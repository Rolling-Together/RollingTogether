/* 여기 있는 것들 아이콘 넣어야함
FacilityInfo(text: '휠체어 접근 가능성', icon: Icons.accessible),
FacilityInfo(text: '장애인 엘리베이터', icon: Icons.elevator),
FacilityInfo(text: '엘리베이터 있음', icon: Icons.elevator),
FacilityInfo(text: '전동 휠체어 충전소', icon: Icons.ev_station)
 */

import 'package:flutter/material.dart';

import 'package:rolling_together/commons/enum/facility_checklist.dart';
import 'package:rolling_together/data/remote/facility/models/facility.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rolling_together/ui/screens/7_facility_post_screen.dart';


class FacilityTile extends StatefulWidget {
  final FacilityDto facilityDto;

  FacilityTile({required this.facilityDto});

  _FacilityTileState createState() => _FacilityTileState();
}

class _FacilityTileState extends State<FacilityTile> {
  static final DateFormat dateFormat = DateFormat('MM/dd HH:mm');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Get.to(FacilityPostScreen(
          facilityDto: widget.facilityDto,
        ));

      },
      child: Card(
        child: ListTile(
          horizontalTitleGap: 10, // trailing과 (title, subtitle) 간격 조절
          title: Text(
            widget.facilityDto.name,
            style: const TextStyle(fontSize: 23),
          ),

          trailing: const Icon(Icons.remove, size: 50),
          subtitle: SizedBox(

            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Row(children: [
                  Container(
                    height: 40,
                    width: 40,

                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(
                        child: Text(
                            '화장실'
                            '\n${widget.facilityDto.checkList[FacilityCheckListType.toilet]!.status.toString()}',
                            style: const TextStyle(fontSize: 10))),

                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(

                        child: Text(
                            '1층'
                            '\n${widget.facilityDto.checkList[FacilityCheckListType.floorFirst]!.status.toString()}',
                            style: const TextStyle(fontSize: 10))),

                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(

                        child: Text(
                            '휠체어'
                            '\n${widget.facilityDto.checkList[FacilityCheckListType.wheelChair]!.status.toString()}',
                            style: TextStyle(fontSize: 10))),

                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey,
                    child: Center(

                        child: Text(
                            '승강기'
                            '\n${widget.facilityDto.checkList[FacilityCheckListType.elevator]!.status.toString()}',
                            style: TextStyle(fontSize: 10))),

                  ),
                ]),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [Text(widget.facilityDto.addressName)],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
 widget.facilityDto.checkList.isNotEmpty
        ? SizedBox(
        width: 50.0,
            height: 50.0,
            child: Image.network(
                '${firebaseStorageBucket}facilitychecklist/${widget.facilityDto.[0]}',fit: BoxFit.cover))
              : const Icon(Icons.remove, size: 50),
 */
