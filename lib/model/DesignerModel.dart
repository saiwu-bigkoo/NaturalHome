import 'package:json_annotation/json_annotation.dart';

part 'DesignerModel.g.dart';


@JsonSerializable()
class DesignerModel extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'tag')
  String tag;

  DesignerModel(this.id,this.name,this.avatar,this.description,this.tag,);

  factory DesignerModel.fromJson(Map<String, dynamic> srcJson) => _$DesignerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DesignerModelToJson(this);

}


