
import 'package:json_annotation/json_annotation.dart';
part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {

  @JsonKey(fromJson: _fromJson, toJson: _toJson )
  final int error;
  final String msg;
  final dynamic data;

  BaseModel({required this.error, required this.msg,this.data});

  factory BaseModel.fromJson(Map<String, dynamic> json) => _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);

  static int _fromJson(String error) => int.parse(error);
  static String _toJson(int error) => error.toString();
}

/*
    vim ~/.bash_profile
    source ~/.bash_profile
    flutter pub run build_runner build

 */