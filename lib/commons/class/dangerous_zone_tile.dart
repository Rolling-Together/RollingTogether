/// 위험 장소 타일

import 'package:flutter/material.dart';
import 'package:rolling_together/ui/screens/14_dangerous_zone_post_screen.dart';

class DangerousZoneTile extends StatelessWidget {
  DangerousZoneTile({
    required this.time
    });

  final Widget representativePicture = ClipRRect( //대표사진(썸네일)
    borderRadius: BorderRadius.circular(0.0),
    child: Image.network(
      'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
      fit: BoxFit.cover,
    ),
  );
  final String comment = '대연놀이터 앞에 턱 때문에 다침ㅠ'; // 제목
  final String type = '턱이 있음'; // ex. 턱이있음 등
  final String address = 'oo로 oo길'; // 주소
  final String time ; // 업로드 시간

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(
            "대연놀이터 앞에 턱 때문에 다침ㅠ",
            style: TextStyle(fontSize: 18),
          ),
          trailing:
          SizedBox(width: 50.0, height: 50.0, child: representativePicture),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(type), Text(address), Text(time)],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DangerousZonePostScreen(context),
          ),
        );
      },
    ) ;
  }
}
