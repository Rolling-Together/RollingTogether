class ReverseGeocodingResponse {
  late Meta meta;
  late List<Document> documents;

  ReverseGeocodingResponse({required this.meta, required this.documents});

  factory ReverseGeocodingResponse.fromJson(Map<String, dynamic> json) {
    return ReverseGeocodingResponse(
      meta: Meta.fromJson(json['meta']),
      documents: (json['documents'] as List<dynamic>)
          .map((document) => Document.fromJson(document))
          .toList(),
    );
  }
}

class Meta {
  late int totalCount;

  Meta({required this.totalCount});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      totalCount: json['total_count'],
    );
  }
}

class RoadAddress {
  late String addressName;
  late String region1depthName;
  late String region2depthName;
  late String region3depthName;
  late String roadName;
  late String undergroundYn;
  late String mainBuildingNo;
  late String subBuildingNo;
  late String buildingName;
  late String zoneNo;

  RoadAddress({
    required this.addressName,
    required this.region1depthName,
    required this.region2depthName,
    required this.region3depthName,
    required this.roadName,
    required this.undergroundYn,
    required this.mainBuildingNo,
    required this.subBuildingNo,
    required this.buildingName,
    required this.zoneNo,
  });

  factory RoadAddress.fromJson(Map<String, dynamic> json) {
    return RoadAddress(
      addressName: json['address_name'],
      region1depthName: json['region_1depth_name'],
      region2depthName: json['region_2depth_name'],
      region3depthName: json['region_3depth_name'],
      roadName: json['road_name'],
      undergroundYn: json['underground_yn'],
      mainBuildingNo: json['main_building_no'],
      subBuildingNo: json['sub_building_no'],
      buildingName: json['building_name'],
      zoneNo: json['zone_no'],
    );
  }
}

class Address {
  late String addressName;
  late String region1depthName;
  late String region2depthName;
  late String region3depthName;
  late String mountainYn;
  late String mainAddressNo;
  late String subAddressNo;

  Address({
    required this.addressName,
    required this.region1depthName,
    required this.region2depthName,
    required this.region3depthName,
    required this.mountainYn,
    required this.mainAddressNo,
    required this.subAddressNo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressName: json['address_name'],
      region1depthName: json['region_1depth_name'],
      region2depthName: json['region_2depth_name'],
      region3depthName: json['region_3depth_name'],
      mountainYn: json['mountain_yn'],
      mainAddressNo: json['main_address_no'],
      subAddressNo: json['sub_address_no'],
    );
  }
}

class Document {
  RoadAddress? roadAddress;
  late Address address;

  Document({this.roadAddress, required this.address});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      roadAddress: RoadAddress.fromJson(json['road_address']),
      address: Address.fromJson(json['address']),
    );
  }
}
