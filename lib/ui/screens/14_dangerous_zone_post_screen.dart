import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 14. 위험장소 게시글

class DangerousZonePostScreen extends StatefulWidget {
  _DangerousZonePostScreenState createState() =>
      _DangerousZonePostScreenState();
}

class _DangerousZonePostScreenState extends State<DangerousZonePostScreen> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  List filedata = [
    {
      'name': '이홍주',
      'pic': 'https://picsum.photos/300/30',
      'message': '여기 정말 위험해보이네요...'
    },
    {
      'name': '임은서',
      'pic': 'https://picsum.photos/300/30',
      'message': '사람들한테 알리고 지자체에 신고를 해서 해결됐으면 좋겠습니다.'
    },
  ];

  Widget commentChild(data) {
    return Column(
      //shrinkWrap: true,
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  void addComment() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        filedata.add({
          'name': 'UserName',
          'pic': 'https://picsum.photos/300/30',
          'message': commentController.text,
        });
      });
      commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        title: Column(
          children: [
            Text("위험장소", style: TextStyle(fontSize: 30, color: Colors.black)),

          ],
        ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child:Text("부산 부산진구 양정동 389-22", style: TextStyle(fontSize: 15,color: Colors.black)),
            ),
          )
      ),
      body: SingleChildScrollView(child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            Container(
              child: Text(
                "신고일시 : 2023년 02월 10일 15시 34분",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(top:10,right: 10, bottom: 10),
                  child: CircleAvatar(
                    child: Image.network(
                      'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text('임은서'),
                Icon(Icons.star),
              ])
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
                color:Color(0xffcD9D9D9),
                margin: EdgeInsets.symmetric(vertical: 10),
                    child:Text('여기 인도 턱이 너무 높아서 다칠 뻔 했어요')),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: MediaQuery.of(context).size.width*0.35,
                      height: MediaQuery.of(context).size.width*0.35,color:Color(0xffcD9D9D9),),
                    Container(width: MediaQuery.of(context).size.width*0.35,
                      height: MediaQuery.of(context).size.width*0.35,color:Color(0xffcD9D9D9),)
                  ],
                )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
                margin: EdgeInsets.symmetric(vertical: 20),
              color: Color(0xffcD9D9D9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("공감"),
                  Row(
                    children: [
                      Text('공유')
                    ],
                  )

                ],
              )
            ),
            commentChild(filedata),
            Container(
                child : ListTile(
                  tileColor: Color(0xffF2F2F2),
                  leading: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage : NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJ3-SXqfJljzjSYtNKZ6LN63CjmJYCTJT8g&usqp=CAU')
                    ),
                  ),
                  title: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        ///댓글 창 배경색
                          filled: true,
                          fillColor: Color(0xffE3E3E3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide.none,
                          )
                      ),
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: (){
                      addComment();
                      /* if(formKey.currentState!.validate()){
                        print(commentController.text);
                        setState(() {
                          var value = {
                            'name' : 'New User',
                            'pic' : 'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                            'message' : commentController.text
                          };
                          filedata.insert(0, value);
                        });
                        commentController.clear();
                        FocusScope.of(context).unfocus();
                      } else{
                        print("Not validated");
                      }*/
                    },
                    child:Icon(Icons.send_sharp, size: 30, color: Colors.black),),
                )
            ),



          ],
        ),
      ),),
    );
  }
}
