import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/bus/models/bus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_car_list_tago.dart';
import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_bus_stop_list_around_latlng_response.dart';
import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_bus_list_at_bus_stop_response.dart';
import 'package:rolling_together/config.dart';

class BusService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// 버스 정류장 정보 로드
  /// 정류소별도착예정정보 목록 조회 api 사용
  /// nodeId : 정류소id, DJB8001793
  Future<EstBusesAtBusStopResponse> getBusListAtBusStop(
      String cityCode, String nodeId) async {
    //정류장 정보 가져오기
    /*
    request ex)
     http://apis.data.go.kr/1613000/ArvlInfoInqireService/
     getSttnAcctoArvlPrearngeInfoList?serviceKey=인증키(URL Encode)&
     cityCode=25&nodeId=DJB8001793&numOfRows=10&pageNo=1&_type=json
     */

    final response = await http.get(Uri.parse(
        'http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList?'
        'serviceKey=$dataGoKrRestApiKey'
        '&cityCode=$cityCode&nodeId=$nodeId&numOfRows=100&pageNo=1&_type'
        '=json'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final responseDto = EstBusesAtBusStopResponse.fromJson(jsonResponse);
      return Future.value(responseDto);
    } else {
      return Future.error('failed');
    }
  }

  /// 좌표기반근접정류소 목록조회
  /// GPS좌표를 기반으로 근처(반경 500m)에 있는 정류장을 검색한다.
  Future<BusStopInfoResponse> getBusStopList(
      double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        'http://apis.data.go.kr/1613000/BusSttnInfoInqireService/getCrdntPrxmtSttnList?'
        'serviceKey=$dataGoKrRestApiKey&gpsLati=$latitude&gpsLong=$longitude&'
        'numOfRows=100&pageNo=1&_type=json'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final responseDto = BusStopInfoResponse.fromJson(jsonResponse);
      return Future.value(responseDto);
    } else {
      return Future.error('failed');
    }
  }

  /// 노선별버스위치 목록조회
  /// https://apis.data.go.kr/1613000/BusLcInfoInqireService
  /// /getRouteAcctoBusLcList?serviceKey=T2nJm9zlOA0Z7Dut%2BThT6Jp0It
  /// n0zZw80AUP3uMdOWlZJR1gVPkx9p1t8etuSW1kWsSNrGGHKdxbwr1IUlt%2Baw%3D%3D
  /// &pageNo=1&numOfRows=100&_type=json&cityCode=21&routeId=BSB5200083100
  Future<BusCarResponse> getCarListFromTago(
      String cityCode, String routeId) async {
    final response = await http.get(Uri.parse(
        'https://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList?'
        'serviceKey=$dataGoKrRestApiKey&pageNo=1&numOfRows=100&_type=json'
        '&cityCode=$cityCode&routeId=$routeId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final responseDto = BusCarResponse.fromJson(jsonResponse);
      return Future.value(responseDto);
    } else {
      return Future.error('failed');
    }
  }

  /// 해당 노선 버스 차량 목록 로드 from firestore
  Future<List<BusDto>> getCarListFromFs(String cityCode, String routeId) async {
    final result = await firestore
        .collection('Buses')
        .doc(cityCode)
        .collection('RouteIds')
        .doc(routeId)
        .collection('Cars')
        .get();

    if (result.docs.isNotEmpty) {
      List<BusDto> list = [];
      for (var snapshot in result.docs) {
        list.add(BusDto.fromSnapshot(snapshot, cityCode.toString(), routeId));
      }
      return Future.value(list);
    } else {
      return Future.value(List.empty());
    }
  }

  /// 리프트 유무/작동 여부 업데이트
  Future<void> updateCarStatus(List<BusDto> list) async {
    try {
      final collection = firestore
          .collection('Buses')
          .doc(list.first.cityCode)
          .collection('RouteIds')
          .doc(list.first.routeId)
          .collection('Cars');
      final batch = firestore.batch();

      for (final bus in list) {
        final doc = bus.id == null ? collection.doc() : collection.doc(bus.id);
        batch.set(doc, bus.toMap(), SetOptions(merge: true));
      }

      return await Future.value(batch.commit());
    } catch (e) {
      return Future.error('failed');
    }
  }
}
