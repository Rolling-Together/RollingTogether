import 'package:flutter/material.dart';

class TransScreen extends StatefulWidget {
  const TransScreen({Key? key}) : super(key: key);

  @override
  State<TransScreen> createState() => _TransScreenState();
}

class _TransScreenState extends State<TransScreen> {
  Widget UpdatedDialog(){
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text('등록되었습니다'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(

                ///카테고리
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(),
                child: CategoryButton()),
            ///버스 목록
            BusContainer(
              busName: '1234',
            ),
            BusContainer(
              busName: '5678',
            ),
            BusContainer(
              busName: '1010',
            ),
            BusContainer(
              busName: '1111',
            ),
            BusContainer(
              busName: '1212',
            ),
            ///업데이트 버튼
            Container(
              margin: EdgeInsets.only(
                top : MediaQuery.of(context).size.height * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: OutlinedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => UpdatedDialog(),
                ),
                child: Text(
                  '업데이트',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///category_option 버튼
const List<String> list = <String>['부산 155번', '부산 126번', '부산 111번'];

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

///버스 1개 컨테이너 (번호, 리프트 여부, 리프트작동, 업데이트)
class BusContainer extends StatefulWidget {
  final String busName;
  const BusContainer({Key? key, required this.busName}) : super(key: key);

  @override
  State<BusContainer> createState() => _BusContainerState();
}

///일단 리프트 여부 enum, 작동 여부 enum따로 선언
enum Lift { TRUE, FALSE }

enum Work { TRUE, FALSE }

class _BusContainerState extends State<BusContainer> {
  ///처음 선택 지정
  Lift _lift = Lift.FALSE;
  Work _work = Work.FALSE;

  ///라디오 버튼 선택 초기화
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
      top: MediaQuery.of(context).size.height*0.01),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Text(
                this.widget.busName,
                style: TextStyle(fontSize: 25, color: Colors.indigo),
              ),
            ),
            Expanded(child: Text('2023-02-24', textAlign: TextAlign.right))
          ]),
          Row(
            children: [
              Text('리프트 여부'),
              Radio(
                //title: Text('있음'),
                value: Lift.TRUE,
                groupValue: _lift,
                onChanged: (Lift? value) {
                  setState(() {
                    _lift = value!;
                  });
                },
                //dense,contentPadding으로 radio줄임
                //dense: true,
                //contentPadding: EdgeInsets.zero,
              ),
              Text('있음'),
              Radio(
                //title: Text('없음'),
                value: Lift.FALSE,
                groupValue: _lift,
                onChanged: (Lift? value) {
                  setState(() {
                    _lift = value!;
                  });
                },
                //dense: true,
                //contentPadding: EdgeInsets.zero,
              ),
              Text('없음')
            ],
          ),
          Row(
            children: [
              Text('리프트 작동 여부'),
              Radio(
                //title: Text('있음'),
                value: Work.TRUE,
                groupValue: _work,
                onChanged: (Work? value) {
                  setState(() {
                    _work = value!;
                  });
                },
                //dense,contentPadding으로 radio줄임
                //dense: true,
                //contentPadding: EdgeInsets.zero,
              ),
              Text('작동함'),
              Radio(
                //title: Text('없음'),
                value: Work.FALSE,
                groupValue: _work,
                onChanged: (Work? value) {
                  setState(() {
                    _work = value!;
                  });
                },
                //dense: true,
                //contentPadding: EdgeInsets.zero,
              ),
              Text('작동안함')
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
