// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BrandModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) {
  return BrandModel(
    json['id'] as String,
    json['name'] as String,
    json['avatar'] as String,
    json['description'] as String,
    json['cover'] as String,
    json['score'] as String,
    json['tag'] as String,
  );
}

Map<String, dynamic> _$BrandModelToJson(BrandModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'description': instance.description,
      'cover': instance.cover,
      'score': instance.score,
      'tag': instance.tag,
    };
