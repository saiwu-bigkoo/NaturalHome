// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) {
  return CartItemModel(
    json['id'] as String,
    json['colourName'] as String,
    json['size'] as String,
    json['product'] == null
        ? null
        : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    json['count'] as int,
  );
}

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'colourName': instance.colourName,
      'size': instance.size,
      'count': instance.count,
      'product': instance.product,
    };
