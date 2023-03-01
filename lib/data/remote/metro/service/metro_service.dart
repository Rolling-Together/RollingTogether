import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rolling_together/data/remote/metro/models/busan_metro_station_convenience.dart'
    as BusanMetroResponse;
import 'package:rolling_together/data/remote/metro/models/metro_station.dart';

import 'package:http/http.dart' as http;
import 'package:rolling_together/config.dart';
import 'dart:io';

class MetroService {
  static final Map<String, MetroStationDto> busanMetroStationMap = {};

  /// 부산 지하철 역 목록 맵 반환
  Future<Map<String, MetroStationDto>> loadMetroStationMap() async {
    if (busanMetroStationMap.isEmpty) {
      final jsonFile =
          await rootBundle.loadString('assets/busan_metro_station_list.json');

      Map<String, dynamic> decodedData = json.decode(jsonFile);
      decodedData.forEach((key, value) {
        busanMetroStationMap[key] = MetroStationDto.fromJson(value);
      });
    }
    return busanMetroStationMap;
  }

  /// 부산 도시 철도 장애인 편의 시설 정보 로드
  /// scode : 역 코드
  Future<BusanMetroResponse.Item> getConvenienceInfoBusanMetro(
      String sCode) async {
    /// http://data.humetro.busan.kr/voc/api/open_api_convenience.tnn?
    /// act=json&scode=101&serviceKey=
    final response = await http.get(Uri.parse(
        " http://data.humetro.busan.kr/voc/api/open_api_convenience.tnn"
        "?act=json&scode=$sCode&serviceKey=$dataGoKrRestApiKey"));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final responseDto = BusanMetroResponse.Response.fromJson(jsonResponse);
      return Future.value(responseDto.body.item.first);
    } else {
      return Future.error('failed');
    }
  }
}
