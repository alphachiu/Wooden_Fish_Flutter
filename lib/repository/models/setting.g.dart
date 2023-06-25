// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      isDisplay: json['isDisplay'] as bool? ?? false,
      isVibration: json['isVibration'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'isDisplay': instance.isDisplay,
      'isVibration': instance.isVibration,
    };
