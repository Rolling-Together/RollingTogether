class BusCarResponse {
  final Response response;

  BusCarResponse({required this.response});

  factory BusCarResponse.fromJson(Map<String, dynamic> json) {
    return BusCarResponse(
      response: Response.fromJson(json['response']),
    );
  }
}

class Response {
  final Header header;
  final Body body;

  Response({required this.header, required this.body});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      header: Header.fromJson(json['header']),
      body: Body.fromJson(json['body']),
    );
  }
}

class Header {
  final String resultCode;
  final String resultMsg;

  Header({required this.resultCode, required this.resultMsg});

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      resultCode: json['resultCode'],
      resultMsg: json['resultMsg'],
    );
  }
}

class Body {
  final Items items;
  final int numOfRows;
  final int pageNo;
  final int totalCount;

  Body(
      {required this.items,
      required this.numOfRows,
      required this.pageNo,
      required this.totalCount});

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      items: Items.fromJson(json['items']),
      numOfRows: json['numOfRows'],
      pageNo: json['pageNo'],
      totalCount: json['totalCount'],
    );
  }
}

class Items {
  final List<Item> item;

  Items({required this.item});

  factory Items.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemJson = json['item'];
    List<Item> itemList = itemJson.map((item) => Item.fromJson(item)).toList();
    return Items(item: itemList);
  }
}

class Item {
  final String gpslati;
  final String gpslong;

  /// 정류소id
  final String nodeid;

  /// 정류소명
  final String nodenm;

  /// 정류소 순서
  final String nodeord;

  /// 노선번호
  final String routenm;

  /// 노선유형
  final String routetp;

  ///  차량번호, 99가9999
  final String vehicleno;

  Item(
      {required this.gpslati,
      required this.gpslong,
      required this.nodeid,
      required this.nodenm,
      required this.nodeord,
      required this.routenm,
      required this.routetp,
      required this.vehicleno});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      gpslati: json['gpslati'].toString(),
      gpslong: json['gpslong'].toString(),
      nodeid: json['nodeid'].toString(),
      nodenm: json['nodenm'].toString(),
      nodeord: json['nodeord'].toString(),
      routenm: json['routenm'].toString(),
      routetp: json['routetp'].toString(),
      vehicleno: json['vehicleno'].toString(),
    );
  }
}
