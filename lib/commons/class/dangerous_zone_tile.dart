/// 위험 장소 타일

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:rolling_together/commons/class/firebase_storage.dart';

import 'package:rolling_together/ui/screens/14_dangerous_zone_post_screen.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../data/remote/dangerous_zone/models/dangerouszone.dart';

import '../../ui/screens/7_facility_post_screen.dart';

class DangerousZoneTile extends StatelessWidget {
  final DangerousZoneDto dto;
  final FirebaseStorage storageRef = FirebaseStorage.instance;

  static final dateFormat = DateFormat("yyyy-MM-dd HH:mm");

  DangerousZoneTile({required this.dto});

  final Widget representativePicture = ClipRRect(
    //대표사진(썸네일)
    borderRadius: BorderRadius.circular(0.0),
    child: const Icon(Icons.person),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        Get.to(DangerousZonePostScreen(), arguments: {'dangerousZoneDto': dto});
      },

      child: Card(
        child: ListTile(
          title: Text(
            dto.description,
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '위험',
                style: TextStyle(color: Colors.red),
              ),
              Text(dto.addressName),
              Text(
                DateFormat('MM/dd HH:mm').format(dto.dateTime.toDate()),
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          trailing: SizedBox(
            width: 50,
            height: 50,
            child: FutureBuilder<String>(
              future: dto.tipOffPhotos.isNotEmpty
                  ? getFirebaseStorageDownloadUrl(
                      'dangerouszones/${dto.tipOffPhotos[0]}')
                  : Future.value(null),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Icon(Icons.dangerous, size: 50);
                } else {
                  return Image.network(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
        ),
      ),

    );

  }
}
