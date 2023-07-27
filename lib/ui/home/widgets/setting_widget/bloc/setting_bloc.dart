import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

import 'setting_event.dart';
import 'setting_state.dart';

class SettingWidgetBloc extends Bloc<SettingWidgetEvent, SettingWidgetState> {
  SettingWidgetBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(SettingWidgetState().init()) {
    on<InitEvent>(_init);
    on<SwitchShowWordEvent>(_switchDisplay);
    on<SwitchVibrationEvent>(_switchVibration);
    on<EditeDisplayWordEvent>(_editeDisplayWord);
    on<SavePersonAvatarEvent>(_savePersonAvatar);
    on<EditeNameEvent>(_editeName);
  }

  final WoodenRepository _woodenRepository;

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
}
