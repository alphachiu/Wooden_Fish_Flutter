import 'package:woodenfish_bloc/repository/models/Local_setting.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';

class SettingWidgetState {
  late List<SettingModel> sections;
  late LocalSetting setting;

  SettingWidgetState init() {
    return SettingWidgetState()
      ..sections = [
        SettingModel(
            name: '變更祈福文', position: SettingPosition.none, group: '祈福文字'),
        SettingModel(
            name: '自動敲擊設置', position: SettingPosition.none, group: '播放模式'),
        SettingModel(
            name: '顯示祈福文', position: SettingPosition.head, group: '其他設置'),
        SettingModel(name: '震動', position: SettingPosition.end, group: '其他設置')
      ]
      ..setting = LocalSetting();
  }

  SettingWidgetState clone() {
    return SettingWidgetState()
      ..sections = sections
      ..setting = setting;
  }
}
