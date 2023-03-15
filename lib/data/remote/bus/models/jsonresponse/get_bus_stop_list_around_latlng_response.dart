/// 'GPS좌표를 기반으로 근처(반경 500m)에 있는 정류장을 검색한다' 의 응답 데이터
class BusStopInfoResponse {
  late Response response;

  BusStopInfoResponse({required this.response});

  BusStopInfoResponse.fromJson(Map<String, dynamic> json) {
    response = Response.fromJson(json['response'] as Map<String, dynamic>);
  }
}

class Response {
  late Header header;
  late Body body;

  Response({required this.header, required this.body});

  Response.fromJson(Map<String, dynamic> json) {
    header = Header.fromJson(json['header'] as Map<String, dynamic>);
    body = Body.fromJson(json['body'] as Map<String, dynamic>);
  }
}

class Header {
  late String resultCode;
  late String resultMsg;

  Header({required this.resultCode, required this.resultMsg});

  Header.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'] as String;
    resultMsg = json['resultMsg'] as String;
  }
}

class Body {
  late Items items;
  late int numOfRows;
  late int pageNo;
  late int totalCount;

  Body(
      {required this.items,
      required this.numOfRows,
      required this.pageNo,
      required this.totalCount});

  Body.fromJson(Map<String, dynamic> json) {
    items = Items.fromJson(json['items'] as Map<String, dynamic>);
    numOfRows = json['numOfRows'] as int;
    pageNo = json['pageNo'] as int;
    totalCount = json['totalCount'] as int;
  }
}

class Items {
  late List<Item> item;

  Items({required this.item});

  Items.fromJson(Map<String, dynamic> json) {
    item = List<Item>.from(
        (json['item'] as List<dynamic>)
            .where((item) => item.containsKey('nodeno'))
            .map((x) => Item.fromJson(x)));
  }
}

class Item {
  // 정류소 위도(y)
  late String gpslati;

  // 정류소 경도(x)
  late String gpslong;

  // 정류소id
  late String nodeid;

  // 정류소명, 성북3통
  late String nodenm;

  // 도시코드, 25
  late String citycode;

  Item({
    required this.gpslati,
    required this.gpslong,
    required this.nodeid,
    required this.nodenm,
    required this.citycode,
  });

  Item.fromJson(Map<String, dynamic> json) {
    gpslati = json['gpslati'].toString();
    gpslong = json['gpslong'].toString();
    nodeid = json['nodeid'].toString();
    nodenm = json['nodenm'].toString();
    citycode = json['citycode'].toString();
  }
}
