import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/tab_Item.dart';

import 'package:woodenfish_bloc/utils/router.dart' as routers;

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: const Color(0xFFF5F5F5),
        items: [
          _buildItem(TabItem.home),
          _buildItem(TabItem.setting),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        print('tabBuilder item = ${item}');
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (_) => widgetBuilders[item]!(context),
          onGenerateRoute: routers.Router.generateRoute,
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem]!;
    final color = currentTab == tabItem
        ? const Color(0xFF066eb2)
        : const Color(0xFF555555);
    return BottomNavigationBarItem(
      icon: itemData.icon,
      label: itemData.title,
    );
  }
}
