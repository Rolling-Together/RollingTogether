class Response {
  Header header;
  Body body;

  Response({required this.header, required this.body});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      header: Header.fromJson(json['response']['header']),
      body: Body.fromJson(json['response']['body']),
    );
  }
}

class Header {
  String resultCode;
  String resultMsg;

  Header({required this.resultCode, required this.resultMsg});

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      resultCode: json['resultCode'],
      resultMsg: json['resultMsg'],
    );
  }
}

class Body {
  List<Item> item;
  int totalCount;

  Body({required this.item, required this.totalCount});

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      item: List<Item>.from(json['item'].map((x) => Item.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}

class Item {
  /// 역명
  String sname;

  /// 휠체어 리프트(내부)
  String wlI;

  /// 휠체어 리프트(외부)
  String wlO;

  /// 엘리베이터(내부)
  String elI;

  /// 엘리베이터(외부)
  String elO;

  /// 에스컬레이터
  String es;

  /// 시각장애인 유도로
  String blindroad;

  /// 외부 경사로
  String ourbridge;

  /// 승차 보조대
  String helptake;

  /// 장애인 화장실
  String toilet;

  /// 장애인 화장실 구분 -> 공용 or 분리
  String toiletGubun;

  Item({
    required this.sname,
    required this.wlI,
    required this.wlO,
    required this.elI,
    required this.elO,
    required this.es,
    required this.blindroad,
    required this.ourbridge,
    required this.helptake,
    required this.toilet,
    required this.toiletGubun,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        sname: json['sname'].toString(),
        wlI: json['wl_i'].toString(),
        wlO: json['wl_o'].toString(),
        elI: json['el_i'].toString(),
        elO: json['el_o'].toString(),
        es: json['es'].toString(),
        blindroad: json['blindroad'].toString(),
        ourbridge: json['ourbridge'].toString(),
        helptake: json['helptake'].toString(),
        toilet: json['toilet'].toString(),
        toiletGubun: json['toilet_gubun'].toString());
  }
}
