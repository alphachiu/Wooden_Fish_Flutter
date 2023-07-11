import 'package:bloc/bloc.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/bloc/person_info_event.dart';

import 'person_info_state.dart';

class PersonInfoBloc extends Bloc<PersonInfoEvent, PersonInfoState> {
  PersonInfoBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(PersonInfoState().init()) {
    on<PersonInfoInitEvent>(_init);
    on<SelectBgEvent>(_selectBg);
  }
  final WoodenRepository _woodenRepository;

  void _init(PersonInfoInitEvent event, Emitter<PersonInfoState> emit) async {
    state.setting = _woodenRepository.getSetting();

    state.currentBg =
        _woodenRepository.getBgElementFromString(state.setting.woodenFishBg) ??
            BgElement.none;

    emit(state.clone());
  }

  void _selectBg(SelectBgEvent event, Emitter<PersonInfoState> emit) async {
    print('event.currentBg = ${event.currentBg.toString()}');
    state.setting.woodenFishBg = event.currentBg.toString();
    _woodenRepository.saveSetting(state.setting);

    state.currentBg = event.currentBg;

    emit(state.clone());
  }
}
