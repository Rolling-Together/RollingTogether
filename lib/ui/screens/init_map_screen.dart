import 'package:flutter/material.dart';

import '../../commons/widgets/bottom_navbar.dart';

class InitMapScreen extends StatelessWidget {
  const InitMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      bottomNavigationBar: BottomNavbar()
    );
  }
}
