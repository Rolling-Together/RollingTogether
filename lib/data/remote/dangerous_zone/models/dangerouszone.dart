import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dangerouszone.g.dart';

@JsonSerializable()
class DangerousZone {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'categoryId')
  String categoryId;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'latitude')
  String latitude;
  @JsonKey(name: 'longitude')
  String longitude;
  @JsonKey(name: 'informerId')
  String informerId;
  @JsonKey(name: 'informerName')
  String informerName;

  DangerousZone(this.id, this.categoryId, this.description, this.latitude,
      this.longitude, this.informerId, this.informerName);

  factory DangerousZone.fromJson(Map<String, dynamic> json)
  => _$DangerousZoneFromJson(json);

  Map<String, dynamic> toJson() => _$DangerousZoneToJson(this);
}
