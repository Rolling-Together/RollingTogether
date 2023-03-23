import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/auth/controller/firebase_auth_controller.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerous_zone_comment.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:intl/intl.dart';

import '../../commons/class/firebase_storage.dart';
import '../../data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';
import '../../data/remote/user/controllers/my_data_controller.dart';

/// 14. 위험장소 게시글
class DangerousZonePostScreen extends StatefulWidget {
  final DangerousZoneController dangerousZoneController =
      Get.find<DangerousZoneController>();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final MyDataController myDataController = Get.find<MyDataController>();

  _DangerousZonePostScreenState createState() =>
      _DangerousZonePostScreenState();
}

class _DangerousZonePostScreenState extends State<DangerousZonePostScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  Widget commentChild() {
    return Column(
      //shrinkWrap: true,
      children: [
        for (var i = 0;
            i < widget.dangerousZoneController.commentList.length;
            i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {},
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
              ),
              title: Text(
                widget.dangerousZoneController.commentList[i].commenterName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text(widget.dangerousZoneController.commentList[i].content),
            ),
          )
      ],
    );
  }

  void addComment() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        widget.dangerousZoneController.addComment(
            DangerousZoneCommentDto(
                content: commentController.text,
                commenterId: AuthController.to.myUserDto.value!.id!,
                commenterName: AuthController.to.myUserDto.value!.name),
            widget.dangerousZoneController.dangerousZone.value!.id!);
      });

      commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;

    if (arguments['dangerousZoneDto'] != null) {
      final dangerousZoneDto =
          arguments['dangerousZoneDto'] as DangerousZoneDto;
      widget.dangerousZoneController.dangerousZone.value = dangerousZoneDto;
      widget.dangerousZoneController.getAllComments(dangerousZoneDto.id!);
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Get.back()),
          title: Column(
            children: const [
              Text("위험장소", style: TextStyle(fontSize: 30, color: Colors.black)),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                  widget
                      .dangerousZoneController.dangerousZone.value!.addressName,
                  style: TextStyle(fontSize: 15, color: Colors.black)),
            ),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "신고일시 : ${widget.dateFormat.format(widget.dangerousZoneController.dangerousZone.value!.dateTime.toDate())}",
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                      child: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),
                    Text(widget.dangerousZoneController.dangerousZone.value!
                        .informerName),
                    const Icon(Icons.star),
                  ])),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  color: const Color(0xffcD9D9D9),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(widget.dangerousZoneController.dangerousZone
                      .value!.description)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Image.network(
                          snapshot.data.toString(),
                          fit: BoxFit.cover,
                        );
                      } else {
                        return const Icon(Icons.remove, size: 50);
                      }
                    },
                    future: widget.dangerousZoneController.dangerousZone.value!
                            .tipOffPhotos.isNotEmpty
                        ? getFirebaseStorageDownloadUrl(
                            'dangerouszones/${widget.dangerousZoneController.dangerousZone.value!.tipOffPhotos[0]}')
                        : Future.error(''),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: const Color(0xffcd9d9d9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01),
                        child: InkWell(
                          onTap: () {
                            widget.dangerousZoneController.dangerousZone.value!
                                    .likes
                                    .contains(widget.myDataController.myUid)
                                ? widget.dangerousZoneController
                                    .unlikeDangerousZone(
                                    widget.dangerousZoneController.dangerousZone
                                        .value!.id!,
                                    widget.myDataController.myUid,
                                  )
                                : widget.dangerousZoneController
                                    .likeDangerousZone(
                                    widget.dangerousZoneController.dangerousZone
                                        .value!.id!,
                                    widget.myDataController.myUid,
                                  );
                          },
                          child: Row(children: [
                            Obx(() {
                              return widget.dangerousZoneController
                                      .dangerousZone.value!.likes
                                      .contains(widget.myDataController.myUid)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.yellow,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.yellow,
                                    );
                            }),
                            Obx(() => Text(widget.dangerousZoneController
                                .dangerousZone.value!.likes.length
                                .toString()))
                          ]),
                        ),
                      ),
                      const Text('공유')
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
                  child: const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person),
                  ),
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
                    // 댓글 추가
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
}
