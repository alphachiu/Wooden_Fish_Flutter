import 'package:flutter/cupertino.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

abstract class PersonInfoEvent {}

class PersonInfoInitEvent extends PersonInfoEvent {}

class SelectBgEvent extends PersonInfoEvent {
  SelectBgEvent({required this.currentBg});

  final WoodenFishBgElement currentBg;
}

class SelectSkinEvent extends PersonInfoEvent {
  SelectSkinEvent({required this.currentSkin});

  final WoodenFishSkinElement currentSkin;
}

class SelectSoundEvent extends PersonInfoEvent {
  SelectSoundEvent({required this.currentSound});

  final WoodenFishSoundElement currentSound;
}

class SwitchPrayEvent extends PersonInfoEvent {
  SwitchPrayEvent({required this.switchPray});

  final bool switchPray;
}
