import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Colors.lightGreen ,
      leading: PopupMenuButton<String>(
        icon: Icon(Icons.keyboard_arrow_down_outlined),
        onSelected: (String Area) {
          // Handle Area selection here
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: '대연1동',
              child: Text('대연1동'),
            ),
            PopupMenuItem<String>(
              value: '남천1동',
              child: Text('남천1동'),
            ),
            PopupMenuItem<String>(
              value: '남천1동',
              child: Text('남천1동'),
            ),
            // Add more Area here
          ];
        },
      ),
      title: Text("커뮤니티"),
    );
  }
}
