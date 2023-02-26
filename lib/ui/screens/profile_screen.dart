import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/dangerous_zone/controllers/dangerous_zone_controller.dart';

import '../../commons/widgets/bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Widget UserInfo(context){
    return Container(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,
          left: MediaQuery.of(context).size.width*0.1,
      top: MediaQuery.of(context).size.height*0.07),
      child: Row(
        children: [
          Expanded(child:
          CircleAvatar(
            radius: MediaQuery.of(context).size.width*0.1,
            backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3kK3Z6UVOjkLVXUdz12gq9MyuAzT7pIxaQw&usqp=CAU',),
          ),),
          Expanded(
            ///글자 길이에 맞게 width를 보장하는 법...?
            ///지금은 3글자에 맞춤
            child : Container(
            margin: EdgeInsets.only(//right: MediaQuery.of(context).size.width*0.05,
              left: MediaQuery.of(context).size.width*0.05,),
            child: Text('이홍주', style: TextStyle(fontSize: 20)),),
          ),
          Expanded(child: Container(
            alignment: Alignment.centerLeft,
            //color: Colors.red,
            child: Icon(Icons.star, color: Colors.green),
          ),),
          Expanded(child: Container(
            //color: Colors.indigo,
            alignment: Alignment.centerRight,
            child : Icon(Icons.settings_outlined, )
          ),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellowAccent,

      body: Column(
        children: [
          UserInfo(context),
        ],
      ),
    );
  }
}