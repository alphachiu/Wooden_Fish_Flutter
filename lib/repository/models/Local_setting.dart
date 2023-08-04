import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
part 'local_setting.g.dart';

@JsonSerializable()
class LocalSetting {
  LocalSetting(
      {this.isDisplay = true,
      this.isVibration = true,
      this.displayWord = "祈禱",
      this.autoSpeed = 1,
      this.woodenFishBg = "WoodenFishBgElement.none",
      this.woodenFishSkin = "WoodenFishSkinElement.wood",
      this.woodenFishSound = "WoodenFishSoundElement.sound01",
      this.isSetPrayPhoto = false,
      this.userName = "靜心小僧",
      this.level = "WoodenFishLevelElement.lv01",
      this.totalCount = "0"});

  bool isDisplay; //display pray word
  bool isVibration; //vibration
  String displayWord; // pray word
  double autoSpeed; // set auto knock speed
  String woodenFishBg; //set home background category
  String woodenFishSkin; // set wooden fish skin category
  bool isSetPrayPhoto; //is save photo
  String woodenFishSound; //sound category
  String userName; //set user name
  String level; // set level
  String totalCount; // total knock count

  factory LocalSetting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
