import 'package:flutter/material.dart';
import 'ui/screens/init_map_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitMapScreen(),
    );
  }
}