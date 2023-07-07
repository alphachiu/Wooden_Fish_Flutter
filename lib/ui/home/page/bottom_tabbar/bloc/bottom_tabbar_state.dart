import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';

class BottomTabBarState {
  late AutoStop currentAutoStopType;
  late bool isHiddenTip;
  late int limitCount;
  late AutoStopTime newCountDownType;
  late AutoStopTime oldCountDownType;
  late String countDownStr;
  late int countDownSecond;
  late int currentCount;
  late AutoKnockSetting autoKnockSetting;

  BottomTabBarState init() {
    return BottomTabBarState()
      ..currentAutoStopType = AutoStop.count
      ..isHiddenTip = false
      ..limitCount = 0
      ..currentCount = 0
      ..newCountDownType = AutoStopTime.none
      ..oldCountDownType = AutoStopTime.none
      ..countDownStr = "00:00:00"
      ..countDownSecond = 0
      ..autoKnockSetting = AutoKnockSetting();
  }

  BottomTabBarState clone() {
    return BottomTabBarState()
      ..currentAutoStopType = currentAutoStopType
      ..isHiddenTip = isHiddenTip
      ..limitCount = limitCount
      ..countDownStr = countDownStr
      ..countDownSecond = countDownSecond
      ..newCountDownType = newCountDownType
      ..oldCountDownType = oldCountDownType
      ..currentCount = currentCount
      ..autoKnockSetting = autoKnockSetting;
  }
}
