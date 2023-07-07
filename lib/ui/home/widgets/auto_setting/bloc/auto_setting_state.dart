import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

class AutoSettingState {
  late List<SettingModel> sectionList;
  late LocalSetting setting;
  late bool isAutoStop;
  late Map<AutoStop, Widget> autoStopSegmentMap;
  late Map<AutoStopTime, Widget> countDownSegmentMap;
  late AutoStop autoStopType;
  late AutoStopTime countDownType;
  late AutoKnockSetting autoKnockSetting;

  AutoSettingState init() {
    return AutoSettingState()
      ..sectionList = [
        SettingModel(
            name: '自動停止', position: SettingPosition.none, group: '停止模式'),
        SettingModel(name: '間隔', position: SettingPosition.none, group: '敲擊間隔'),
      ]
      ..setting = LocalSetting()
      ..autoKnockSetting = AutoKnockSetting()
      ..isAutoStop = false
      ..autoStopSegmentMap = {
        AutoStop.count: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              '計數',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        AutoStop.countDown: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('倒計時',
                style: TextStyle(color: Colors.black, fontSize: 18))),
      }
      ..countDownSegmentMap = {
        AutoStopTime.none: const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              '無',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        AutoStopTime.five: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              '5分',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        AutoStopTime.ten: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('10分',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        AutoStopTime.fifteen: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('15分',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        AutoStopTime.thirty: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('30分',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        AutoStopTime.sixty: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('60分',
                style: TextStyle(color: Colors.black, fontSize: 18))),
      }
      ..autoStopType = AutoStop.count
      ..countDownType = AutoStopTime.none;
  }

  AutoSettingState clone() {
    return AutoSettingState()
      ..sectionList = sectionList
      ..setting = setting
      ..autoKnockSetting = autoKnockSetting
      ..isAutoStop = isAutoStop
      ..autoStopSegmentMap = autoStopSegmentMap
      ..countDownSegmentMap = countDownSegmentMap
      ..autoStopType = autoStopType
      ..countDownType = countDownType;
  }
}
