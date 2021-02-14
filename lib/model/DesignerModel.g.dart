// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DesignerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesignerModel _$DesignerModelFromJson(Map<String, dynamic> json) {
  return DesignerModel(
    json['id'] as String,
    json['name'] as String,
    json['avatar'] as String,
    json['description'] as String,
    json['tag'] as String,
  );
}

Map<String, dynamic> _$DesignerModelToJson(DesignerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'description': instance.description,
      'tag': instance.tag,
    };
