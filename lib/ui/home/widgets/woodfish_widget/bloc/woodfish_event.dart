abstract class Woodfish_widgetEvent {}

class InitEvent extends Woodfish_widgetEvent {}

class IncrementEvent extends Woodfish_widgetEvent {}

class IsAutoEvent extends Woodfish_widgetEvent {
  IsAutoEvent({required this.isAuto});

  final bool isAuto;
}
