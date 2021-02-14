import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProductModel.g.dart';

@JsonSerializable()
class ProductModel extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'price')
  String price;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'colours')
  List<String> colours;

  @JsonKey(name: 'coloursName')
  List<String> coloursName;

  @JsonKey(name: 'size')
  List<String> size;

  @JsonKey(name: 'tag')
  String tag;

  ProductModel(this.id,this.name,this.description,this.cover,this.price,this.images,this.colours,this.coloursName,this.size,this.tag,);

  factory ProductModel.fromJson(Map<String, dynamic> srcJson) => _$ProductModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

}
