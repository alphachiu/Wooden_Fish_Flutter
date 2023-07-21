import 'package:flutter/material.dart';

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
