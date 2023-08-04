enum WoodenFishLevelElement {
  lv01,
  lv02,
  lv03,
  lv04,
  lv05,
  lv06,
  lv07,
  lv08,
  lv09,
  lv10,
  lv11,
  lv12,
  lv13,
  lv14,
  lv15,
  lv16,
  lv17,
  lv18,
  lv19,
  lv20,
  lv21,
  lv22,
  lv23,
  lv24,
  lv25,
  lv26,
  lv27,
  lv28,
  lv29,
  lv30,
  lv31,
  lv32,
  lv33,
  lv34,
  lv35,
  lv36,
  lv37,
  lv38,
  lv39,
  lv40,
  lv41,
  lv42,
  lv43,
  lv44,
  lv45,
  lv46,
  lv47,
  lv48,
  lv49,
  lv50,
  // lv51,
  // lv52,
  // lv53,
  // lv54,
  // lv55,
  // lv56,
  // lv57,
  // lv58,
  // lv59,
  // lv60,
  // lv61,
  // lv62,
  // lv63,
  // lv64,
  // lv65,
  // lv66,
  // lv67,
  // lv68,
  // lv69,
  // lv70
}

enum SettingPosition { head, mid, end, none }

enum WoodenFishBgElement {
  none,
  red,
  orange,
  yellow,
  green,
  blue,
  indigo,
  purple,
  bg01,
  bg02,
  bg03,
  bg04,
  bg05
}

enum PhotoLoadStatus { init, loading, fail, finish }

enum WoodenFishSkinElement {
  wood,
  wood01,
  sky,
  sakura,
  copper,
  silver,
  gold,
  diamond
}

enum WoodenFishSoundElement {
  sound01,
  sound02,
  sound03,
  sound04,
  sound05,
  sound06,
  sound07,
}

class GroupListModel {
  GroupListModel({
    required this.name,
    required this.position,
    required this.group,
  });

  String name;
  SettingPosition position;
  String group;
}

class GroupThemeListModel<T> {
  GroupThemeListModel(
      {required this.name,
      required this.position,
      required this.group,
      this.elementList
      // this.skinElements,
      // this.bgElements
      });

  String name;
  SettingPosition position;
  String group;
  List<T>? elementList;
  // List<ListElementModel<WoodenFishBgElement, Color>>? bgElements;
  // List<ListElementModel<WoodenFishSkinElement, Image>>? skinElements;
}

class ElementModel<B, T> {
  ElementModel({required this.name, required this.element});

  B name;
  T element;
}
