abstract class Setting_widgetEvent {}

class InitEvent extends Setting_widgetEvent {}

class SwitchShowWordEvent extends Setting_widgetEvent {
  SwitchShowWordEvent({required this.switchDisplay});

    bool switchDisplay;
}
class SwitchVibrationEvent extends Setting_widgetEvent {
  SwitchVibrationEvent({required this.switchVibration});
  final bool switchVibration;

}