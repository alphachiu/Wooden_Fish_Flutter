import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'local_setting.g.dart';

@JsonSerializable()
class LocalSetting {
  LocalSetting(
      {this.isDisplay = true,
      this.isVibration = true,
      this.displayWord = "+1",
      this.autoSpeed = 0.5});

  bool isDisplay;
  bool isVibration;
  String displayWord;
  double autoSpeed;

  factory LocalSetting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
