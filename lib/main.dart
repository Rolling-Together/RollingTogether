import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/ui/screens/0_login_screen.dart';

import 'data/remote/auth/controller/firebase_auth_controller.dart';
import 'data/remote/map/controller/my_map_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authController = Get.put(AuthController(), permanent: true);
  final MyMapController myMapController =
      Get.put(MyMapController(), permanent: true);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
