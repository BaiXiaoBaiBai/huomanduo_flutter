// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) => BaseModel(
      error: BaseModel._fromJson(json['error'] as String),
      msg: json['msg'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'error': BaseModel._toJson(instance.error),
      'msg': instance.msg,
      'data': instance.data,
    };
