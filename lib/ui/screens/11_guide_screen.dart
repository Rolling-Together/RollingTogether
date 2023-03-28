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
            padding: const EdgeInsets.only(top: 10.0),
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
                          child: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            child: Image.network(
                              'https://www.sesang-file.com/resources/images/project10/m_project10_sol01_1.png',
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, right: 40,left: 10, bottom: 20 ),
                          child: Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('STEP ${index + 1}', style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16
                                  ),),
                                  SizedBox(height: 7,),
                                  Text('${index == 0 ? "휠체어 사용법" : index == 1 ? "휠체어 접는법" : "이용 시 주의사항"}', style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18
                                  ),)
                                ],
                              ),
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
                      padding: const EdgeInsets.only(top: 10.0, left: 25, bottom: 10),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAuzQh7k-LQEabGZbYOznBbEP221dVD7EVPQ&usqp=CAU',
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
                          Text('지하철 계단은 ?', style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                          ),),
                          SizedBox(height: 10,),
                          Text('올바른 리프트 사용법', style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),)
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