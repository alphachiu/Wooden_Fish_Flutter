import 'package:flutter/material.dart';

class Woodfish_widgetState {
  late int totalCount;
  late List<Widget> knockAnimationWidgets;

  Woodfish_widgetState init() {
    return Woodfish_widgetState()
      ..totalCount = 0
      ..knockAnimationWidgets = [];

    ;
  }

  Woodfish_widgetState clone() {
    return Woodfish_widgetState()
      ..totalCount = totalCount
      ..knockAnimationWidgets = knockAnimationWidgets;
  }
}
