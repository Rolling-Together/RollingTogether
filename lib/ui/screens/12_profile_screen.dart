import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/user/controllers/my_data_controller.dart';

import '../../commons/class/firebase_storage.dart';
import '../../commons/class/i_refresh_data.dart';
import '../../config.dart';
import '../../data/remote/auth/controller/firebase_auth_controller.dart';
import '../../data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';
import '14_dangerous_zone_post_screen.dart';

class ProfileScreen extends StatelessWidget implements OnRefreshDataListener {
  final MyDataController myDataController =
      Get.put(MyDataController(), permanent: true);

  Widget UserInfo(context) {
    return Container(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.07),
      child: Row(
        children: [
          Expanded(
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.1,
              backgroundImage: NetworkImage(
                'https://i.pinimg.com/236x/ac/0f/41/ac0f419e977af681516e00829c5393ee.jpg',
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                //right: MediaQuery.of(context).size.width*0.05,
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AuthController.to.myUserDto.value!.name ?? "이름",
                          style: const TextStyle(fontSize: 20)),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          margin : EdgeInsets.only(
                              left : MediaQuery.of(context).size.width * 0.05,),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.star,
                                    color: AuthController.to.myUserDto.value
                                            ?.userGradeDto?.iconColor ??
                                        Colors.grey),
                                Text(
                                    '${AuthController.to.myUserDto.value?.userGradeDto?.reportCount}회' ??
                                        '0회')
                              ],
                            )),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Container(
                //color: Colors.indigo,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.settings_outlined,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xfffE9EAEC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserInfo(context),
            Container(
              margin : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.05,),
              child : Divider(
              height: MediaQuery.of(context).size.height*0.1,
              color: Colors.black38,
            ),),
            MyLikeDangerousZonesWidget(),
            MySharedDangerousZonesWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void refreshData() {
    myDataController.loadMySharedDangerousZone();
    myDataController.loadMyLikeDangerousZone();
  }
}

class MyLikeDangerousZonesWidget extends StatelessWidget {
  final MyDataController myDataController = Get.find<MyDataController>();

  ///게시글 1개당 폼
  Widget postItem(BuildContext context, DangerousZoneDto dangerousZoneDto) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color : Colors.grey.withOpacity(0.7),
        blurRadius: 5.0, spreadRadius: 0.0, offset: const Offset(3,3))],
        borderRadius: BorderRadius.circular(8.0),
        color: Color(0xfffF5F5F5),
      ),
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.025,
          left: MediaQuery.of(context).size.width * 0.025,
          top: MediaQuery.of(context).size.height * 0.02),
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
          left: MediaQuery.of(context).size.width * 0.02),
      child: InkWell(
          onTap: () {
            Get.to(DangerousZonePostScreen(),
                arguments: {'dangerousZoneDto': dangerousZoneDto});
          },
          child: Column(
            children: [
              SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            snapshot.data.toString(),
                            fit: BoxFit.fill,
                          ),
                        );
                      } else {
                        return const Icon(Icons.remove, size: 50);
                      }
                    },
                    future: dangerousZoneDto.tipOffPhotos.isNotEmpty
                        ? getFirebaseStorageDownloadUrl(
                            'dangerouszones/${dangerousZoneDto.tipOffPhotos[0]}')
                        : Future.error(''),
                  )),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: GestureDetector(
                  onTap: () {
                    myDataController.unlikeDangerousZone(
                      dangerousZoneDto.id!,
                      myDataController.myUid,
                    );
                  },
                  child: Row(children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.yellow,
                    ),
                    Text(dangerousZoneDto.likes.length.toString())
                  ]),
                ),
              ),
              Text(dangerousZoneDto.addressName),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        //top: MediaQuery.of(context).size.height * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.025),
              alignment: Alignment.centerLeft,
              child: const Text(
                '내가 공감한 위험장소',
                style: TextStyle(fontSize: 15),
              )),
          Obx(() => SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: myDataController.myLikesDangerousZoneList.isEmpty
                  ? const Center(child: Text('공감한 위험장소가 없습니다.'))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          myDataController.myLikesDangerousZoneList.length,
                      itemBuilder: (context, index) {
                        return postItem(context,
                            myDataController.myLikesDangerousZoneList[index]);
                      }))),
          Divider(
            height: MediaQuery.of(context).size.height*0.1,
            color: Colors.black38,
          )
        ],
      ),
    );
  }
}

class MySharedDangerousZonesWidget extends StatelessWidget {
  final MyDataController myDataController = Get.find<MyDataController>();

  ///게시글 1개당 폼
  Widget postItem(BuildContext context, DangerousZoneDto dangerousZoneDto) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color : Colors.grey.withOpacity(0.7),
            blurRadius: 5.0, spreadRadius: 0.0, offset: const Offset(3,3))],
        borderRadius: BorderRadius.circular(8.0),
        color: Color(0xfffF5F5F5),
      ),
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.025,
          left: MediaQuery.of(context).size.width * 0.025,
          top: MediaQuery.of(context).size.height * 0.02),
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
          left: MediaQuery.of(context).size.width * 0.02),
      child: InkWell(
          onTap: () {
            Get.to(DangerousZonePostScreen(),
                arguments: {'dangerousZoneDto': dangerousZoneDto});
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                            child : Image.network(
                          snapshot.data.toString(),
                          fit: BoxFit.fill,
                        ),
                        );
                      } else {
                        return const Icon(Icons.remove, size: 50);
                      }
                    },
                    future: dangerousZoneDto.tipOffPhotos.isNotEmpty
                        ? getFirebaseStorageDownloadUrl(
                            'dangerouszones/${dangerousZoneDto.tipOffPhotos[0]}')
                        : Future.error(''),
                  )),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: GestureDetector(
                  onTap: () {
                    dangerousZoneDto.likes.contains(myDataController.myUid)
                        ? myDataController.unlikeDangerousZone(
                            dangerousZoneDto.id!,
                            myDataController.myUid,
                          )
                        : myDataController.likeDangerousZone(
                            dangerousZoneDto.id!,
                            myDataController.myUid,
                          );
                  },
                  child: Row(children: [
                    dangerousZoneDto.likes.contains(myDataController.myUid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.yellow,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.yellow,
                          ),
                    Text(dangerousZoneDto.likes.length.toString())
                  ]),
                ),
              ),
              Text(dangerousZoneDto.addressName),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
        right: MediaQuery.of(context).size.width * 0.05,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.025),
              alignment: Alignment.centerLeft,
              child: const Text(
                '내가 제보한 위험장소',
                style: TextStyle(fontSize: 15),
              )),
          Obx(() => SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: myDataController.mySharedDangerousZoneList.isEmpty
                  ? const Center(child: Text('제보한 위험장소가 없습니다.'))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          myDataController.mySharedDangerousZoneList.length,
                      itemBuilder: (context, index) {
                        return postItem(context,
                            myDataController.mySharedDangerousZoneList[index]);
                      }))),
          Divider(
            height: MediaQuery.of(context).size.height*0.1,
            color: Colors.black38,
          )
        ],
      ),
    );
  }
}
