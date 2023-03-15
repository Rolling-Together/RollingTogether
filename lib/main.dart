import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/ui/screens/7_facility_post_screen.dart';
import 'firebase_options.dart';
import 'ui/screens/init_map_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: FacilityScreen(),
  ));
}