abstract class SettingWidgetEvent {}

class InitEvent extends SettingWidgetEvent {}

class SwitchShowWordEvent extends SettingWidgetEvent {
  SwitchShowWordEvent({required this.switchDisplay});

  bool switchDisplay;
}

class SwitchVibrationEvent extends SettingWidgetEvent {
  SwitchVibrationEvent({required this.switchVibration});
  final bool switchVibration;
}

class ChangeDisplayWordEvent extends SettingWidgetEvent {
  ChangeDisplayWordEvent({required this.displayWord});
  final String displayWord;
}