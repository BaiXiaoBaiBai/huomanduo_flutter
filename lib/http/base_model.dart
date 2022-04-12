
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

    debug-SHA1
    D9:9E:FC:F7:41:22:C1:B3:25:92:6C:58:15:24:38:E7:27:AE:8C:99

    3D:68:12:9C:C2:C3:63:A6:36:73:A4:F9:B3:18:82:BD:49:AC:23:06



 */