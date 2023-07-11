import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

class PersonInfoState {
  late List<GroupListModel> sections;
  late LocalSetting setting;
  late BgElement currentBg;

  PersonInfoState init() {
    return PersonInfoState()
      ..sections = [
        GroupListModel(
            element: [],
            name: '木魚外觀',
            position: SettingPosition.none,
            group: '木魚外觀'),
        GroupListModel(element: [
          ListElementModel(bgName: BgElement.none, element: Colors.white),
          ListElementModel(bgName: BgElement.red, element: Colors.red),
          ListElementModel(bgName: BgElement.orange, element: Colors.orange),
          ListElementModel(bgName: BgElement.yellow, element: Colors.yellow),
          ListElementModel(bgName: BgElement.green, element: Colors.green),
          ListElementModel(bgName: BgElement.blue, element: Colors.blue),
          ListElementModel(bgName: BgElement.indigo, element: Colors.indigo),
          ListElementModel(bgName: BgElement.purple, element: Colors.purple),
        ], name: '背景設置', position: SettingPosition.none, group: '背景設置'),
      ]
      ..setting = LocalSetting()
      ..currentBg = BgElement.none;
  }

  PersonInfoState clone() {
    return PersonInfoState()
      ..setting = setting
      ..sections = sections
      ..currentBg = currentBg;
  }
}
