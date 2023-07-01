import 'package:bloc/bloc.dart';
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
    on<ChangeAutoStopSegmentedEvent>(_changeAutoStopSegmented);
    on<ChangeCountDownSegmentedEvent>(_changeCountDownSegmented);
  }

  final WoodenRepository _woodenRepository;

  void _init(InitEvent event, Emitter<AutoSettingState> emit) async {
    state.setting = _woodenRepository.getSetting();
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

    emit(state.clone());
  }

  void _changeAutoStopSegmented(ChangeAutoStopSegmentedEvent event,
      Emitter<AutoSettingState> emit) async {
    state.autoStopCurrentIndex = event.isChange;

    emit(state.clone());
  }

  void _changeCountDownSegmented(ChangeCountDownSegmentedEvent event,
      Emitter<AutoSettingState> emit) async {
    state.countDownCurrentIndex = event.isChange;

    emit(state.clone());
  }
}
