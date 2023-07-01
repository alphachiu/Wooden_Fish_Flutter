import 'package:bloc/bloc.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';

import 'setting_event.dart';
import 'setting_state.dart';

class SettingWidgetBloc extends Bloc<SettingWidgetEvent, SettingWidgetState> {
  SettingWidgetBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(SettingWidgetState().init()) {
    on<InitEvent>(_init);
    on<SwitchShowWordEvent>(_switchDisplay);
    on<SwitchVibrationEvent>(_switchVibration);
    on<ChangeDisplayWordEvent>(_changeDisplayWord);
  }

  final WoodenRepository _woodenRepository;

  void _init(InitEvent event, Emitter<SettingWidgetState> emit) async {
    state.setting = _woodenRepository.getSetting();
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

  void _changeDisplayWord(
      ChangeDisplayWordEvent event, Emitter<SettingWidgetState> emit) async {
    state.setting.displayWord = event.displayWord;
    await _woodenRepository.saveSetting(state.setting);
    emit(state.clone());
  }
}
