enum SettingPosition { head, mid, end, none }

class SettingModel {
  SettingModel(
      {required this.name, required this.position, required this.group});

  String name;
  SettingPosition position;
  String group;
}
