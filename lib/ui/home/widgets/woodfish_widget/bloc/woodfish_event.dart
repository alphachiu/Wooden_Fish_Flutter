abstract class WoodfishWidgetEvent {}

class InitEvent extends WoodfishWidgetEvent {}

class IncrementEvent extends WoodfishWidgetEvent {}

class IsAutoEvent extends WoodfishWidgetEvent {
  IsAutoEvent({required this.isAuto});

  final bool isAuto;
}

class IsDisplayEvent extends WoodfishWidgetEvent {
  IsDisplayEvent({required this.isDisplay});

  final bool isDisplay;
}
