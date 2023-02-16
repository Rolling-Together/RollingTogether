import 'package:json_annotation/json_annotation.dart';
part 'likedangerouszone.g.dart';

@JsonSerializable()
class LikeDangerousZone {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'userId')
  String userId;
  @JsonKey(name: 'userName')
  String userName;

  LikeDangerousZone(this.id, this.userId, this.userName);

  factory LikeDangerousZone.fromJson(Map<String, dynamic> json) =>
      _$LikeDangerousZoneFromJson(json);

  Map<String, dynamic> toJson() => _$LikeDangerousZoneToJson(this);
}
