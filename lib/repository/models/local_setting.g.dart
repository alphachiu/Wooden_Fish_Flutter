// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Local_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalSetting _$SettingFromJson(Map<String, dynamic> json) => LocalSetting(
      isDisplayPrayWord: json['isDisplay'] as bool? ?? true,
      isVibration: json['isVibration'] as bool? ?? true,
      displayWord: json['displayWord'] as String? ?? "+1",
      autoSpeed: json['autoSpeed'] as double? ?? 0.5,
      woodenFishBg:
          json['woodenFishBg'] as String? ?? "WoodenFishBgElement.none",
      woodenFishSkin:
          json['woodenFishSkin'] as String? ?? "WoodenFishSkinElement.wood",
      woodenFishSound:
          json['woodenFishSound'] as String? ?? "woodenFish_sound_01.wav",
      isSetPrayPhoto: json['isSetPrayPhoto'] as bool? ?? false,
      userName: json['userName'] as String? ?? "靜心小僧",
      level: json['level'] as String? ?? "WoodenFishLevelElement.lv01",
      totalCount: json['totalCount'] as String? ?? "0",
    );

Map<String, dynamic> _$SettingToJson(LocalSetting instance) =>
    <String, dynamic>{
      'isDisplay': instance.isDisplayPrayWord,
      'isVibration': instance.isVibration,
      'displayWord': instance.displayWord,
      'autoSpeed': instance.autoSpeed,
      'woodenFishBg': instance.woodenFishBg,
      'woodenFishSkin': instance.woodenFishSkin,
      'woodenFishSound': instance.woodenFishSound,
      'isSetPrayPhoto': instance.isSetPrayPhoto,
      'userName': instance.userName,
      'level': instance.level,
      'totalCount': instance.totalCount,
    };
