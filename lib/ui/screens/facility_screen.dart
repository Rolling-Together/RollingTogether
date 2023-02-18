import 'package:flutter/material.dart';

class FacilityScreen extends StatelessWidget {
  const FacilityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                ///대분류
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.1,
                    left: MediaQuery.of(context).size.width * 0.05),
                alignment: Alignment.centerLeft,
                child: Text('편의시설', style: TextStyle(fontSize: 16)),
              ),
              Container(

                  ///카테고리
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.03),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(),
                  child: CategoryButton()),
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                alignment: Alignment.centerLeft,
                child: Text("주소 검색"),
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.2),
                child: Text('지도 API'),
              ),
              Container(
                ///주소
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                alignment: Alignment.centerLeft,
                child: Text('주소'),
              ),
              Container(
                ///주소 불러오는 값 임의로 지정해놨음
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text('부산광역시 남구 용소로 45, 부경대학교 대연캠퍼스'),
              ),
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child : FacilityInfo(),),
              Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TextField(
                  decoration: InputDecoration(focusedBorder: InputBorder.none),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    '신고',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

///category_option 버튼
const List<String> list = <String>['음식점', '카페', '공공시설', '문화시설'];

class CategoryButton extends StatefulWidget {
  const CategoryButton({Key? key}) : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      ///나중에 category 디자인 필요할 때 쓰려고 Container에 담아두고 decoration 부여
      /*decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),*/
      child: DropdownButton<String>(
        ///underline 안보이게 할 때
        //underline: SizedBox.shrink(),
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
      ),
    );
  }
}

///장소정보 >> 여기서 오류난당~~
const List<String> option_list = <String>['선택', '예', '아니오'];

class FacilityInfo extends StatefulWidget {
  const FacilityInfo({Key? key}) : super(key: key);

  @override
  State<FacilityInfo> createState() => _FacilityInfoState();
}

class _FacilityInfoState extends State<FacilityInfo> {
  String dropdownValues = option_list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right : MediaQuery.of(context).size.width*0.05),
          child : Icon(Icons.wheelchair_pickup),),
          Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.3),
    child : Text('휠체어 접근 가능'),),
          DropdownButton<String>(
            isDense: true,
            //isExpanded: true,
            value: dropdownValues,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            onChanged: (String? value) {
              setState(() {
                dropdownValues = value!;
              });
            },
            items: option_list.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
