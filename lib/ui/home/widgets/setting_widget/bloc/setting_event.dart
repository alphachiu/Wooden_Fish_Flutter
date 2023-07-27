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

class EditeDisplayWordEvent extends SettingWidgetEvent {
  EditeDisplayWordEvent({required this.displayWord});
  final String displayWord;
}

class EditeNameEvent extends SettingWidgetEvent {
  EditeNameEvent({required this.name});
  final String name;
}

class SavePersonAvatarEvent extends SettingWidgetEvent {}
