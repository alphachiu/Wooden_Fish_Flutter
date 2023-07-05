import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';

abstract class AutoSettingEvent {}

class InitEvent extends AutoSettingEvent {}

class SliderProgressEvent extends AutoSettingEvent {
  SliderProgressEvent({required this.progress});

  final double progress;
}

class SwitchAutoStopEvent extends AutoSettingEvent {
  SwitchAutoStopEvent({required this.isChange});
  final bool isChange;
}

class ChangeAutoStopTypeEvent extends AutoSettingEvent {
  ChangeAutoStopTypeEvent({required this.isChange});
  final AutoStop isChange;
}
class ChangeCountDownTypeEvent extends AutoSettingEvent {
  ChangeCountDownTypeEvent({required this.isChange});
  final String isChange;
}