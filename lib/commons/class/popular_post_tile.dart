import 'package:flutter/material.dart';

class PopularPostTile extends StatefulWidget {
  const PopularPostTile({Key? key}) : super(key: key);

  _PopularPostTileState createState() => _PopularPostTileState();
}

class _PopularPostTileState extends State<PopularPostTile> {
  late Image representativePicture;
  late String comment;
  late String address;
  late String time;

  @override
  void initState() {
    super.initState();
    setInformation();
  }

  void setInformation() {
    // comment, address, time, representativePicture 세팅하기
    setState(() {
      // 서버에서 인기글 정보 가져오기
      representativePicture = Image.network(
        'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
        fit: BoxFit.cover,
      );
      comment = "인기글 1위 코멘트";
      address = "1위 주소";
      time = "1위 업로드 시간";
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
                      comment,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
