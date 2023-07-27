import 'dart:io';

import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';



class WoodFishWidgetState {
  late int totalCount;
  late int currentCount;
  late List<Widget> knockAnimationWidgets;
  late bool isAuto;
  late LocalSetting setting;
  late AutoKnockSetting autoKnockSetting;
  late int currentLimit;
  late Color bgColor;
  late Image wfSkin;
  late String prayPhotoName;
  late Image prayPhoto;
  late PhotoLoadStatus photoLoadingStatus;

  WoodFishWidgetState init() {
    return WoodFishWidgetState()
      ..totalCount = 0
      ..currentCount = 0
      ..currentLimit = 0
      ..knockAnimationWidgets = []
      ..isAuto = false
      ..setting = LocalSetting()
      ..autoKnockSetting = AutoKnockSetting()
      ..bgColor = Colors.white
      ..wfSkin = WoodenFishUtil.internal()
          .getSkinImageFromString('WoodenFishSkinElement.wood')
      ..prayPhoto = const Image(
        image: AssetImage('assets/images/user_Icon.png'),
        width: 200,
        height: 200,
      )
      ..prayPhotoName = 'prayAvatarPhoto.png'
      ..photoLoadingStatus = PhotoLoadStatus.init;
  }

  WoodFishWidgetState clone() {
    return WoodFishWidgetState()
      ..totalCount = totalCount
      ..currentCount = currentCount
      ..currentLimit = currentLimit
      ..knockAnimationWidgets = knockAnimationWidgets
      ..isAuto = isAuto
      ..setting = setting
      ..autoKnockSetting = autoKnockSetting
      ..bgColor = bgColor
      ..wfSkin = wfSkin
      ..prayPhoto = prayPhoto
      ..prayPhotoName = prayPhotoName
      ..photoLoadingStatus = photoLoadingStatus;
  }
}
