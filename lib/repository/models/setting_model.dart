import 'dart:ui';

enum SettingPosition { head, mid, end, none }

enum BgElement { none, red, orange, yellow, green, blue, indigo, purple }

class GroupListModel {
  GroupListModel(
      {required this.name,
      required this.position,
      required this.group,
      this.element});

  String name;
  SettingPosition position;
  String group;
  List<ListElementModel<Color>>? element;
}

class ListElementModel<T> {
  ListElementModel({required this.bgName, required this.element});

  BgElement bgName;
  T? element;
}
