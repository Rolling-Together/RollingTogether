import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/remote/auth/controller/firebase_auth_controller.dart';
import 'firebase_options.dart';
import 'ui/screens/init_map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authController = Get.put(AuthController(), permanent: true);

  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: InitMapScreen(),
  ));
}
