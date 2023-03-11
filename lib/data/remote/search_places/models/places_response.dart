class Place {
  String addressName;
  String categoryGroupCode;
  String categoryGroupName;
  String categoryName;
  String distance;
  String id;
  String phone;
  String placeName;
  String placeUrl;
  String roadAddressName;
  String x;
  String y;

  Place({
    required this.addressName,
    required this.categoryGroupCode,
    required this.categoryGroupName,
    required this.categoryName,
    required this.distance,
    required this.id,
    required this.phone,
    required this.placeName,
    required this.placeUrl,
    required this.roadAddressName,
    required this.x,
    required this.y,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      addressName: json['address_name'],
      categoryGroupCode: json['category_group_code'],
      categoryGroupName: json['category_group_name'],
      categoryName: json['category_name'],
      distance: json['distance'],
      id: json['id'],
      phone: json['phone'],
      placeName: json['place_name'],
      placeUrl: json['place_url'],
      roadAddressName: json['road_address_name'],
      x: json['x'],
      y: json['y'],
    );
  }
}

class PlaceResponse {
  List<Place> documents;
  Meta meta;

  PlaceResponse({
    required this.documents,
    required this.meta,
  });

  factory PlaceResponse.fromJson(Map<String, dynamic> json) {
    var documents = List<Place>.from(
        json['documents'].map((place) => Place.fromJson(place)));

    var meta = Meta.fromJson(json['meta']);

    return PlaceResponse(documents: documents, meta: meta);
  }
}

class Meta {
  bool isEnd;
  int pageableCount;
  SameName sameName;
  int totalCount;

  Meta({
    required this.isEnd,
    required this.pageableCount,
    required this.sameName,
    required this.totalCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      isEnd: json['is_end'],
      pageableCount: json['pageable_count'],
      sameName: SameName.fromJson(json['same_name']),
      totalCount: json['total_count'],
    );
  }
}

class SameName {
  String keyword;
  List<dynamic> region;
  String selectedRegion;

  SameName({
    required this.keyword,
    required this.region,
    required this.selectedRegion,
  });

  factory SameName.fromJson(Map<String, dynamic> json) {
    return SameName(
      keyword: json['keyword'],
      region: json['region'],
      selectedRegion: json['selected_region'],
    );
  }
}
