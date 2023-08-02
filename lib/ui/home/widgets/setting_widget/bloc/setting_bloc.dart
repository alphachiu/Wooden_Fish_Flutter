import 'package:another_stepper/dto/stepper_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

import 'setting_event.dart';
import 'setting_state.dart';

class SettingWidgetBloc extends Bloc<SettingWidgetEvent, SettingWidgetState> {
  SettingWidgetBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(SettingWidgetState().init()) {
    on<InitEvent>(_init);
    on<SwitchShowWordEvent>(_switchDisplay);
    on<SwitchVibrationEvent>(_switchVibration);
    on<EditeDisplayWordEvent>(_editeDisplayWord);
    on<SavePersonAvatarEvent>(_savePersonAvatar);
    on<EditeNameEvent>(_editeName);
    on<ReviewLevelStepperEvent>(_reviewLevelStepper);
  }

  final WoodenRepository _woodenRepository;

  void _init(InitEvent event, Emitter<SettingWidgetState> emit) async {
    state.setting = _woodenRepository.getSetting();
    state.levelName = WoodenFishUtil.internal()
        .getLevelNameElementFromString(state.setting.level);

    var avatarPhoto =
        await WoodenFishUtil.internal().getAvatarImage('avatar.png');
    if (avatarPhoto != null) {
      state.avatarPhoto = avatarPhoto;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    state.version = packageInfo.version;

    emit(state.clone());
  }

  void _switchDisplay(
      SwitchShowWordEvent event, Emitter<SettingWidgetState> emit) async {
    print('event.switchDisplay = ${event.switchDisplay}');
    state.setting.isDisplay = event.switchDisplay;
    await _woodenRepository.saveSetting(state.setting);
    emit(state.clone());
  }

  void _switchVibration(
      SwitchVibrationEvent event, Emitter<SettingWidgetState> emit) async {
    print('event.switchVibration = ${event.switchVibration}');
    state.setting.isVibration = event.switchVibration;
    await _woodenRepository.saveSetting(state.setting);
    emit(state.clone());
  }

  void _editeDisplayWord(
      EditeDisplayWordEvent event, Emitter<SettingWidgetState> emit) async {
    state.setting.displayWord = event.displayWord;
    await _woodenRepository.saveSetting(state.setting);
    emit(state.clone());
  }

  void _editeName(
      EditeNameEvent event, Emitter<SettingWidgetState> emit) async {
    if (event.name.isEmpty) {
      state.setting.userName = '靜心小僧';
    } else {
      state.setting.userName = event.name;
    }

    await _woodenRepository.saveSetting(state.setting);
    emit(state.clone());
  }

  void _savePersonAvatar(
      SavePersonAvatarEvent event, Emitter<SettingWidgetState> emit) async {
    state.photoLoadingStatus = PhotoLoadStatus.loading;
    emit(state.clone());
    var avatarPhoto =
        await WoodenFishUtil.internal().saveAvatarPhoto('avatar.png');

    if (avatarPhoto == null) {
      state.photoLoadingStatus = PhotoLoadStatus.fail;
    } else {
      state.photoLoadingStatus = PhotoLoadStatus.finish;
      state.avatarPhoto = avatarPhoto;
    }
    emit(state.clone());
  }

  void _reviewLevelStepper(
      ReviewLevelStepperEvent event, Emitter<SettingWidgetState> emit) async {
    var level = WoodenFishUtil.internal()
        .getLevelElementFromKnockCount(BigInt.from(state.setting.totalCount))
        .toString();

    state.currentStepperInt = int.parse(level.split("lv")[1].padLeft(1, '2'));
    print('currentStepper = ${state.currentStepperInt}');

    state.stepperData = [];

    for (WoodenFishLevelElement element in WoodenFishLevelElement.values) {
      var name = WoodenFishUtil.internal()
          .getLevelNameElementFromString(element.toString());
      print('state.levelName = ${state.levelName}');
      Color? currentTextColor =
          (state.levelName != name) ? Colors.grey : Colors.black;
      Color? currentIconColor =
          (state.levelName != name) ? Colors.grey : Colors.green;
      var currentLevelText = (state.levelName != name) ? "" : "修行已到達";

      var data = StepperData(
          title: StepperText(
            name,
            textStyle: TextStyle(
              color: currentTextColor,
            ),
          ),
          subtitle: StepperText(currentLevelText),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: currentIconColor,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
          ));

      state.stepperData.add(data);
    }

    emit(state.clone());
  }
}
