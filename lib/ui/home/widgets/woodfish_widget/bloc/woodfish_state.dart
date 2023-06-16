import 'package:flutter/material.dart';

class Woodfish_widgetState {
  late int totalCount;
  late List<Widget> textAnimationWidgets;

  Woodfish_widgetState init() {
    return Woodfish_widgetState()
      ..totalCount = 0
      ..textAnimationWidgets = [];

    ;
  }

  Woodfish_widgetState clone() {
    return Woodfish_widgetState()
      ..totalCount = totalCount
      ..textAnimationWidgets = textAnimationWidgets;
  }
}
