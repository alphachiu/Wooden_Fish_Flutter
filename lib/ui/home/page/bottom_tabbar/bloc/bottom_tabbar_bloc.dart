import 'package:bloc/bloc.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';

import 'bottom_tabbar_event.dart';
import 'bottom_tabbar_state.dart';

class BottomTabBarBloc extends Bloc<BottomTabBarEvent, BottomTabBarState> {
  BottomTabBarBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(BottomTabBarState().init()) {
    on<BTInitEvent>(_init);
    on<TipEvent>(_tipView);
    on<ChangeTypeEvent>(_changeAutoStopType);
    on<InputLimitCountEvent>(_limitCount);
    on<SetCountDownEvent>(_setCountDown);
    on<CurrentCountEvent>(_currentCount);
    on<CountDownEvent>(_countDown);
  }
  final WoodenRepository _woodenRepository;

  void _init(BTInitEvent event, Emitter<BottomTabBarState> emit) async {
    state.autoKnockSetting = _woodenRepository.getAutoKnockSettingInfo();

    emit(state.clone());
  }

  void _tipView(TipEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting = _woodenRepository.getAutoKnockSettingInfo();

    if (!event.isChange) {
      state.currentAutoStopType = AutoStop.count;
    }

    state.isHiddenTip = event.isChange;
    emit(state.clone());
  }

  void _changeAutoStopType(
      ChangeTypeEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting = _woodenRepository.getAutoKnockSettingInfo();
    state.currentAutoStopType = event.change;

    //init
    if (state.currentAutoStopType == AutoStop.countDown) {
      var defaultSecond = 0;
      state.autoKnockSetting.countDownSecond = defaultSecond;
      _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);
      state.newCountDownType = AutoStopTime.none;
      state.oldCountDownType = AutoStopTime.none;
      state.countDownSecond = defaultSecond;
      state.countDownStr = countDownTime(defaultSecond);
    }
    emit(state.clone());
  }

  void _limitCount(
      InputLimitCountEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting.limitCount = event.limitCount;
    state.autoKnockSetting.currentKnockCount = 0;
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);
    state.currentCount = 0;
    state.limitCount = event.limitCount;
    emit(state.clone());
  }

  void _currentCount(
      CurrentCountEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting.currentKnockCount = event.count;
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);

    state.currentCount = event.count;
    emit(state.clone());
  }

  void _setCountDown(
      SetCountDownEvent event, Emitter<BottomTabBarState> emit) async {
    var second = 0;
    switch (event.timeType) {
      case AutoStopTime.none:
        second = 0;
        state.oldCountDownType = event.timeType;
        break;
      case AutoStopTime.five:
        second = 5 * 60;
        //second = 5;
        break;
      case AutoStopTime.ten:
        second = 10 * 60;
        break;
      case AutoStopTime.fifteen:
        second = 15 * 60;
        break;
      case AutoStopTime.thirty:
        second = 30 * 60;
        break;
      case AutoStopTime.sixty:
        second = 60 * 60;
        break;
    }
    //save autoKnock state
    state.autoKnockSetting.autoStopTimeType = event.timeType;
    state.autoKnockSetting.countDownSecond = second;
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);
    state.newCountDownType = event.timeType;
    state.countDownSecond = second;
    state.countDownStr = countDownTime(second);

    emit(state.clone());
  }

  void _countDown(CountDownEvent event, Emitter<BottomTabBarState> emit) async {
    if (state.oldCountDownType != state.newCountDownType) {
      state.oldCountDownType = state.newCountDownType;
    }
    state.countDownSecond--;
    state.autoKnockSetting.countDownSecond = state.countDownSecond;
    state.countDownStr = countDownTime(state.countDownSecond);
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);
    emit(state.clone());
  }

  String countDownTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return "${formatTime(hour)} : ${formatTime(minute)} : ${formatTime(second)}";
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0$timeNum" : timeNum.toString();
  }
}
