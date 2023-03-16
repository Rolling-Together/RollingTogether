import 'package:flutter/material.dart';

class restaurantCafe_BottomSheet extends StatelessWidget {
  const restaurantCafe_BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 3,
        child: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '식당 이름',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '위치',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        height: 20,//식당 이미지
                      )/*Image.network(
                            'https://th.bing.com/th/id/OIP.rRw8sYj4rXkmurs2kCtjBQHaE8?w=287&h=191&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                            fit: BoxFit.cover,
                          ),*/
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.looks_one),
                        Text('   1층에\n있음/없음'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.accessible),
                        Text('   경사로\n있음/없음'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.elevator),
                        Text('엘리베이터\n 있음/없음'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wc),
                        Text('장애인 화장실\n   있음/없음'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DangerousZone_BottomSheet extends StatelessWidget {
  const DangerousZone_BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            padding: const EdgeInsets.all(10.0),
            child: Image.network(
              'https://th.bing.com/th/id/OIP.kEyTyMJU1dubq8WTztPsCgHaFj?w=262&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      '깨진 도로',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      '주소',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 7.0),
                    child: Text(
                      '업데이트 날짜',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 7.0),
                    child: Text(
                      '작성자 이름',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                    ),
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

class Bus_BottomSheet extends StatelessWidget {
  const Bus_BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(
          itemCount: 10, // can be any number for vertical repeatability
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('노선 번호'),
                        Text('126')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('일련 번호'),
                        Text('126')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('리프트 유무'),
                        Text('있음')
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  SizedBox(
                    height: 40,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        // do something when the button is pressed
                      },
                      child: Text('수정'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Subway_BottomSheet extends StatelessWidget {
  const Subway_BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.wc),
          Icon(Icons.wheelchair_pickup),
          Icon(Icons.elevator),
        ],
      ),
    );
  }
}



class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('test'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('BottomSheet'),
                      ElevatedButton(
                        child: const Text('뒤로가기'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

