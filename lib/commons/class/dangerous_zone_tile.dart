/// 위험 장소 타일

import 'package:flutter/material.dart';
import 'package:rolling_together/ui/screens/14_dangerous_zone_post_screen.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../data/remote/dangerous_zone/models/dangerouszone.dart';

class DangerousZoneTile extends StatelessWidget {
  final DangerousZoneDto dto;

  static final dateFormat = DateFormat("yyyy-MM-dd HH:mm");

  DangerousZoneTile({required this.dto});

  final Widget representativePicture = ClipRRect(
    //대표사진(썸네일)
    borderRadius: BorderRadius.circular(0.0),
    child: Image.network(
      'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
      fit: BoxFit.cover,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(
            dto.description,
            style: const TextStyle(fontSize: 18),
          ),
          trailing:
              SizedBox(width: 50.0, height: 50.0, child: representativePicture),
          subtitle:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('위험'),
            Text(dto.addressName),
            Text(dateFormat.format(dto.dateTime.toDate()))
          ]),
        ),
      ),
      onTap: () {
        Get.to(DangerousZonePostScreen());
      },
    );
  }
}
