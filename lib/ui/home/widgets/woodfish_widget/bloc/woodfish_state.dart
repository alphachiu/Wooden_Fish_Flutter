import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';

class WoodFishWidgetState {
  late int totalCount;
  late int currentCount;
  late List<Widget> knockAnimationWidgets;
  late bool isAuto;
  late LocalSetting setting;
  late AutoKnockSetting autoKnockSetting;
  late int currentLimit;

  WoodFishWidgetState init() {
    return WoodFishWidgetState()
      ..totalCount = 0
      ..currentCount = 0
      ..currentLimit = 0
      ..knockAnimationWidgets = []
      ..isAuto = false
      ..setting = LocalSetting()
      ..autoKnockSetting = AutoKnockSetting();
  }

  WoodFishWidgetState clone() {
    return WoodFishWidgetState()
      ..totalCount = totalCount
      ..currentCount = currentCount
      ..currentLimit = currentLimit
      ..knockAnimationWidgets = knockAnimationWidgets
      ..isAuto = isAuto
      ..setting = setting
      ..autoKnockSetting = autoKnockSetting;
  }
}
