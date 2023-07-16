import 'dart:async';
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
  Timer _timer = Timer(const Duration(milliseconds: 1), () {});

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (context) =>   WoodFishWidgetPage(),
      TabItem.setting: (context) => SettingWidgetPage(),
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

  void _startTimer(BottomTabBarBloc bloc) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      bloc.add(CountDownEvent());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

      if (state.currentAutoStopType == AutoStop.countDown) {
        print('AutoStop.countDown');
        print('oldCountDownType  = ${state.oldCountDownType}');
        print('newCountDownType = ${state.newCountDownType}');

        if (!state.isHiddenTip) {
          if (_timer.isActive) {
            _timer.cancel();
          }
        } else if (state.oldCountDownType != state.newCountDownType &&
            state.newCountDownType != AutoStopTime.none) {
          _timer.cancel();
          _startTimer(bloc);
        } else if (state.newCountDownType == AutoStopTime.none ||
            state.countDownSecond == 0) {
          if (_timer.isActive) {
            _timer.cancel();
          }
        }
      } else {
        if (_timer.isActive) {
          _timer.cancel();
        }
      }
    }, builder: (context, state) {
      return BlocBuilder<BottomTabBarBloc, BottomTabBarState>(
          builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            navigatorKeys[_currentTab]!.currentState!.popUntil((route) {
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
                                    child: (state.currentAutoStopType ==
                                            AutoStop.count)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                DefaultTextStyle(
                                                  style: const TextStyle(
                                                      fontSize: 25,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              DefaultTextStyle(
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                                child: Text(state.countDownStr),
                                              )
                                            ],
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
