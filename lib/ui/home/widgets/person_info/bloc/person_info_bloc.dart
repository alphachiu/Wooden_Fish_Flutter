import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/bloc/person_info_event.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

import 'person_info_state.dart';

class PersonInfoBloc extends Bloc<PersonInfoEvent, PersonInfoState> {
  PersonInfoBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(PersonInfoState().init()) {
    on<PersonInfoInitEvent>(_init);
    on<SelectBgEvent>(_selectBg);
    on<SelectSkinEvent>(_selectSkin);
    on<SelectSoundEvent>(_selectSound);

    on<SwitchPrayEvent>(_switchPray);
  }
  final WoodenRepository _woodenRepository;

  void _init(PersonInfoInitEvent event, Emitter<PersonInfoState> emit) async {
    state.setting = _woodenRepository.getSetting();

    state.currentBg = WoodenFishUtil.internal()
            .getBgElementFromString(state.setting.woodenFishBg) ??
        WoodenFishBgElement.none;
    state.currentSkin = WoodenFishUtil.internal()
            .getSkinElementFromString(state.setting.woodenFishSkin) ??
        WoodenFishSkinElement.wood;
    state.currentSound = WoodenFishUtil.internal()
            .getSoundElementFromString(state.setting.woodenFishSound) ??
        WoodenFishSoundElement.sound01;

    emit(state.clone());
  }

  void _selectBg(SelectBgEvent event, Emitter<PersonInfoState> emit) async {
    print('event.currentBg = ${event.currentBg.toString()}');
    state.setting.woodenFishBg = event.currentBg.toString();
    _woodenRepository.saveSetting(state.setting);

    state.currentBg = event.currentBg;

    emit(state.clone());
  }

  void _selectSkin(SelectSkinEvent event, Emitter<PersonInfoState> emit) async {
    print('event.currentSkin = ${event.currentSkin.toString()}');
    state.setting.woodenFishSkin = event.currentSkin.toString();
    _woodenRepository.saveSetting(state.setting);

    state.currentSkin = event.currentSkin;

    emit(state.clone());
  }

  void _selectSound(
      SelectSoundEvent event, Emitter<PersonInfoState> emit) async {
    print('event.currentSound = ${event.currentSound.toString()}');
    state.setting.woodenFishSound = event.currentSound.toString();
    _woodenRepository.saveSetting(state.setting);

    state.currentSound = event.currentSound;

    emit(state.clone());
  }

  void _switchPray(SwitchPrayEvent event, Emitter<PersonInfoState> emit) async {
    state.setting.isSetPrayPhoto = event.switchPray;
    _woodenRepository.saveSetting(state.setting);
    emit(state.clone());
  }
}
