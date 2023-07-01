import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';

abstract class SettingAPI {
  const SettingAPI();

  Future<void> saveInfo(LocalSetting setting);

  LocalSetting getInfo();

  Future<void> deleteSettingInfo();

  void saveAutoKnockSetting(AutoKnockSetting setting);
  AutoKnockSetting getAutoKnockSettingInfo();
}
