import 'package:flutter/cupertino.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

abstract class PersonInfoEvent {}

class PersonInfoInitEvent extends PersonInfoEvent {}

class SelectBgEvent extends PersonInfoEvent {
  SelectBgEvent({required this.currentBg});

  final BgElement currentBg;
}
