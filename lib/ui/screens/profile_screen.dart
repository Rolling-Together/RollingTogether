import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';

import '../../commons/widgets/bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        child: BottomNavbar(),
      ),
      body: Container(),
    );
  }
}
