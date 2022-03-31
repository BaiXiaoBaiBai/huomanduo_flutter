
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {

  final String user_id;
  final String user_name;
  final int user_type;
  final String avatar_url;
  final String mobile;

  UserModel({
    required this.user_id,
    required this.user_name,
    required this.user_type,
    required this.avatar_url,
    required this.mobile
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}