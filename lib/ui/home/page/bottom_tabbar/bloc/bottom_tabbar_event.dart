import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_state.dart';

abstract class BottomTabBarEvent {}

class BTInitEvent extends BottomTabBarEvent {}

class SetCountDownEvent extends BottomTabBarEvent {
  SetCountDownEvent({required this.timeType});
  final AutoStopTime timeType;
}

class CountDownEvent extends BottomTabBarEvent {
  CountDownEvent();

}

class InputLimitCountEvent extends BottomTabBarEvent {
  InputLimitCountEvent({required this.limitCount});
  final int limitCount;
}

class CurrentCountEvent extends BottomTabBarEvent {
  CurrentCountEvent({required this.count});
  final int count;
}

class ChangeTypeEvent extends BottomTabBarEvent {
  ChangeTypeEvent({required this.change});
  final AutoStop change;
}

// open or hidden a TipView
class TipEvent extends BottomTabBarEvent {
  TipEvent({required this.isChange});
  final bool isChange;
}
