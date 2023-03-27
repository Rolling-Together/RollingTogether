import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rolling_together/commons/enum/facility_checklist.dart';
import 'package:rolling_together/data/remote/auth/controller/firebase_auth_controller.dart';
import 'package:rolling_together/data/remote/facility/models/facility.dart';
import 'package:rolling_together/data/remote/facility/models/review.dart';
import 'package:rolling_together/ui/screens/facility/modification/facility_modification_screen.dart';
import 'package:rolling_together/commons/utils/capture_and_share_screenshot.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:screenshot/screenshot.dart';
import '../../commons/class/firebase_storage.dart';
import '../../data/remote/facility/controllers/facility_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rolling_together/commons/class/icon_and_photo_tile.dart';

import '13_facility_screen.dart';

/// 7. 시설 게시글

class FacilityPostScreen extends StatefulWidget {
  final FacilityDto facilityDto;
  final FacilityController facilityController = Get.find<FacilityController>();
  static final DateFormat dateFormat = DateFormat('MM-dd HH:mm');

  FacilityPostScreen({required this.facilityDto});

  _FacilityPostScreenState createState() => _FacilityPostScreenState();
}

class _FacilityPostScreenState extends State<FacilityPostScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();

  Widget commentChild() {
    return Column(
      children: makeComments(),
    );
  }

  void addComment() {
    if (commentController.text.isNotEmpty) {
      widget.facilityController.addReview(
          FacilityReviewDto(
              userId: AuthController.to.myUserDto.value!.id!,
              userName: AuthController.to.myUserDto.value!.name,
              content: commentController.text),
          widget.facilityDto.placeId);
      commentController.clear();
    }
  }

  makeComments() {
    var widgets = <Widget>[];
    int i = 0;

    for (final review in widget.facilityController.reviewList) {
      widgets.addAll([
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          leading: GestureDetector(
            onTap: () async {
              widget.facilityController.addReview(
                  FacilityReviewDto(
                      userId: AuthController.to.myUserDto.value!.id!,
                      userName: AuthController.to.myUserDto.value!.name,
                      content: commentController.text),
                  widget.facilityDto.placeId);
            },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const CircleAvatar(
                  radius: 50, child: Icon(Icons.person, size: 50)),
            ),
          ),
          title: Text(
            review.userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(review.content),
        ),
        if (i++ != widget.facilityController.reviewList.length - 1)
          const Divider()
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.facilityController.getAllReviews(widget.facilityDto.placeId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            Text(widget.facilityDto.name,
                style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Screenshot(
          controller: screenshotController,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.facilityDto.addressName,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black)),
                      Text(widget.facilityDto.placeUrl,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black)),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: const Text(
                          "정보 업데이트 하기",
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          Get.to(FacilityModificationScreen(),
                              arguments: {'facilityDto': widget.facilityDto});
                        },
                      ),
                      Text(
                        "업데이트 : ${FacilityPostScreen.dateFormat.format(widget.facilityDto.dateTime.toDate())}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: const Color(0xffcD9D9D9),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final type in FacilityCheckListType.toList())
                      addFacilityCheckData(type)
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const Icon(Icons.person),
                  Text('작성자 : ${widget.facilityDto.informerName}'),
                  const Icon(Icons.star),
                ]),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: const Color(0xffcD9D9D9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("공감"),
                      InkWell(
                          child: const Text('공유'),
                          onTap: () async {
                            await takeScreenshotAndShare(screenshotController);
                          })
                    ],
                  )),
              Obx(() => commentChild()),
              ListTile(
                tileColor: const Color(0xffF2F2F2),
                leading: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child:
                      const CircleAvatar(radius: 50, child: Icon(Icons.person)),
                ),
                title: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: commentController,
                    decoration: const InputDecoration(

                        ///댓글 창 배경색
                        filled: true,
                        fillColor: Color(0xffE3E3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    addComment();
                  },
                  child: const Icon(Icons.send_sharp,
                      size: 30, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addFacilityCheckData(FacilityCheckListType type) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Image.network(
                    snapshot.data.toString(),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  );
                } else {
                  return Icon(type.icon, size: 50);
                }
              },
              future: widget.facilityDto.checkList[type]!.imgUrls.isNotEmpty
                  ? getFirebaseStorageDownloadUrl(
                      'facilitychecklist/${widget.facilityDto.checkList[type]!.imgUrls[0]}')
                  : Future.error(''),
            ),
          ),
          Column(
            children: [
              Text(type.description),
              Text(widget.facilityDto.checkList[type]!.status.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
