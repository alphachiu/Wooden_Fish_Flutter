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

class ChangeAutoStopSegmentedEvent extends AutoSettingEvent {
  ChangeAutoStopSegmentedEvent({required this.isChange});
  final String isChange;
}
class ChangeCountDownSegmentedEvent extends AutoSettingEvent {
  ChangeCountDownSegmentedEvent({required this.isChange});
  final String isChange;
}