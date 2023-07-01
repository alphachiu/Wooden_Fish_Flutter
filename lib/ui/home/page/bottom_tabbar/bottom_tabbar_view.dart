import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_event.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/cupertino_home_Scaffold.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/tab_Item.dart';

import 'package:woodenfish_bloc/ui/home/widgets/setting_widget/setting_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/woodfish_widget.dart';

import 'bloc/bottom_tabbar_bloc.dart';

import 'bloc/bottom_tabbar_state.dart';

final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
  TabItem.home: GlobalKey<NavigatorState>(),
  TabItem.setting: GlobalKey<NavigatorState>(),
};

class BottomTabBarPage extends StatefulWidget {
  const BottomTabBarPage({Key? key}) : super(key: key);

  @override
  State<BottomTabBarPage> createState() => _BottomTabBarPageState();
}

class _BottomTabBarPageState extends State<BottomTabBarPage> {
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
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BottomTabBarBloc(
          woodenRepository: RepositoryProvider.of<WoodenRepository>(context))
        ..add(BTInitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<BottomTabBarBloc>(context);

    return BlocConsumer<BottomTabBarBloc, BottomTabBarState>(
        listener: (context, state) {
      print('bottom tabbar listener');
    }, builder: (context, state) {
      return BlocBuilder<BottomTabBarBloc, BottomTabBarState>(
          builder: (context, state) {
        print('bottom tabbar BlocBuilder');

        return WillPopScope(
          onWillPop: () async {
            print('tab WillPopScope');
            navigatorKeys[_currentTab]!.currentState!.popUntil((route) {
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
              state.isHiddenTip
                  ? SafeArea(
                      child: Opacity(
                        opacity: 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    color: Colors.black,
                                    child: (state.currentType == AutoStop.count)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                DefaultTextStyle(
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                  child: Text(
                                                    '${state.currentCount} / ${state.limitCount}',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const DefaultTextStyle(
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                  child: Text(
                                                    '達到指定數字將停止敲擊',
                                                  ),
                                                )
                                              ])
                                        : Column(
                                            children: [],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05)
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        );
      });
    });
  }
}

// class Bottom_tabbarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => Bottom_tabbarBloc()..add(InitEvent()),
//       child: Builder(builder: (context) => _buildPage(context)),
//     );
//   }
//
//   Widget _buildPage(BuildContext context) {
//     final bloc = BlocProvider.of<Bottom_tabbarBloc>(context);
//
//     return Container();
//   }
// }
