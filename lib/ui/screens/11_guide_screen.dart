import 'package:flutter/material.dart';

import '../../commons/class/i_refresh_data.dart';

class GuideScreen extends StatelessWidget implements OnRefreshDataListener {
  const GuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
    );
  }

  @override
  void refreshData() {
    // TODO: implement refreshData
  }
}
