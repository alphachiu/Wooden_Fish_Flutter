import 'package:woodenfish_bloc/repository/api/setting_api.dart';
import 'package:woodenfish_bloc/repository/models/setting.dart';

class WoodenRepository{
  const WoodenRepository({required SettingAPI woodenApi}): _settingAPI = woodenApi;

  final SettingAPI _settingAPI;

  Future<void> saveSetting(Setting setting) => _settingAPI.saveInfo(setting);
  Setting getSetting() => _settingAPI.getInfo();
  Future<void> deleteSetting() => _settingAPI.deleteSettingInfo();
}