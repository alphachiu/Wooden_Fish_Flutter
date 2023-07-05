import 'package:bloc/bloc.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/widgets/auto_setting/bloc/auto_setting_state.dart';

import 'auto_setting_event.dart';

class AutoSettingBloc extends Bloc<AutoSettingEvent, AutoSettingState> {
  AutoSettingBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(AutoSettingState().init()) {
    on<InitEvent>(_init);
    on<SliderProgressEvent>(_sliderProgress);
    on<SwitchAutoStopEvent>(_switchAutoStop);
    on<ChangeAutoStopTypeEvent>(_changeAutoStopType);
    on<ChangeCountDownTypeEvent>(_changeCountDownType);
  }

  final WoodenRepository _woodenRepository;

  void _init(InitEvent event, Emitter<AutoSettingState> emit) async {
    state.setting = _woodenRepository.getSetting();
    state.isAutoStop = _woodenRepository.getAutoKnockSettingInfo().isAutoStop;
    state.autoStopType = _woodenRepository.getAutoKnockSettingInfo().type;

    emit(state.clone());
  }

  void _sliderProgress(
      SliderProgressEvent event, Emitter<AutoSettingState> emit) async {
    state.setting.autoSpeed = event.progress;
    await _woodenRepository.saveSetting(state.setting);
    emit(state.clone());
  }

  void _switchAutoStop(
      SwitchAutoStopEvent event, Emitter<AutoSettingState> emit) async {
    state.isAutoStop = event.isChange;
    state.autoKnockSetting.isAutoStop = event.isChange;
    emit(state.clone());
  }

  void _changeAutoStopType(ChangeAutoStopTypeEvent event,
      Emitter<AutoSettingState> emit) async {
    state.autoStopType = event.isChange;
    state.autoKnockSetting.type = event.isChange;
    print('_changeAutoStopType event.isChange = ${event.isChange}');
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);
    emit(state.clone());
  }

  void _changeCountDownType(ChangeCountDownTypeEvent event,
      Emitter<AutoSettingState> emit) async {
    state.countDownType = event.isChange;

    emit(state.clone());
  }
}
