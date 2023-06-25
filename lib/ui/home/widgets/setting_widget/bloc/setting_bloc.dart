import 'package:bloc/bloc.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';

import 'setting_event.dart';
import 'setting_state.dart';

class Setting_widgetBloc
    extends Bloc<Setting_widgetEvent, Setting_widgetState> {

  Setting_widgetBloc({required  WoodenRepository woodenRepository}) :
        _woodenRepository = woodenRepository, super(Setting_widgetState().init()) {
    on<InitEvent>(_init);
    on<SwitchShowWordEvent>(_switchDisplay);
    on<SwitchVibrationEvent>(_switchVibration);
  }

  final WoodenRepository _woodenRepository;

  void _init(InitEvent event, Emitter<Setting_widgetState> emit) async {
    state.setting = _woodenRepository.getSetting();
    emit(state.clone());
  }

  void _switchDisplay(SwitchShowWordEvent event, Emitter<Setting_widgetState> emit) async {
       print('event.switchDisplay = ${event.switchDisplay}');
       state.setting.isDisplay = event.switchDisplay;
       await _woodenRepository.saveSetting(state.setting);
       emit(state.clone());
  }
  void _switchVibration(SwitchVibrationEvent event, Emitter<Setting_widgetState> emit) async {
    print('event.switchVibration = ${event.switchVibration}');
    state.setting.isVibration = event.switchVibration;
    await _woodenRepository.saveSetting(state.setting);
    emit(state.clone());
  }
}
