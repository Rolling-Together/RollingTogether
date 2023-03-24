import 'package:flutter/material.dart';

import '../../commons/class/i_refresh_data.dart';

class GuideScreen extends StatelessWidget implements OnRefreshDataListener {
  const GuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가이드'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text('휠체어 바로알기',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Image.network(
                              'https://picsum.photos/200',
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('STEP 1'),
                                Text('휠체어 사용법')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text('대중교통 TIP',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0, left: 20, right: 20),
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 20),
                      child: Image.network(
                        'https://picsum.photos/200',
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('버스를 탈 때는?'),
                          SizedBox(height: 10,),
                          Text('올바른 리프트 사용법')
                        ],
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

  @override
  void refreshData() {
    // TODO: implement refreshData
  }
}
