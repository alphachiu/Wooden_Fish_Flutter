import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

class AutoSettingState {
  late List<SettingModel> sectionList;
  late LocalSetting setting;
  late bool isAutoStop;
  late Map<AutoStop, Widget> autoStopSegList;
  late Map<String, Widget> countDownSegList;
  late AutoStop autoStopType;
  late String countDownType;
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
      ..autoStopSegList = {
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
      ..countDownSegList = {
        '5': const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              '5 min',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
        '10': const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('10 min',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        '15': const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('15 min',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        '30': const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('30 min',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        '60': const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('60 min',
                style: TextStyle(color: Colors.black, fontSize: 18))),
      }
      ..autoStopType = AutoStop.count
      ..countDownType = '5';
  }

  AutoSettingState clone() {
    return AutoSettingState()
      ..sectionList = sectionList
      ..setting = setting
      ..autoKnockSetting = autoKnockSetting
      ..isAutoStop = isAutoStop
      ..autoStopSegList = autoStopSegList
      ..countDownSegList = countDownSegList
      ..autoStopType = autoStopType
      ..countDownType = countDownType;
  }
}
