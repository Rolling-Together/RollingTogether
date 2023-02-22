import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';

class InitMapScreen extends StatelessWidget {
  const InitMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DangerousZoneController());

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You have pushed the button this many times:',
          ),
          Obx(
            () => Text(
              "${controller.dangerousZoneList.isEmpty}",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ElevatedButton(
              child: const Text('test'),
              onPressed: () {
                controller.getDangerousZoneList('123.115615', '124.122563');
              })
        ],
      ),
    );
  }
}


