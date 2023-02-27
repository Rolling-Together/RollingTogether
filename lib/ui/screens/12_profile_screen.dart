import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';

import '../../commons/widgets/bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
            ///글자 길이에 맞게 width를 보장하는 법...?
            ///지금은 3글자에 맞춤
            child: Container(
              margin: EdgeInsets.only(
                //right: MediaQuery.of(context).size.width*0.05,
                left: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Text('이홍주', style: TextStyle(fontSize: 20)),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              //color: Colors.red,
              child: Icon(Icons.star, color: Colors.green),
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
            UserInfo(context),
            PostRow(Name: '공유한 게시글'),
            PostRow(
              Name: '찜한 장소',
            )
          ],
        ),
      ),
    );
  }
}

class PostRow extends StatelessWidget {
  final String Name;
  const PostRow({Key? key, required this.Name}) : super(key: key);

  ///게시글 1개당 폼
  Widget Post(context) {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.025,
          left: MediaQuery.of(context).size.width * 0.025,
          top: MediaQuery.of(context).size.height * 0.02),
      child: InkWell(

        ///게시글 하나 클릭했을 때 ... InkWell
          onTap: () {},
          child: Column(
            children: [
              Container(
                //사진담는 container
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4h-NJbPkhTtNdwdDfYl1eSBbj6uc53-qdyw&usqp=CAU',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Row(children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  Text(' 2') //공감개수
                ]),
              ),
              Container(child: Text('위치')),
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
        children: [
          Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.025),
              alignment: Alignment.centerLeft,
              child: Text(
                this.Name,
                style: TextStyle(fontSize: 15),
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Post(context),
                Post(context),
                Post(context),
                Post(context),
              ],
            ),
          ),
          Divider(
            color: Colors.black38,
          )
        ],
      ),
    );
  }
}