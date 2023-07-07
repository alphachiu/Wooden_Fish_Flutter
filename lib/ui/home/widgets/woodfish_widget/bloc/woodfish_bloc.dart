import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_event.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/knock_text_widget.dart';
import 'package:woodenfish_bloc/utils/AudioPlayUtil.dart';
import 'woodfish_event.dart';
import 'woodfish_state.dart';

class WoodFishWidgetBloc
    extends Bloc<WoodFishWidgetEvent, WoodFishWidgetState> {
  WoodFishWidgetBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(WoodFishWidgetState().init()) {
    on<InitEvent>(_init);
    on<IncrementEvent>(_increment);
    on<IsAutoEvent>(_isAutoEvent);
  }

  final WoodenRepository _woodenRepository;
  final List<Widget> _knockAnimationWidgets = [];
  late Timer autoKnockTimer;

  void _init(InitEvent event, Emitter<WoodFishWidgetState> emit) async {
    state.setting = _woodenRepository.getSetting();
    emit(state.clone());
  }

  void _increment(
      IncrementEvent event, Emitter<WoodFishWidgetState> emit) async {
    //get autoKnockSettingInfo
    var autoKnockSetting = _woodenRepository.getAutoKnockSettingInfo();
    print('is open auto stop = ${autoKnockSetting.isAutoStop}');
    print('autoKnockSetting.type = ${autoKnockSetting.autoStopType}');
    print('autoKnockSetting.limitCount = ${autoKnockSetting.limitCount}');
    print('autoKnockSetting.currentCount = ${autoKnockSetting.currentCount}');

    // AutoStop.count
    if (autoKnockSetting.isAutoStop &&
        autoKnockSetting.autoStopType == AutoStop.count &&
        autoKnockSetting.limitCount != state.currentLimit) {
      state.currentLimit = autoKnockSetting.limitCount;
      state.currentCount = 0;
    }

    //check return condition
    if ((autoKnockSetting.isAutoStop &&
            autoKnockSetting.autoStopType == AutoStop.count &&
            autoKnockSetting.limitCount == autoKnockSetting.currentCount) ||
        (autoKnockSetting.isAutoStop &&
            autoKnockSetting.autoStopType == AutoStop.countDown &&
            autoKnockSetting.countDownSecond == 0)) {
      print('meet a condition');
      return;
    }

    state.totalCount++;
    state.currentCount++;

    //save autoKnockSettingInfo
    state.autoKnockSetting = autoKnockSetting;
    state.autoKnockSetting.currentCount = state.currentCount;
    print('state.autoKnockSetting.currentCount = ${state.currentCount}');
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);

    //get setting
    state.setting = _woodenRepository.getSetting();

    //check Vibration
    if (state.setting.isVibration) {
      await HapticFeedback.vibrate();
    }

    //check Display
    if (state.setting.isDisplay) {
      AudioPlayUtil().play('sounds/woodenFish_01.wav');

      KnockTextWidget knockWidget = KnockTextWidget(
          childWidget: Text(
            state.setting.displayWord,
            style: const TextStyle(fontSize: 24.0),
          ),
          onRemove: (widget) async {
            await _removeWidget(widget);
          });

      _knockAnimationWidgets.add(Stack(
        children: [knockWidget],
      ));
      state.knockAnimationWidgets = _knockAnimationWidgets;
    }

    if ((state.autoKnockSetting.isAutoStop &&
        state.autoKnockSetting.autoStopType == AutoStop.count &&
        state.autoKnockSetting.currentCount <=
            state.autoKnockSetting.limitCount)) {
      print('state.currentCount = ${state.currentCount}');
      event.btTabBar.add(CurrentCountEvent(count: state.currentCount));
    }

    emit(state.clone());
  }

  void _isAutoEvent(IsAutoEvent event, Emitter<WoodFishWidgetState> emit) {
    state.isAuto = event.isAuto;

    emit(state.clone());
  }

  Future<void> _removeWidget(KnockTextWidget widget) async {
    if (widget.onRemove != null) {
      print('_removeWidget');
      _knockAnimationWidgets.remove(widget);
      state.knockAnimationWidgets = _knockAnimationWidgets;
    }
  }
}
