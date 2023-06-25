import 'package:woodenfish_bloc/repository/models/setting.dart';

abstract class SettingAPI{
  const SettingAPI();

  Future<void> saveInfo(Setting setting);
  Setting getInfo();
  Future<void> deleteSettingInfo();

}