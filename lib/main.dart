import 'package:flutter/material.dart';
import 'package:rolling_together/ui/screens/facility_screen.dart';
import 'package:rolling_together/ui/screens/location_screen.dart';
import 'ui/screens/init_map_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FacilityScreen(),
    );
  }
}
