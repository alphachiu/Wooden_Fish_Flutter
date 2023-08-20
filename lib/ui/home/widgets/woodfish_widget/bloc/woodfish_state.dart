import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

class WoodFishWidgetState {
  late BigInt totalCount;
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
  late bool woodenFishProgress;
  late BannerAd? bannerAd;
  late bool nativeAdIsLoaded;
  late DateTime autoOpenTime;
  late int limitTime;
  late bool isDisplayAd;
  late bool isGetRewardAd;
  late Widget? addRewardText;
  late int rewardPoint;

  WoodFishWidgetState init() {
    return WoodFishWidgetState()
      ..totalCount = BigInt.from(0)
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
        image: AssetImage('assets/images/user_Icon_01.png'),
        width: 200,
        height: 200,
      )
      ..prayPhotoName = 'prayAvatarPhoto.png'
      ..photoLoadingStatus = PhotoLoadStatus.init
      ..woodenFishProgress = false
      ..nativeAdIsLoaded = true
      ..autoOpenTime = DateTime.now()
      ..isDisplayAd = false
      ..limitTime = 1
      ..isGetRewardAd = false
      ..addRewardText = null
      ..rewardPoint = 100;
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
      ..photoLoadingStatus = photoLoadingStatus
      ..woodenFishProgress = woodenFishProgress
      ..bannerAd = bannerAd
      ..nativeAdIsLoaded = nativeAdIsLoaded
      ..limitTime = limitTime
      ..isDisplayAd = isDisplayAd
      ..autoOpenTime = autoOpenTime
      ..isGetRewardAd = isGetRewardAd
      ..addRewardText = addRewardText
      ..rewardPoint = rewardPoint;
  }
}
