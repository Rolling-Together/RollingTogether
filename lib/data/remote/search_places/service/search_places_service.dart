import 'dart:convert';
import 'package:http/http.dart';
import 'package:rolling_together/data/remote/search_places/models/places_response.dart';
import '../../../../config.dart';

class SearchPlacesService {
  /// 위경도 -> 주소
  Future<PlaceResponse> searchPlaces(
      double latitude, double longitude, String query) async {
    final uri = Uri.parse("https://dapi.kakao.com/v2/local/search/keyword"
        ".json?y=$latitude&x=$longitude&radius=1500&query=$query");
    final response = await get(uri, headers: {
      'Authorization': 'KakaoAK '
          '$kakaoRestApiKey'
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final responseDto = PlaceResponse.fromJson(jsonResponse);
      return Future.value(responseDto);
    } else {
      return Future.error('failed');
    }
  }
}
