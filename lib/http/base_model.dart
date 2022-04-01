
import 'package:json_annotation/json_annotation.dart';
part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {

  //@JsonKey(fromJson: _fromJson, toJson: _toJson)
  final int status;
  final String msg;
  final dynamic data;

  BaseModel({
    required this.status,
    required this.msg,
    this.data
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);

  // static int _fromJson(String status) => int.parse(status);
  // static String _toJson(int status) => status.toString();
}

/*
    vim ~/.bash_profile
    source ~/.bash_profile
    flutter pub run build_runner build

 */