import 'package:flutter/material.dart';

import '../../commons/widgets/bottom_navbar.dart';

class InitMapScreen extends StatelessWidget {
  const InitMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Text('test'),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: BottomNavbar(),
        ),
    );
  }
}


