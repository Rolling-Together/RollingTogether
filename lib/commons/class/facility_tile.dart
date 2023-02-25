/* 여기 있는 것들 아이콘 넣어야함
FacilityInfo(text: '휠체어 접근 가능성', icon: Icons.accessible),
FacilityInfo(text: '장애인 엘리베이터', icon: Icons.elevator),
FacilityInfo(text: '엘리베이터 있음', icon: Icons.elevator),
FacilityInfo(text: '전동 휠체어 충전소', icon: Icons.ev_station)
 */


import 'package:flutter/material.dart';

class FacilityTile extends StatefulWidget {
  const FacilityTile({Key? key}) : super(key: key);

  _FacilityTileState createState() => _FacilityTileState();
}

class _FacilityTileState extends State<FacilityTile>{
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "존맛탱ㅠ",
          style: TextStyle(fontSize: 18),
        ),
        trailing:
        SizedBox(
          width: 50.0,
          height: 50.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: Image.network(
              'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
              fit: BoxFit.cover,
            ),
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('턱이 있음'),
            Text('oo로 oo번길'),
            Text('02/26 oo시 oo분')
          ],
        ),
      ),
    );
  }
}
