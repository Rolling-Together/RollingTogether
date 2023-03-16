import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/user/controllers/my_data_controller.dart';

class ProfileScreen extends StatelessWidget {
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
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3kK3Z6UVOjkLVXUdz12gq9MyuAzT7pIxaQw&usqp=CAU',
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
                    children: [
                      Text(myDataController.myUserDto.value?.name ?? "이름",
                          style: const TextStyle(fontSize: 20)),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          //color: Colors.red,
                          child: Icon(Icons.star,
                              color: myDataController.myUserDto.value
                                      ?.userGradeDto?.iconColor ??
                                  Colors.grey),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Container(
                //color: Colors.indigo,
                alignment: Alignment.centerRight,
                child: Icon(
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
      //backgroundColor: Colors.yellowAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyLikeDangerousZonesWidget(),
            MySharedDangerousZonesWidget(),
          ],
        ),
      ),
    );
  }
}

class MyLikeDangerousZonesWidget extends StatelessWidget {
  final MyDataController myDataController = Get.find<MyDataController>();

  ///게시글 1개당 폼
  Widget postItem(BuildContext context, DangerousZoneDto dangerousZoneDto) {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.025,
          left: MediaQuery.of(context).size.width * 0.025,
          top: MediaQuery.of(context).size.height * 0.02),
      child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4h-NJbPkhTtNdwdDfYl1eSBbj6uc53-qdyw&usqp=CAU',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Row(children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  Text(dangerousZoneDto.likes.length.toString())
                ]),
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
        top: MediaQuery.of(context).size.height * 0.03,
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
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: myDataController.myLikesDangerousZoneList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return postItem(context,
                        myDataController.mySharedDangerousZoneList[index]);
                  }))),
          const Divider(
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
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.025,
          left: MediaQuery.of(context).size.width * 0.025,
          top: MediaQuery.of(context).size.height * 0.02),
      child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4h-NJbPkhTtNdwdDfYl1eSBbj6uc53-qdyw&usqp=CAU',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Row(children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  Text(dangerousZoneDto.likes.length.toString()) //공감개수
                ]),
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
        top: MediaQuery.of(context).size.height * 0.03,
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
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: myDataController.mySharedDangerousZoneList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return postItem(context,
                        myDataController.mySharedDangerousZoneList[index]);
                  }))),
          const Divider(
            color: Colors.black38,
          )
        ],
      ),
    );
  }
}
