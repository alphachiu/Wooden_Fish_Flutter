import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woodenfish_bloc/repository/api/setting_api.dart';
import 'package:woodenfish_bloc/repository/models/setting.dart';

class LocalStorageSettingApi extends SettingAPI{

  LocalStorageSettingApi({required SharedPreferences plugin}): _plugin = plugin {
    _init();
  }

  @visibleForTesting
  static const settingKey = 'settingKey';

  final SharedPreferences _plugin;
  late Setting? settingInfo = Setting();

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);
  Future<void> _deleteValue(String key) => _plugin.remove(key);

  void _init() {
    print('init loacal api');
    final settingJson = _getValue(settingKey);
    print('settingJson = $settingJson');
    if (settingJson != null) {

      settingInfo = Setting.fromJson(Map<String, dynamic>.from(json.decode(settingJson)));
    }
  }

  @override
  Setting getInfo() {
    // TODO: implement getInfo
    return settingInfo!;
  }

  @override
  Future<void> saveInfo(setting) {
    // TODO: implement saveInfo
    settingInfo = setting;
   return  _setValue(settingKey, json.encode(settingInfo));
  }

  @override
  Future<void> deleteSettingInfo() {
    // TODO: implement deleteInfo
    return _deleteValue(settingKey);
  }

}