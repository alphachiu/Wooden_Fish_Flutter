import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/page/cupertino_home_Scaffold.dart';
import 'package:woodenfish_bloc/ui/home/page/tab_Item.dart';

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
      TabItem.setting: (_) => Setting_widgetPage(),
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
    return WillPopScope(
      onWillPop: () async {
        Route? topRoute;
        print('tab WillPopScope');
        navigatorKeys[_currentTab]!.currentState!.popUntil((route) {
          topRoute = route;
          print('top screen name = ${route.settings.name}');
          return true;
        });

        // if (topRoute?.settings.name == 'webview') {
        //   print('webview');
        //   webviewGlobalKeys[_currentTab]?.currentState?.onWillPop();
        //
        //   // webviewGlobalKey.currentState?.onWillPop();
        //
        //   return false;
        // } else {
        //   var canPop = navigatorKeys[_currentTab]!.currentState!.canPop();
        //   print("navigatorKeys[tabItem]!.currentState!.canPop() = ${canPop}");
        //   if (!canPop) {
        //     bool isExist = await showAlertDialog_Willpopscope(context);
        //
        //     AppConfig().analytics?.logEvent(
        //         name: 'WillPopScope_Exit', parameters: {"user_id": null});
        //     print('isExist = ${isExist}');
        //     if (isExist) {
        //       return exit(0);
        //     } else {
        //       return false;
        //     }
        //   } else {
        //     navigatorKeys[_currentTab]!.currentState?.pop();
        //     return false;
        //   }
        // }

        // var isWebObserve =
        //     WebViewObserve().webview_popscrop_Observe.hasListener;
        // print('isWebObserve = ${isWebObserve}');

        // if (!isWebObserve) {
        //   bool isExist = await showAlertDialog_Willpopscope(context);
        //   print('isExist = ${isExist}');
        //
        //   return isExist;
        // } else {
        //   print('in webview');
        //   WebViewObserve().webview_popscrop_Observe.add(true);
        //   return false;
        // }

        // print("WillPopScope 1");
        // await showAlertDialog(context, content: "是否要退出", doneActon: () async {
        //   print("WillPopScope 2");
        //
        //   return true;
        //   // return !(await navigatorKeys[_currentTab]!.currentState?.maybePop() ??
        //   //      false);
        // });
        // print("WillPopScope 3");
        return false;
      },
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
