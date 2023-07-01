import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';

class WoodfishWidgetState {
  late int totalCount;
  late int currentCount;
  late List<Widget> knockAnimationWidgets;
  late bool isAuto;
  late LocalSetting setting;
  late AutoKnockSetting autoKnockSetting;

  WoodfishWidgetState init() {
    return WoodfishWidgetState()
      ..totalCount = 0
      ..currentCount = 0
      ..knockAnimationWidgets = []
      ..isAuto = false
      ..setting = LocalSetting()
      ..autoKnockSetting = AutoKnockSetting();
  }

  WoodfishWidgetState clone() {
    return WoodfishWidgetState()
      ..totalCount = totalCount
      ..currentCount = currentCount
      ..knockAnimationWidgets = knockAnimationWidgets
      ..isAuto = isAuto
      ..setting = setting
      ..autoKnockSetting = autoKnockSetting;
  }
}
