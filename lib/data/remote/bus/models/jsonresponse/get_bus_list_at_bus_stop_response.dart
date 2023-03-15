/// '정류소별로 실시간 도착예정정보 및 운행정보 목록을 조회한다.'의 응답 데이터
class EstBusesAtBusStopResponse {
  Header? header;
  Body? body;

  EstBusesAtBusStopResponse({required this.header, required this.body});

  factory EstBusesAtBusStopResponse.fromJson(Map<String, dynamic> json) {
    return EstBusesAtBusStopResponse(
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
  Items items;
  int numOfRows;
  int pageNo;
  int totalCount;

  Body({
    required this.items,
    required this.numOfRows,
    required this.pageNo,
    required this.totalCount,
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      items: json['items'].runtimeType == String
          ? Items(item: List.empty())
          : Items.fromJson(json['items']),
      numOfRows: json['numOfRows'],
      pageNo: json['pageNo'],
      totalCount: json['totalCount'],
    );
  }
}

class Items {
  List<Item> item;

  Items({required this.item});

  factory Items.fromJson(Map<String, dynamic> json) {
    if (json['item'].runtimeType == String) {
      return Items(
        item: List.empty(),
      );
    } else {
      final itemList = json['item'] as List;
      final routeIdSet = <String>{};

      return Items(
        item: itemList
            .where((element) {
              final routeId = element['routeid'].toString();
              if (routeIdSet.contains(routeId)) {
                return false;
              } else {
                routeIdSet.add(routeId);
                return true;
              }
            })
            .map((itemJson) => Item.fromJson(itemJson))
            .toList(),
      );
    }
  }
}

class Item {
  // 정류소id, DJB8001793
  late String nodeId;

  // 정류소명, 북대전농협
  late String nodeNm;

  // 노선ID, DJB30300002
  late String routeId;

  // 노선번호, 5
  late String routeNo;

  // 노선유형, 마을버스
  late String routeTp;

  // 도착예정버스 남은 정류장 수, 15
  late String arrprevstationcnt;

  // 도착예정버스 차량유형, 저상버스
  late String vehicleTp;

  // 도착예정버스 도착예상시간, 816, 초
  late String arrTime;

  Item(
      {required this.nodeId,
      required this.nodeNm,
      required this.routeId,
      required this.routeNo,
      required this.routeTp,
      required this.arrprevstationcnt,
      required this.vehicleTp,
      required this.arrTime});

  Item.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeid'].toString();
    nodeNm = json['nodenm'].toString();
    routeId = json['routeid'].toString();
    routeNo = json['routeno'].toString();
    routeTp = json['routetp'].toString();
    arrprevstationcnt = json['arrprevstationcnt'].toString();
    vehicleTp = json['vehicletp'].toString();
    arrTime = json['arrtime'].toString();
  }
}
