

import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';

class BottomTabBarState {
  late AutoStop currentType;
  late bool isHiddenTip;
  late int limitCount;
  late int limitCountDown;
  late int currentCount;
  late AutoKnockSetting autoKnockSetting;


  BottomTabBarState init() {
    return BottomTabBarState()
      ..currentType = AutoStop.count
      ..isHiddenTip = false
      ..limitCount = 0
      ..limitCountDown = 0
      ..currentCount = 0
      ..autoKnockSetting = AutoKnockSetting()
    ;
  }

  BottomTabBarState clone() {
    return BottomTabBarState()
      ..currentType = currentType
      ..isHiddenTip = isHiddenTip
      ..limitCount = limitCount
      ..limitCountDown = limitCountDown
      ..currentCount = currentCount
      ..autoKnockSetting = autoKnockSetting
    ;
  }
}
