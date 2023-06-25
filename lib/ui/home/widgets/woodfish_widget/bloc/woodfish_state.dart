import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/setting.dart';

class Woodfish_widgetState {
  late int totalCount;
  late List<Widget> knockAnimationWidgets;
  late bool isAuto;
  late Setting setting;

  Woodfish_widgetState init() {
    return Woodfish_widgetState()
      ..totalCount = 0
      ..knockAnimationWidgets = []
      ..isAuto = false
      ..setting = Setting();
    ;

  }

  Woodfish_widgetState clone() {

    return Woodfish_widgetState()
      ..totalCount = totalCount
      ..knockAnimationWidgets = knockAnimationWidgets
      ..isAuto = isAuto

    ;
  }
}
