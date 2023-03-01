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
  // 역명
  String sname;

  // 휠체어 리프트(내부)
  int wlI;

  // 휠체어 리프트(외부)
  int wlO;

  // 엘리베이터(내부)
  int elI;

  // 엘리베이터(외부)
  int elO;

  // 에스컬레이터
  int es;

  // 시각장애인 유도로
  int blindroad;

  // 외부 경사로
  int ourbridge;

  // 승차 보조대
  int helptake;

  // 장애인 화장실
  int toilet;

  // 장애인 화장실 구분 -> 공용 or 분리
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
      sname: json['sname'],
      wlI: json['wl_i'],
      wlO: json['wl_o'],
      elI: json['el_i'],
      elO: json['el_o'],
      es: json['es'],
      blindroad: json['blindroad'],
      ourbridge: json['ourbridge'],
      helptake: json['helptake'],
      toilet: json['toilet'],
      toiletGubun: json['toilet_gubun'],
    );
  }
}
