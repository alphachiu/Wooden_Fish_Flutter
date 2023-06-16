import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { home, setting }

class TabItemData {
  const TabItemData({required this.title, required this.icon});

  final String title;
  final Widget icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(title: 'Home', icon: Icon(Icons.home)),
    TabItem.setting: TabItemData(title: 'Setting', icon: Icon(Icons.settings)),
  };
}
