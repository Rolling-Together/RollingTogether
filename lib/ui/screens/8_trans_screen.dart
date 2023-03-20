import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolling_together/data/remote/bus/controllers/bus_controller.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/bus/models/bus.dart';
import 'package:rolling_together/data/remote/bus/models/jsonresponse'
    '/get_car_list_tago.dart' as car_list_of_route;

import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_bus_list_at_bus_stop_response.dart'
    as bus_list_at_bus_stop_response;

import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_bus_stop_list_around_latlng_response.dart'
    as bus_stop_list_response;
import '../../data/remote/auth/controller/firebase_auth_controller.dart';

class TransScreen extends StatefulWidget {
  @override
  State<TransScreen> createState() => _TransScreenState();
}

class _TransScreenState extends State<TransScreen> {
  final BusController busController = Get.put(BusController());

  Widget UpdatedDialog() {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text('변경 되었습니다'),
      ),
      actions: [
        TextButton(
          child: Text('확인'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    busController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthController.to.firebaseUser.value;

    if (user != null && busController.latlng.isEmpty) {
      final arguments = Get.arguments;
      final LatLng latlng = arguments['latlng'];

      busController.latlng = [latlng.latitude, latlng.longitude];
      busController.myUIdInFirebase = user.uid;
      busController.myUserName = '박준성';

      busController.getBusStopList(latlng.latitude, latlng.longitude);
    }

    return Scaffold(body: Obx(() {
      if (busController.updateResult.isTrue) {
        return UpdatedDialog();
      } else {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(

                  ///버스 정류장 목록
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(),
                  child: CategoryButton()),
              Container(

                  ///버스 노선 목록
                  /*padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),*/
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(),
                  child: BusRouteListButton()),
              Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Obx(() {
                    final list = busController.busCarListMap.values.toList();
                    return ListView.builder(

                        ///busName의 길이만큼 itemCount
                        itemCount: busController.busCarListMap.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BusContainer(
                            item: list[index],
                          );
                        });
                  })),

              ///업데이트 버튼
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.03),
                child: OutlinedButton(
                  onPressed: () {
                    busController.updateCarStatus(
                        busController.editedCarMaps.values.toList());
                  },
                  child: Text(
                    '업데이트',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }));
  }
}

class CategoryButton extends StatefulWidget {
  const CategoryButton({Key? key}) : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  final BusController busController = Get.find<BusController>();
  bus_stop_list_response.Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(

        ///나중에 category디자인 필요할 때 쓰려고 Container에 담아두고 decoration부여
/*decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),*/
        child: Obx(() {
      if (busController.busStopList.isNotEmpty) {
        busController.cityCode = busController.busStopList.first.citycode;
        return DropdownButton<bus_stop_list_response.Item>(
          ///underline안보이게 할 때
//underline: SizedBox.shrink(),
          items: busController.busStopList
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item.nodenm),
                  ))
              .toList(),
          isExpanded: true,
          value: selectedItem,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          onChanged: (value) {
            setState(() {
              selectedItem = value;
              busController.getBusListAtBusStop(
                  busController.cityCode, value!.nodeid);
            });
          },
        );
      } else {
        return Text('정류장 목록');
      }
    }));
  }
}

///  버스 노선 목록 DropdownMenu
class BusRouteListButton extends StatefulWidget {
  @override
  State<BusRouteListButton> createState() => BusRouteListState();
}

class BusRouteListState extends State<BusRouteListButton> {
  // 선택한 노선id
  final BusController busController = Get.find<BusController>();
  bus_list_at_bus_stop_response.Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(

        ///나중에 category디자인 필요할 때 쓰려고 Container에 담아두고 decoration부여
/*decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),*/
        child: Obx(() {
      if (busController.busStopInfo.isNotEmpty) {
        return DropdownButton<bus_list_at_bus_stop_response.Item>(
          ///underline안보이게 할 때
//underline: SizedBox.shrink(),
          isExpanded: true,
          value: selectedItem,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          onChanged: (value) {
            setState(() {
              selectedItem = value;
              busController.getCarListFromTago(
                  busController.cityCode, value!.routeId);
            });
          },
          items: busController.busStopInfo
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item.routeNo),
                  ))
              .toList(),
        );
      } else {
        return const Text('노선 목록 불러오는 중...');
      }
    }));
  }
}

///버스 1개 컨테이너 (번호,리프트 여부,리프트작동,업데이트)
class BusContainer extends StatefulWidget {
  final BusDto item;

  const BusContainer({Key? key, required this.item}) : super(key: key);

  @override
  State<BusContainer> createState() => _BusContainerState();
}

///일단 리프트 여부 enum,작동 여부 enum따로 선언
enum Lift { TRUE, FALSE }

enum Work { TRUE, FALSE }

class _BusContainerState extends State<BusContainer> {
  ///처음 선택 지정
  Lift _lift = Lift.FALSE;
  Work _work = Work.FALSE;

  final BusController busController = Get.find<BusController>();

  onEditedData() {
    busController.editedCarMaps[widget.item.vehicleNo] = widget.item;
  }

  ///라디오 버튼 선택 초기화
  @override
  Widget build(BuildContext context) {
    _lift = widget.item.lift ? Lift.TRUE : Lift.FALSE;
    _work = widget.item.liftStatus ? Work.TRUE : Work.FALSE;

    return Container(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.01),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Text(
                widget.item.vehicleNo,
                style: TextStyle(fontSize: 25, color: Colors.indigo),
              ),
            ),
            Expanded(
                child: Text(
                    widget.item.updated != null
                        ? widget.item.updated!.toDate().toIso8601String()
                        : '데이터 없음',
                    textAlign: TextAlign.right))
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
                    widget.item.lift = value == Lift.TRUE ? true : false;
                    onEditedData();
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
                    widget.item.lift = value == Lift.TRUE ? true : false;
                    onEditedData();
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
                    widget.item.liftStatus = value == Work.TRUE ? true : false;
                    onEditedData();
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
                    widget.item.liftStatus = value == Work.TRUE ? true : false;
                    onEditedData();
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
