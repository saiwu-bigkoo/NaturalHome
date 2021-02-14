import 'package:json_annotation/json_annotation.dart';

part 'BrandModel.g.dart';


@JsonSerializable()
class BrandModel extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'score')
  String score;

  @JsonKey(name: 'tag')
  String tag;

  BrandModel(this.id,this.name,this.avatar,this.description,this.cover,this.score,this.tag,);

  factory BrandModel.fromJson(Map<String, dynamic> srcJson) => _$BrandModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);

}