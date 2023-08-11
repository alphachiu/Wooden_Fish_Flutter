import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_event.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/knock_text_widget.dart';
import 'package:woodenfish_bloc/utils/alert_dialog.dart';
import 'package:woodenfish_bloc/utils/audio_play_util.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';
import 'woodfish_event.dart';
import 'woodfish_state.dart';

class WoodFishWidgetBloc
    extends Bloc<WoodFishWidgetEvent, WoodFishWidgetState> {
  WoodFishWidgetBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(WoodFishWidgetState().init()) {
    on<WoodenFishInitEvent>(_init);
    on<IncrementEvent>(_increment);
    on<IsAutoEvent>(_isAutoEvent);
    on<ChangWoodenFishStateEvent>(_changeWoodenFishStateEvent);
    on<SavePrayAvatarEvent>(_savePrayAvatarEvent);
  }

  final WoodenRepository _woodenRepository;
  final List<Widget> _knockAnimationWidgets = [];
  late Timer autoKnockTimer;

  void _init(
      WoodenFishInitEvent event, Emitter<WoodFishWidgetState> emit) async {
    state.setting = _woodenRepository.getSetting();
    state.totalCount = BigInt.parse(state.setting.totalCount);
    state.bgColor = WoodenFishUtil.internal()
        .getColorFromString(state.setting.woodenFishBg);
    var prayAvatarPhoto =
        await WoodenFishUtil.internal().getAvatarImage(state.prayPhotoName);
    if (prayAvatarPhoto != null) {
      state.prayPhoto = prayAvatarPhoto;
    }

    emit(state.clone());
  }

  void _increment(
      IncrementEvent event, Emitter<WoodFishWidgetState> emit) async {
    //get autoKnockSettingInfo
    var autoKnockSetting = _woodenRepository.getAutoKnockSettingInfo();
    print('is open auto stop = ${autoKnockSetting.isAutoStop}');
    print('autoKnockSetting.type = ${autoKnockSetting.autoStopType}');
    print('autoKnockSetting.limitCount = ${autoKnockSetting.limitCount}');
    print(
        'autoKnockSetting.currentCount = ${autoKnockSetting.currentKnockCount}');

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
            autoKnockSetting.limitCount ==
                autoKnockSetting.currentKnockCount) ||
        (autoKnockSetting.isAutoStop &&
            autoKnockSetting.autoStopType == AutoStop.countDown &&
            autoKnockSetting.countDownSecond == 0)) {
      print('meet a condition');
      return;
    }

    //accumulation
    state.totalCount += BigInt.from(1);
    state.setting.totalCount = "${state.totalCount}";

    state.currentCount++;

    //get level
    state.setting.level = WoodenFishUtil.internal()
        .getLevelElementFromKnockCount(state.totalCount)
        .toString();

    //save autoKnockSettingInfo
    state.autoKnockSetting = autoKnockSetting;
    state.autoKnockSetting.currentKnockCount = state.currentCount;
    print('state.autoKnockSetting.currentCount = ${state.currentCount}');

    //get setting
    state.setting = _woodenRepository.getSetting();

    //check Vibration
    if (state.setting.isVibration) {
      await HapticFeedback.vibrate();
    }

    //check Display
    if (state.setting.isDisplay) {
      var soundPathName = WoodenFishUtil.internal()
          .getSoundNameFromString(state.setting.woodenFishSound);
      AudioPlayUtil().stop();
      await AudioPlayUtil().play(soundPathName);

      var textColor = WoodenFishUtil.internal()
          .getKnockTextColorFromString(state.setting.woodenFishBg);
      var levelElement = WoodenFishUtil.internal()
          .getLevelElementFromString(state.setting.level);
      var gradient =
          WoodenFishUtil.internal().getLinearGradientFrom(levelElement!);
      var isTopGodLevel = WoodenFishUtil.internal()
          .getLevelNameElementFromString(state.setting.level)
          .contains("佛");

      KnockTextWidget knockWidget = KnockTextWidget(
          key: ValueKey("${autoKnockSetting.currentKnockCount}"),
          isTopGod: isTopGodLevel,
          childWidget: Flexible(
            child: (state.setting.woodenFishBg != "WoodenFishBgElement.none")

                ///when bg is none
                ? Stack(
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (bounds) {
                          return gradient.createShader(bounds);
                        },
                        child: isTopGodLevel
                            ? Text(
                                state.setting.displayWord,
                                style: TextStyle(
                                    fontSize: 30.0,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2),
                              )
                            : const SizedBox(),
                      ),
                      ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (bounds) {
                          return gradient.createShader(bounds);
                        },
                        child: Text(
                          state.setting.displayWord,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  )
                : Text(
                    state.setting.displayWord,
                    style: TextStyle(fontSize: 30, color: textColor),
                  ),
          ),
          onRemove: (key) async {
            await _removeWidget(key);
          });

      _knockAnimationWidgets.add(Stack(
        key: ValueKey("${autoKnockSetting.currentKnockCount}"),
        children: [knockWidget],
      ));
      state.knockAnimationWidgets = _knockAnimationWidgets;
    }

    if ((state.autoKnockSetting.isAutoStop &&
        state.autoKnockSetting.autoStopType == AutoStop.count &&
        state.autoKnockSetting.currentKnockCount <=
            state.autoKnockSetting.limitCount)) {
      print('state.currentCount = ${state.currentCount}');
      event.btTabBar.add(CurrentCountEvent(count: state.currentCount));
    }

    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);

    //dev
    _woodenRepository.saveSetting(state.setting);

    //Knock once per second
    state.woodenFishProgress = true;
    emit(state.clone());
    if (!state.isAuto) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    state.woodenFishProgress = false;
    emit(state.clone());
  }

  void _isAutoEvent(IsAutoEvent event, Emitter<WoodFishWidgetState> emit) {
    state.isAuto = event.isAuto;

    emit(state.clone());
  }

  void _changeWoodenFishStateEvent(
      ChangWoodenFishStateEvent event, Emitter<WoodFishWidgetState> emit) {
    state.setting = _woodenRepository.getSetting();

    emit(state.clone());
  }

  void _savePrayAvatarEvent(
      SavePrayAvatarEvent event, Emitter<WoodFishWidgetState> emit) async {
    state.photoLoadingStatus = PhotoLoadStatus.loading;
    emit(state.clone());
    await saveAvatarPhoto(state.prayPhotoName);
    emit(state.clone());
  }

  Future<void> saveAvatarPhoto(String photoName) async {
    try {
      ImagePicker picker = ImagePicker();
      // using your method of getting an image
      XFile? image = await picker
          .pickImage(source: ImageSource.gallery, imageQuality: 10)
          .catchError((error) {
        print("ImagePicker error = $error");
        if (error.toString().contains("The user did not allow photo access")) {
          print("The user did not allow photo access");

          state.photoLoadingStatus = PhotoLoadStatus.fail;
        }
      });
      print('image path = ${image?.path}');
      if (image == null) {
        print('cancel update AvatarImag');
        state.photoLoadingStatus = PhotoLoadStatus.fail;
        return;
      }
      File imageFile = File(image.path);
      if (await imageFile.exists()) {
        // getting a directory path for saving
        String path = await WoodenFishUtil.internal().getPrayAvatarPath();
        // copy the file to a new path
        await imageFile.copy('$path/$photoName');

        state.prayPhoto = Image.file(imageFile);
        state.photoLoadingStatus = PhotoLoadStatus.finish;
      }
    } on FormatException catch (e) {
      state.photoLoadingStatus = PhotoLoadStatus.finish;
    }
  }

  Future<void> _removeWidget(Key key) async {
    _knockAnimationWidgets.removeWhere((element) => element.key == key);
    print('knockAnimationWidgets length = ${_knockAnimationWidgets.length}');
    state.knockAnimationWidgets = _knockAnimationWidgets;
  }
}
