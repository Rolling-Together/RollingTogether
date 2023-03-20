import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// 7. 시설 게시글

class FacilityPostScreen extends StatefulWidget {
  FacilityPostScreen(BuildContext context);

  _FacilityPostScreenState createState() => _FacilityPostScreenState();
}

class _FacilityPostScreenState extends State<FacilityPostScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  List filedata = [
    {
      'name': '글쓴이',
      'pic': 'https://picsum.photos/300/30',
      'message': '혼밥으로도 너무 괜찮은 곳입니다!'
    },
    {
      'name': '임은서',
      'pic': 'https://picsum.photos/300/30',
      'message': '저도 내일 가봐야겠습니다~~'
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
            Text("마마도마 경성대점",
                style: TextStyle(fontSize: 30, color: Colors.black)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("부산 남구 수영로 3334번길 정현빌 1층",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        Text("051-622-9712",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Text(
                          "정보 업데이트 하기",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "최종 업데이트 : 2023년 02월 10일 15시 34분",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Color(0xffcD9D9D9),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipOval(
                              child: Container(
                            width: 80,
                            height: 80,
                            color: Colors.white,
                          )),
                          Container(
                              width: 100,
                              height: 40,
                              child: Center(child: Text('사진'))),
                          Container(
                              width: 100,
                              height: 40,
                              child: Center(child: Text('사진'))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, right: 10, bottom: 10),
                            child: CircleAvatar(
                              child: Image.network(
                                'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text('작성자 : 임은서'),
                          Icon(Icons.star),
                        ]),
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
                          GestureDetector(
                            child: Text('공유'),
                            onTap: () {},
                          ),
                        ],
                      )),
                  commentChild(filedata),
                  Container(
                    child: ListTile(
                      tileColor: Color(0xffF2F2F2),
                      leading: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJ3-SXqfJljzjSYtNKZ6LN63CjmJYCTJT8g&usqp=CAU')),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          addComment();
                        },
                        child: Icon(Icons.send_sharp,
                            size: 30, color: Colors.black),
                      ),
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
