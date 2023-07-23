import 'package:woodenfish_bloc/repository/api/local_storage_setting_api.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

abstract class SettingAPI {
  const SettingAPI();


  Future<void> saveInfo(LocalSetting setting);

  LocalSetting getSettingInfo();

  Future<void> deleteSettingInfo();

  void saveAutoKnockSetting(AutoKnockSetting setting);

  AutoKnockSetting getAutoKnockSettingInfo();
}
