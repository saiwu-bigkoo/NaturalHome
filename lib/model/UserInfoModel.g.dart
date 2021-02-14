// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    json['id'] as String,
    json['avatar'] as String,
    json['name'] as String,
    json['spend'] as String,
    json['alreadybuy'] as String,
    json['collection'] as String,
  );
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'name': instance.name,
      'spend': instance.spend,
      'alreadybuy': instance.alreadybuy,
      'collection': instance.collection,
    };
