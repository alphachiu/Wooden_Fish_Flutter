import 'package:woodenfish_bloc/repository/models/setting.dart';

class Setting_widgetState {
  late List sections;
  late Setting setting;


  Setting_widgetState init() {
    return Setting_widgetState()
      ..sections = [
        {'name': '變更祈福文', 'group': '祈福文字'},
        {'name': '敲擊設置', 'group': '播放模式'},
        {'name_start': '顯示祈福文', 'group': '其他設置'},
        {'name_end': '震動', 'group': '其他設置'},
      ]
      ..setting = Setting()
    ;
  }

  Setting_widgetState clone() {
    return Setting_widgetState()
      ..sections = sections
      ..setting = setting
    ;
  }
}
