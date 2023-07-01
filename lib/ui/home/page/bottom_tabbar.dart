import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/cupertino_home_Scaffold.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/tab_Item.dart';

import 'package:woodenfish_bloc/ui/home/widgets/setting_widget/setting_view.dart';

import '../widgets/woodfish_widget/woodfish_widget.dart';

final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
  TabItem.home: GlobalKey<NavigatorState>(),
  TabItem.setting: GlobalKey<NavigatorState>(),
};

class BottomTabBarView extends StatefulWidget {
  const BottomTabBarView({Key? key}) : super(key: key);

  @override
  _BottomTabBarViewState createState() => _BottomTabBarViewState();
}

class _BottomTabBarViewState extends State<BottomTabBarView> {
  TabItem _currentTab = TabItem.home;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => Woodfish_widgetPage(),
      TabItem.setting: (_) => SettingWidgetPage(),
    };
  }

  void _select(TabItem tabItem) {
    print('_select = ${tabItem}');

    if (tabItem == _currentTab) {
      // pop to first route
      // if (navigatorKeys[tabItem]!.currentState!.canPop()) {
      //   navigatorKeys[tabItem]!.currentState!.pop();
      // } else {
      //
      // }
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('tab bar dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('tabbar main');
    return WillPopScope(
      onWillPop: () async {
        Route? topRoute;
        print('tab WillPopScope');
        navigatorKeys[_currentTab]!.currentState!.popUntil((route) {
          topRoute = route;
          print('top screen name = ${route.settings.name}');
          return true;
        });
        return false;
      },
      child: Stack(
        children: [
          CupertinoHomeScaffold(
            currentTab: _currentTab,
            onSelectTab: _select,
            widgetBuilders: widgetBuilders,
            navigatorKeys: navigatorKeys,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
