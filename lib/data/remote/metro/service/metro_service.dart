import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rolling_together/commons/utils/coords_dist_util.dart';
import 'package:rolling_together/data/remote/metro/models'
    '/busan_metro_station_convenience.dart' as busan_metro_response;
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
          await rootBundle.loadString('assets/data/busan_metro_station_list'
              '.json');

      Map<String, dynamic> decodedData = json.decode(jsonFile);
      decodedData.forEach((key, value) {
        busanMetroStationMap[key] = MetroStationDto.fromJson(value, key);
      });
    }
    return busanMetroStationMap;
  }

  /// 부산 지하철 역 목록 맵 반환
  Future<List<MetroStationDto>> loadAroundStations(
      double lat, double lon) async {
    // 주변 역 1km 이내
    List<MetroStationDto> aroundStations = [];
    for (var station in busanMetroStationMap.values) {
      if (haversineDistance(lat, lon, station.latitude, station.longitude) <=
          1000) {
        aroundStations.add(station);
      }
    }

    return aroundStations;
  }

  /// 부산 도시 철도 장애인 편의 시설 정보 로드
  Future<busan_metro_response.Item> getConvenienceInfoBusanMetro(
      String sCode) async {
    /// http://data.humetro.busan.kr/voc/api/open_api_convenience.tnn?
    /// act=json&scode=101&serviceKey=
    final response = await http.get(Uri.parse(
        "http://data.humetro.busan.kr/voc/api/open_api_convenience.tnn"
        "?act=json&scode=$sCode&serviceKey=$dataGoKrRestApiKey"));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final responseDto = busan_metro_response.Response.fromJson(jsonResponse);
      return Future.value(responseDto.body.item.first);
    } else {
      return Future.error('failed');
    }
  }
}
