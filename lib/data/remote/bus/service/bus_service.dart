import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolling_together/data/remote/bus/models/bus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_crdntprxmtsttnlist_response.dart';
import 'package:rolling_together/data/remote/bus/models/jsonresponse/get_sttnacctoarvlprearngeinfolist_response.dart';

class BusService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// 버스 정류장 정보 로드
  /// 정류소별도착예정정보 목록 조회 api 사용
  /// nodeId : 정류소id, DJB8001793
  Stream<dynamic> getBusListAtBusStop(String cityCode, String nodeId) async* {
    //정류장 정보 가져오기
    /*
    request ex)
     http://apis.data.go.kr/1613000/ArvlInfoInqireService/
     getSttnAcctoArvlPrearngeInfoList?serviceKey=인증키(URL Encode)&
     cityCode=25&nodeId=DJB8001793&numOfRows=10&pageNo=1&_type=xml
     */

    final response = await http.get(Uri.parse(
        'http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList?'
        'serviceKey=인증키(URL Encode)'
        '&cityCode=$cityCode&nodeId=$nodeId&numOfRows=100&pageNo=1&_type'
        '=json'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final responseDto = EstBusesAtBusStopResponse.fromJson(jsonResponse);
      yield responseDto;
    } else {
      yield Stream.error(response.statusCode);
    }
  }

  /// 좌표기반근접정류소 목록조회
  /// GPS좌표를 기반으로 근처(반경 500m)에 있는 정류장을 검색한다.
  Stream<dynamic> getBusStopList(double latitude, double longitude) async* {
    final response = await http.get(Uri.parse(
        'http://apis.data.go.kr/1613000/BusSttnInfoInqireService/getCrdntPrxmtSttnList?'
        'serviceKey=인증키(URL Encode)&gpsLati=$latitude&gpsLong=$longitude&'
        'numOfRows=100&pageNo=1&_type=json'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final responseDto = BusStopInfoResponse.fromJson(jsonResponse);
      yield responseDto;
    } else {
      yield Stream.error(response.statusCode);
    }
  }

  /// 해당 노선 버스 차량 목록 로드
  Stream<List<BusDto>> getCarList(String cityCode, String routeId) async* {
    var result = await firestore
        .collection('Buses')
        .doc(cityCode)
        .collection('RouteIds')
        .doc(routeId)
        .collection('Cars')
        .get();

    if (result.docs.isNotEmpty) {
      List<BusDto> list = [];
      for (var snapshot in result.docs) {
        list.add(BusDto.fromSnapshot(snapshot, cityCode, routeId));
      }
      yield list;
    }
  }

  /// 리프트 유무/작동 여부 업데이트
  Future<void> likeDangerousZone(BusDto updateDto) async {
    try {
      await firestore
          .collection('Buses')
          .doc(updateDto.cityCode)
          .collection('RouteIds')
          .doc(updateDto.routeId)
          .collection('Cars')
          .doc(updateDto.id)
          .update(updateDto.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
