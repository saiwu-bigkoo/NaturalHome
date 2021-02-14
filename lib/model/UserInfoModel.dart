import 'package:json_annotation/json_annotation.dart';

part 'UserInfoModel.g.dart';

@JsonSerializable()
class UserInfoModel extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'spend')
  String spend;

  @JsonKey(name: 'alreadybuy')
  String alreadybuy;

  @JsonKey(name: 'collection')
  String collection;

  UserInfoModel(this.id,this.avatar,this.name,this.spend,this.alreadybuy,this.collection,);

  factory UserInfoModel.fromJson(Map<String, dynamic> srcJson) => _$UserInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

}


