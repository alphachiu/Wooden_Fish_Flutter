import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_bloc.dart';

import 'bloc/woodfish_bloc.dart';
import 'bloc/woodfish_event.dart';
import 'bloc/woodfish_state.dart';

class WoodFishWidgetPage extends StatefulWidget {
  const WoodFishWidgetPage({Key? key}) : super(key: key);

  @override
  State<WoodFishWidgetPage> createState() => _WoodFishWidgetPageState();
}

class _WoodFishWidgetPageState extends State<WoodFishWidgetPage>
    with SingleTickerProviderStateMixin {
  late Timer autoKnockTimer;
  late int milliseconds = 500;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void startTimer(WoodFishWidgetBloc bloc, BottomTabBarBloc btTabBar) {
    autoKnockTimer =
        Timer.periodic(Duration(milliseconds: milliseconds * 1000), (timer) {
      bloc.add(IncrementEvent(btTabBar: btTabBar));
    });
  }

  void stopAuto() {
    autoKnockTimer.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopAuto();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WoodFishWidgetBloc(
          woodenRepository: RepositoryProvider.of<WoodenRepository>(context))
        ..add(WoodenFishInitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<WoodFishWidgetBloc>(context);
    final btBloc = BlocProvider.of<BottomTabBarBloc>(context);
    print("home parant");

    return BlocConsumer<WoodFishWidgetBloc, WoodFishWidgetState>(
        listener: (context, state) {
      print('Wood fish listener');
    }, builder: (context, state) {
      if (state.isAuto && milliseconds != state.setting.autoSpeed.toInt()) {
        milliseconds = state.setting.autoSpeed.toInt();
        stopAuto();
        startTimer(bloc, btBloc);
      }

      return BlocBuilder<WoodFishWidgetBloc, WoodFishWidgetState>(
        builder: (context, state) {
          print('wooden fish BlocBuilder');
          return Container(
            color: state.bgColor,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: state.bgColor,
                body: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '累積敲${state.totalCount}次',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(state.isAuto ? '手動' : '自動',
                                      style: const TextStyle(fontSize: 20.0)),
                                  Switch.adaptive(
                                      value: state.isAuto,
                                      activeColor: const Color(0xff37CACF),
                                      onChanged: (isChange) {
                                        bloc.add(IsAutoEvent(isAuto: isChange));
                                        //milliseconds += 2000;
                                        if (!isChange) {
                                          stopAuto();
                                        } else {
                                          startTimer(bloc, btBloc);
                                        }
                                      }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ), //MediaQuery.of(context).size.height
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              bloc.add(IncrementEvent(btTabBar: btBloc));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Stack(
                                        children: state.knockAnimationWidgets),
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/wooden-fish.png'),
                                      width: 250,
                                      height: 250,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

// class Woodfish_widgetPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => Woodfish_widgetBloc()..add(InitEvent()),
//       child: Builder(builder: (context) => _buildPage(context)),
//     );
//   }
//
//   Widget _buildPage(BuildContext context) {
//     final bloc = BlocProvider.of<Woodfish_widgetBloc>(context);
//
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           body: BlocBuilder<Woodfish_widgetBloc, Woodfish_widgetState>(
//             builder: (context, state) {
//               return Stack(
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 20,
//                                   ),
//                                   Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         '累積敲${state.totalCount}次',
//                                         style: TextStyle(fontSize: 20.0),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text(state.isAuto ? '自動' : '手動',
//                                       style: TextStyle(fontSize: 20.0)),
//                                   Switch(
//                                       value: state.isAuto,
//                                       onChanged: (isChange) {
//                                         bloc.add(IsAutoEvent(isAuto: isChange));
//                                       })
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ), //MediaQuery.of(context).size.height
//                       Expanded(
//                         flex: 1,
//                         child: InkWell(
//                           highlightColor: Colors.transparent,
//                           splashColor: Colors.transparent,
//                           onTap: () {
//                             bloc.add(IncrementEvent());
//                           },
//                           child: Container(
//                             // color: Colors.yellow,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Stack(
//                                   children: [
//                                     Stack(
//                                         children: state.knockAnimationWidgets),
//                                     const Image(
//                                       image: AssetImage(
//                                           'assets/images/wooden-fish.png'),
//                                       width: 250,
//                                       height: 250,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             },
//           )),
//     );
//   }
// }
