import 'dart:convert';

import '../models/reverse_geocoding_response.dart';
import 'package:http/http.dart' as http;
import 'package:rolling_together/config.dart';

/// 위경도 -> 주소 서비스
class ReverseGeocodingService {
  /// 위경도 -> 주소
  Future<ReverseGeocodingResponse> coordToAddress(double latitude,
      double longitude) async {
    final uri = Uri.parse("https://dapi.kakao.com/v2/local/geo/coord2address"
        ".json?input_coord=WGS84&x=$longitude&y=$latitude");

    final response = await http.get(
    uri,headers: {'Authorization': 'KakaoAK $kakaoRestApiKey'}
    );

    if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final responseDto = ReverseGeocodingResponse.fromJson(jsonResponse);
    return Future.value(responseDto);
    } else {
    return Future.error('failed');
    }
  }
}
