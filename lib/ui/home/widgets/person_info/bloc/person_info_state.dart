import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

class PersonInfoState {
  late List<GroupThemeListModel> sections;
  late LocalSetting setting;
  late WoodenFishBgElement currentBg;
  late WoodenFishSkinElement currentSkin;
  late WoodenFishSoundElement currentSound;

  PersonInfoState init() {
    List<ElementModel<WoodenFishSkinElement, Image>> skinList = [];
    List<ElementModel<WoodenFishBgElement, Color>> bgList = [];
    List<ElementModel<WoodenFishSoundElement, String>> soundList = [];

    for (var skinElement in WoodenFishSkinElement.values) {
      var image = WoodenFishUtil.internal()
          .getSkinImageFromString(skinElement.toString());
      skinList.add(ElementModel(
        name: skinElement,
        element: image,
      ));
    }

    for (var bgElement in WoodenFishBgElement.values) {
      var color =
          WoodenFishUtil.internal().getColorFromString(bgElement.toString());
      bgList.add(ElementModel(
        name: bgElement,
        element: color,
      ));
    }
    for (var soundElement in WoodenFishSoundElement.values) {
      var soundName = WoodenFishUtil.internal()
          .getSoundNameFromString(soundElement.toString());
      soundList.add(ElementModel(name: soundElement, element: soundName));
    }

    return PersonInfoState()
      ..sections = [
        GroupThemeListModel(
            name: '木魚外觀',
            position: SettingPosition.none,
            group: '木魚外觀',
            elementList: skinList),
        GroupThemeListModel(
            name: '放入祈禱照', position: SettingPosition.none, group: '背景設置'),
        GroupThemeListModel(
            elementList: bgList,
            name: '背景設置',
            position: SettingPosition.none,
            group: '背景設置'),
        GroupThemeListModel(
            elementList: soundList,
            name: '聲音設置',
            position: SettingPosition.none,
            group: '聲音設置'),
      ]
      ..setting = LocalSetting()
      ..currentBg = WoodenFishBgElement.none
      ..currentSkin = WoodenFishSkinElement.wood
      ..currentSound = WoodenFishSoundElement.sound01;
  }

  PersonInfoState clone() {
    return PersonInfoState()
      ..setting = setting
      ..sections = sections
      ..currentBg = currentBg
      ..currentSkin = currentSkin
      ..currentSound = currentSound;
  }
}
