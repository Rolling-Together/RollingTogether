import 'package:flutter/material.dart';

enum AppBarStatus {
  choosing, // 지역 선택 중 (화살표 윗 방향, 지역 모두 보이게)
  choosed // 지역 선택 후 (화살표 아래 방향, 선택한 지역이 title에 보이게)
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight*1.1),
        super(key: key);

  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late Icon _arrowDirection;
  late String _selectedArea;

  @override
  void initState() {
    super.initState();
    _arrowDirection = Icon(Icons.keyboard_arrow_down_outlined);
    _selectedArea = SampleArea[0];
  }

  void startChoosing() {
    setState(() {
      _arrowDirection = Icon(Icons.keyboard_arrow_up_outlined);
    });
  }

  void finishChoosing(String value) {
    setState(() {
      _arrowDirection = Icon(Icons.keyboard_arrow_down_outlined);
      _selectedArea = value;
    });
  }

  List SampleArea =["대연1동", "대연2동", "대연3동"];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffcD9D9D9),
      foregroundColor: Colors.black,
      leading: GestureDetector(
        onTap: () {
          startChoosing();
        },
        child: PopupMenuButton<String>(
          icon: _arrowDirection,
          onSelected: (value) {
            // Handle Area selection here
            finishChoosing(value);
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: SampleArea[0],
                child: Text(SampleArea[0]),
              ),
              PopupMenuItem<String>(
                value: SampleArea[1],
                child: Text(SampleArea[1]),
              ),
              PopupMenuItem<String>(
                value: SampleArea[2],
                child: Text(SampleArea[2]),
              ),
              // Add more Area here
            ];
          },
        ),
      ),
      title: Text(_selectedArea),
    );
  }
}
