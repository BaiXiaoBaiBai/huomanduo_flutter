// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      user_id: json['user_id'] as String,
      user_name: json['user_name'] as String,
      user_type: json['user_type'] as int,
      avatar_url: json['avatar_url'] as String,
      mobile: json['mobile'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'user_name': instance.user_name,
      'user_type': instance.user_type,
      'avatar_url': instance.avatar_url,
      'mobile': instance.mobile,
    };
