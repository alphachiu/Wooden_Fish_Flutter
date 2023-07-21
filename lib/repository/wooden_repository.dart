import 'package:woodenfish_bloc/repository/api/setting_api.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

class WoodenRepository {
  const WoodenRepository({required SettingAPI woodenApi})
      : _settingAPI = woodenApi;

  final SettingAPI _settingAPI;

  Future<void> saveSetting(LocalSetting setting) =>
      _settingAPI.saveInfo(setting);

  LocalSetting getSetting() => _settingAPI.getSettingInfo();

  Future<void> deleteSetting() => _settingAPI.deleteSettingInfo();

  AutoKnockSetting getAutoKnockSettingInfo() =>
      _settingAPI.getAutoKnockSettingInfo();
  void saveAutoKnockSetting(AutoKnockSetting setting) =>
      _settingAPI.saveAutoKnockSetting(setting);
}
