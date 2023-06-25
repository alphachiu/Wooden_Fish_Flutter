import 'package:json_annotation/json_annotation.dart';
part 'setting.g.dart';


@JsonSerializable()
class Setting{
  Setting({this.isDisplay = true, this.isVibration = true});

     bool isDisplay;
     bool isVibration;

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

}