import 'package:flutter/material.dart';
import 'package:rolling_together/commons/class/extensions.dart';
import 'package:rolling_together/commons/class/firebase_storage.dart';
import 'package:rolling_together/commons/enum/facility_checklist.dart';
import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_bus_stop_list_around_latlng_response.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/facility/models/facility.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rolling_together/data/remote/metro/models/metro_station.dart';
import 'package:rolling_together/ui/screens/14_dangerous_zone_post_screen.dart';
import 'package:rolling_together/ui/screens/7_facility_post_screen.dart';
import '../../data/remote/bus/controllers/bus_controller.dart';
import '../../data/remote/metro/controllers/metro_controller.dart';

class FacilityInfoBottomSheet extends StatelessWidget {
  final FacilityDto facilityDto;

  FacilityInfoBottomSheet(this.facilityDto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Get.to(FacilityPostScreen(facilityDto: facilityDto));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${facilityDto.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
              Text(
                '${facilityDto.addressName}',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.looks_one, size: 30),
                        SizedBox(height: 3.0),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '1층 ',
                                  style: TextStyle(fontSize: 14.5),
                                ),
                                TextSpan(
                                  text:
                                      '${facilityDto.checkList[FacilityCheckListType.floorFirst]!.status.toExistenceKr()}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.5),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.accessible, size: 30),
                        SizedBox(height: 3.0),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '경사로 ',
                                  style: TextStyle(fontSize: 14.5),
                                ),
                                TextSpan(
                                  text:
                                      '${facilityDto.checkList[FacilityCheckListType.wheelChair]!.status.toExistenceKr()}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.5),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 19.0, bottom: 6.0, left: 6.0, right: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.elevator, size: 30),
                        SizedBox(height: 4.0),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '엘레베이터 \n',
                                  style: TextStyle(fontSize: 14.5),
                                ),
                                TextSpan(
                                  text:
                                      '     ${facilityDto.checkList[FacilityCheckListType.elevator]!.status.toExistenceKr()}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.5),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 19.0, bottom: 6.0, left: 6.0, right: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wc, size: 30),
                        SizedBox(height: 4.0),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '장애인 화장실 \n',
                                  style: TextStyle(fontSize: 14.5),
                                ),
                                TextSpan(
                                  text:
                                      '       ${facilityDto.checkList[FacilityCheckListType.toilet]!.status.toExistenceKr()}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.5),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                    '업데이트 : ${DateFormat('MM/dd HH:mm').format(facilityDto.dateTime.toDate())}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DangerousZoneBottomSheet extends StatelessWidget {
  final DangerousZoneDto dangerousZoneDto;

  DangerousZoneBottomSheet(this.dangerousZoneDto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Get.to(DangerousZonePostScreen(),
            arguments: {'dangerousZoneDto': dangerousZoneDto});
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.only(right: 15.0),
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          snapshot.data.toString(),
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return const Icon(Icons.warning_amber_outlined, size: 50);
                    }
                  },
                  future: dangerousZoneDto.tipOffPhotos.isNotEmpty
                      ? getFirebaseStorageDownloadUrl(
                          'dangerouszones/${dangerousZoneDto.tipOffPhotos[0]}')
                      : Future.error(''),
                )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20.0),
                //height: MediaQuery.of(context).size.height * 0.2,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dangerousZoneDto.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.black,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        dangerousZoneDto.addressName,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '업데이트 : ${DateFormat('MM/dd HH:mm').format(dangerousZoneDto.dateTime.toDate())}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '작성자 : ${dangerousZoneDto.informerName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusBottomSheet extends StatefulWidget {
  final Item busStop;
  final BusController busController = Get.put(BusController());
  final DateFormat dateFormat = DateFormat('MM/dd HH:mm');

  BusBottomSheet(this.busStop, {super.key});

  @override
  _BusListScreenState createState() {
    return _BusListScreenState();
  }
}

class _BusListScreenState extends State<BusBottomSheet> {
  Map<String, bool> expandStateMap = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.busController.dispose();
    super.dispose();
  }

  Widget _buildBusNumberItem(String routeNo) {
    return GestureDetector(
      onTap: () {
        setState(() {
          expandStateMap[routeNo] = !expandStateMap[routeNo]!;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              routeNo,
              style: const TextStyle(fontSize: 17),
            ),
            Icon(
              expandStateMap[routeNo]!
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBusNumberDetails(String routeNo) {
    final busList = widget.busController.busListAtBusStopMap[routeNo]!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: expandStateMap[routeNo]! ? busList.length * 50.0 : 0,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: busList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(busList[index].vehicleNo,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Expanded(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '리프트 ',
                                  style: TextStyle(fontSize: 14.5),
                                ),
                                TextSpan(
                                  text:
                                      '${busList[index].lift.toExistenceKr()}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.5),
                                ),
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '리프트 작동 ',
                                  style: TextStyle(fontSize: 14.5),
                                ),
                                TextSpan(
                                  text: '${busList[index].lift.toStatusKr()}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.5),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Text(
                      '        수정'
                      '\n${widget.dateFormat.format(busList[index].updated!.toDate())}',
                      style: const TextStyle(fontSize: 12)),
                ],
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      widget.busController.getCarListFromFsByBusStop(
          widget.busStop.citycode, widget.busStop.nodeid);

    return Obx(() {
      if (widget.busController.busListAtBusStopMap.isEmpty) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (expandStateMap.isEmpty) {
        for (String key in widget.busController.busListAtBusStopMap.keys) {
          expandStateMap[key] = false;
        }
      }

      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black),
                children: [
                  TextSpan(text: '${widget.busStop.nodenm}'),
                  TextSpan(
                    text: ' 정류장',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.busController.busListAtBusStopMap.length,
                itemBuilder: (BuildContext context, int index) {
                  String routeNo = widget.busController.busListAtBusStopMap.keys
                      .toList()[index];
                  return Column(
                    children: [
                      _buildBusNumberItem(routeNo),
                      _buildBusNumberDetails(routeNo),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class SubwayBottomSheet extends StatefulWidget {
  final MetroStationDto metroStationDto;
  final MetroController metroController = Get.put(MetroController());

  SubwayBottomSheet(this.metroStationDto, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _SubwayBottomSheetState();
  }
}

class _SubwayBottomSheetState extends State<SubwayBottomSheet> {
  @override
  void dispose() {
    widget.metroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.metroController.convenienceInfoInMetroStation.value == null) {
      widget.metroController
          .getConvenienceInfoBusanMetro(widget.metroStationDto.scode);
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Obx(() {
        if (widget.metroController.convenienceInfoInMetroStation.value ==
            null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.metroStationDto.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      ' 지하철',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(child: getGridView())
              ],
            ));
      }),
    );
  }

  getGridView() {
    final items = [
      [
        '내부 \n휠체어리프트',
        '${widget.metroController.convenienceInfoInMetroStation.value!.wlI}대'
      ],
      [
        '외부 \n휠체어리프트',
        '${widget.metroController.convenienceInfoInMetroStation.value!.wlO}대'
      ],
      [
        '내부 \n엘리베이터',
        '${widget.metroController.convenienceInfoInMetroStation.value!.elI}대'
      ],
      [
        '외부 \n엘리베이터 ',
        ' ${widget.metroController.convenienceInfoInMetroStation.value!.elO}대'
      ],
      [
        '에스컬레이터 ',
        ' ${widget.metroController.convenienceInfoInMetroStation.value!.es}대'
      ],
      [
        '외부 경사로 ',
        ' ${widget.metroController.convenienceInfoInMetroStation.value!.ourbridge}곳'
      ],
      [
        '승차 보조대 ',
        ' ${widget.metroController.convenienceInfoInMetroStation.value!.helptake}대'
      ],
      [
        '장애인 화장실 ',
        ' ${widget.metroController.convenienceInfoInMetroStation.value!.toilet}칸'
      ]
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(items[index][0],
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center),
          Text(
            items[index][1],
            style: const TextStyle(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ]);
      },
    );
  }
}
