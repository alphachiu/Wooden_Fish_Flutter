import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_bloc.dart';

abstract class WoodFishWidgetEvent {}

class InitEvent extends WoodFishWidgetEvent {}

class IncrementEvent extends WoodFishWidgetEvent {
  IncrementEvent({required this.btTabBar});
  final BottomTabBarBloc btTabBar;
}

class IsAutoEvent extends WoodFishWidgetEvent {
  IsAutoEvent({required this.isAuto});

  final bool isAuto;
}

class IsDisplayEvent extends WoodFishWidgetEvent {
  IsDisplayEvent({required this.isDisplay});

  final bool isDisplay;
}
