import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
part 'local_setting.g.dart';

@JsonSerializable()
class LocalSetting {
  LocalSetting(
      {this.isDisplay = true,
      this.isVibration = true,
      this.displayWord = "+1",
      this.autoSpeed = 0.5,
      this.woodenFishBg = "BgElement.none"});

  bool isDisplay;
  bool isVibration;
  String displayWord;
  double autoSpeed;
  String woodenFishBg;

  factory LocalSetting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
