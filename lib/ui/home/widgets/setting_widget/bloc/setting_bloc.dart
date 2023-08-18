import 'package:another_stepper/dto/stepper_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

import '../../../../../repository/ads_repository.dart';
import 'setting_event.dart';
import 'setting_state.dart';

class SettingWidgetBloc extends Bloc<SettingWidgetEvent, SettingWidgetState> {
  SettingWidgetBloc(
      {required WoodenRepository woodenRepository,
      required AdsRepository adsRepository})
      : _woodenRepository = woodenRepository,
        _adsRepository = adsRepository,
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
  final AdsRepository _adsRepository;

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

    state.nativeAd = await _adsRepository.getNativeAd();
    state.nativeAdIsLoaded = false;
    emit(state.clone());
  }

  void _switchDisplay(
      SwitchShowWordEvent event, Emitter<SettingWidgetState> emit) async {
    print('event.switchDisplay = ${event.switchDisplay}');
    state.setting.isDisplayPrayWord = event.switchDisplay;
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
    // var level = WoodenFishUtil.internal()
    //     .getLevelElementFromKnockCount(BigInt.from(state.setting.totalCount))
    //     .toString();
    state.isDisplayLevelList = true;
    state.currentStepperInt =
        int.parse(state.setting.level.split("lv")[1].padLeft(1, '2'));

    state.stepperData = [];

    for (WoodenFishLevelElement element in WoodenFishLevelElement.values) {
      var name = WoodenFishUtil.internal()
          .getLevelNameElementFromString(element.toString());
      var lvInt = int.parse(element.toString().split("lv")[1].padLeft(1, '2'));

      Color? currentTextColor = (state.levelName != name)
          ? (state.currentStepperInt < lvInt)
              ? Colors.grey
              : Colors.black
          : Colors.black;

      Color? currentIconColor = (state.currentStepperInt >= lvInt)
          ? const Color(0xff37CACF)
          : Colors.grey;

      Color? subTitleTextColor =
          (lvInt < state.currentStepperInt) ? Colors.grey : Colors.red;

      var currentLevelText = (state.levelName != name)
          ? (state.currentStepperInt > lvInt)
              ? "已達到修行"
              : ""
          : lvInt == 50
              ? "已達到最高境界"
              : "目前還在修行中...";

      var data = StepperData(
          title: StepperText(
            name,
            textStyle: TextStyle(
              color: currentTextColor,
            ),
          ),
          subtitle: StepperText(
            currentLevelText,
            textStyle: TextStyle(
              color: subTitleTextColor,
            ),
          ),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: currentIconColor,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(
              Icons.radio_button_checked_sharp,
              color: Colors.white,
            ),
          ));

      state.stepperData.add(data);
    }

    emit(state.clone());
  }
}
