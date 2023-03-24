import 'package:flutter/material.dart';
import '../../ui/screens/13_facility_screen.dart';

/* 여기 있는 것들 아이콘 넣어야함
휠체어 접근 가능성 Icons.accessible
1층 Icons.looks_one
화장실 Icons.wc
엘리베이터 Icons.elevator
 */

class IconAndPhotoTile extends StatefulWidget {
  IconAndPhotoTile({
    required this.facilityIcon
  });

  late IconData facilityIcon;

  _IconAndPhotoTileState createState() => _IconAndPhotoTileState();
}

class _IconAndPhotoTileState extends State<IconAndPhotoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              ClipOval(
                child: Container(
                  child: Icon(widget.facilityIcon),
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
          Container(width: 50, height: 50, child: Center(child: Text('사진'))),
          Container(width: 50, height: 50, child: Center(child: Text('사진'))),
        ],
      ),
    );
  }
}
