import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commons/widgets/bottom_navbar.dart';
import '../../data/remote/auth/controller/firebase_auth_controller.dart';

class InitMapScreen extends StatelessWidget {
  const InitMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellowAccent,
        bottomNavigationBar: BottomNavbar());
  }
}
