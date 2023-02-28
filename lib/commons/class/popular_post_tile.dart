import 'package:flutter/material.dart';

class PopularPostTile extends StatefulWidget {
  const PopularPostTile({Key? key}) : super(key: key);

  _PopularPostTileState createState() => _PopularPostTileState();
}

class _PopularPostTileState extends State<PopularPostTile> {
  late Image representativePicture;
  late String description;  // 신고내용
  late String type;  // 위험 분류 (ex.턱이있음)
  late String address;  // 주소
  late String time;  // 신고 시간

  @override
  void initState() {
    super.initState();
    setInformation();
  }

  void setInformation() {
    // comment, address, time, representativePicture 세팅하기
    setState(() {
      /// 서버에서 인기글 정보 가져오기
      representativePicture = Image.network(
        'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
        fit: BoxFit.cover,
      );
      description = "신고내용";
      type = '턱이 있음';
      address = "인기글 주소";
      time = "인기글 업로드시간";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      height: MediaQuery.of(context).size.width * 0.35,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Opacity(
                opacity: 0.5,
                child: representativePicture,
              ),
            ),
          ),Expanded(child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      description,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(type),
                  ),
                  Container(
                    child: Text(address),
                  ),
                  Container(
                    child: Text(time),
                  ),
                ],
              ),
          ),
          ),
        ],
      ),
    );
  }
}

/*
class PopularPostTileList extends StatefulWidget {
  const PopularPostTileList({Key? key}) : super(key: key);

  _PopularPostTileListState createState() => _PopularPostTileListState();
}


class _PopularPostTileListState extends State<PopularPostTileList> {

  List<PopularPostTile> popularPostTiles = [];

  @override
  Widget build(BuildContext context){
    return Container();
  }
}

 */
