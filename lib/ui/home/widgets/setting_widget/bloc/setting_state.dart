import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

class SettingWidgetState {
  late List<GroupListModel> sections;
  late LocalSetting setting;
  late String levelName;
  late Image? avatarPhoto;
  late PhotoLoadStatus photoLoadingStatus;
  late String version;
  late List<StepperData> stepperData;
  late int currentStepperInt;

  SettingWidgetState init() {
    return SettingWidgetState()
      ..sections = [
        GroupListModel(
            name: '佈景設置', position: SettingPosition.none, group: '佈景設置'),
        GroupListModel(
            name: '變更祈福文', position: SettingPosition.none, group: '祈福文字'),
        GroupListModel(
            name: '自動敲擊設置', position: SettingPosition.none, group: '播放模式'),
        GroupListModel(
            name: '顯示祈福文', position: SettingPosition.head, group: '其他設置'),
        GroupListModel(
            name: '震動', position: SettingPosition.end, group: '其他設置'),
      ]
      ..setting = LocalSetting()
      ..levelName = ""
      ..avatarPhoto =
          const Image(image: AssetImage('assets/images/user_Icon.png'))
      ..photoLoadingStatus = PhotoLoadStatus.init
      ..version = ''
      ..stepperData = []
      ..currentStepperInt = 0;
  }

  SettingWidgetState clone() {
    return SettingWidgetState()
      ..sections = sections
      ..setting = setting
      ..levelName = levelName
      ..avatarPhoto = avatarPhoto
      ..photoLoadingStatus = photoLoadingStatus
      ..version = version
      ..stepperData = stepperData
      ..currentStepperInt = currentStepperInt;
  }
}
