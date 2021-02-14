// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    json['id'] as String,
    json['name'] as String,
    json['description'] as String,
    json['cover'] as String,
    json['price'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    (json['colours'] as List)?.map((e) => e as String)?.toList(),
    (json['coloursName'] as List)?.map((e) => e as String)?.toList(),
    (json['size'] as List)?.map((e) => e as String)?.toList(),
    json['tag'] as String,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'cover': instance.cover,
      'price': instance.price,
      'images': instance.images,
      'colours': instance.colours,
      'coloursName': instance.coloursName,
      'size': instance.size,
      'tag': instance.tag,
    };
