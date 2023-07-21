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
      this.woodenFishBg = "WoodenFishBgElement.none",
      this.woodenFishSkin = "WoodenFishSkinElement.wood",
      this.woodenFishSound = "woodenFish_sound_01.wav",
      this.isSetPrayPhoto = false});

  bool isDisplay; //display pray word
  bool isVibration; //vibration
  String displayWord; // pray word
  double autoSpeed; // set auto knock speed
  String woodenFishBg; //set home background
  String woodenFishSkin; // set wooden fish skin
  bool isSetPrayPhoto;
  String woodenFishSound;

  factory LocalSetting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
