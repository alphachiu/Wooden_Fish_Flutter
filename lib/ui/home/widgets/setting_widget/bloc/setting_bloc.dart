import 'package:bloc/bloc.dart';

import 'setting_event.dart';
import 'setting_state.dart';

class Setting_widgetBloc
    extends Bloc<Setting_widgetEvent, Setting_widgetState> {
  Setting_widgetBloc() : super(Setting_widgetState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<Setting_widgetState> emit) async {
    emit(state.clone());
  }
}
