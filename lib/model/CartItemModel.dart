import 'package:json_annotation/json_annotation.dart';

import 'ProductModel.dart';

part 'CartItemModel.g.dart';


@JsonSerializable()
class CartItemModel extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'colourName')
  String colourName;

  @JsonKey(name: 'size')
  String size;

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'product')
  ProductModel product;

  CartItemModel(this.id,this.colourName,this.size,this.product,this.count);

  factory CartItemModel.fromJson(Map<String, dynamic> srcJson) => _$CartItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

}

