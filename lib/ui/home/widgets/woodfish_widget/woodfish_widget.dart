import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:woodenfish_bloc/repository/ads_repository.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';

import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_bloc.dart';
import 'package:woodenfish_bloc/utils/audio_play_util.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';
import '../../../../utils/alert_dialog.dart';
import 'bloc/woodfish_bloc.dart';
import 'bloc/woodfish_event.dart';
import 'bloc/woodfish_state.dart';
import 'custom_bg/custom_bg_main.dart';

class WoodFishWidgetPage extends StatefulWidget {
  const WoodFishWidgetPage({Key? key}) : super(key: key);

  @override
  State<WoodFishWidgetPage> createState() => _WoodFishWidgetPageState();
}

class _WoodFishWidgetPageState extends State<WoodFishWidgetPage>
    with SingleTickerProviderStateMixin {
  late Timer autoKnockTimer;
  late int milliseconds = 1;

  @override
  void initState() {
    // TODO: implement initState
    WoodenFishUtil.internal().requestNotificationPermissions();
    WoodenFishUtil.internal().scheduleDailyTenAMNotification();

    super.initState();
  }

  void startTimer(WoodFishWidgetBloc bloc, BottomTabBarBloc btTabBar) {
    print('milliseconds = ${milliseconds}');
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
    stopAuto();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WoodFishWidgetBloc(
          woodenRepository: RepositoryProvider.of<WoodenRepository>(context),
          adsRepository: RepositoryProvider.of<AdsRepository>(context))
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
      if (state.photoLoadingStatus == PhotoLoadStatus.fail) {
        state.photoLoadingStatus = PhotoLoadStatus.init;
        showAlertDialog(context,
            cancelActionText: '',
            content: 'Not Allow Photo Access',
            doneActon: () async {});
      }
    }, builder: (context, state) {
      if (state.isAuto && milliseconds != state.setting.autoSpeed.toInt()) {
        milliseconds = state.setting.autoSpeed.toInt();
        stopAuto();
        startTimer(bloc, btBloc);
      }

      return BlocBuilder<WoodFishWidgetBloc, WoodFishWidgetState>(
        builder: (context, state) {
          print('wooden fish BlocBuilder');
          state.bgColor = WoodenFishUtil.internal()
              .getColorFromString(state.setting.woodenFishBg);
          state.wfSkin = WoodenFishUtil.internal()
              .getSkinImageFromString(state.setting.woodenFishSkin);

          // var knockCount = WoodenFishUtil.internal()
          //     .transformationKnockCount(state.totalCount);

          return Scaffold(
            backgroundColor: state.bgColor,
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  //Change Background
                  CustomBgMain(
                      state: state,
                      prayPhotoOnTap: () {
                        bloc.add(SavePrayAvatarEvent());
                      }),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Text(
                                                    '累積敲 ${state.totalCount} 次',
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0,
                                                        color: state.bgColor ==
                                                                Colors.white
                                                            ? Colors.black
                                                            : Colors.white),
                                                  ),
                                                  Positioned(
                                                      right: -100,
                                                      child:
                                                          state.addRewardText ??
                                                              const SizedBox())
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    Text(state.isAuto ? '手動' : '自動',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: state.bgColor == Colors.white
                                                ? Colors.black
                                                : Colors.white)),
                                    Switch.adaptive(
                                        value: state.isAuto,
                                        inactiveTrackColor: Colors.grey,
                                        activeColor: const Color(0xff37CACF),
                                        onChanged: (isChange) {
                                          bloc.add(
                                              IsAutoEvent(isAuto: isChange));
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
                                ),
                              )
                            ],
                          ),
                        ), //MediaQuery.of(context).size.height
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () async {
                                    if (state.woodenFishProgress) {
                                      return;
                                    } else {
                                      bloc.add(
                                          IncrementEvent(btTabBar: btBloc));
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.18,
                                      ),
                                      Stack(
                                        children: [
                                          Stack(
                                            children:
                                                state.knockAnimationWidgets,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              state.wfSkin,
                                            ],
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          !state.nativeAdIsLoaded
                                              ? Align(
                                                  alignment: Alignment.center,
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      minWidth: 120,
                                                      minHeight: 120,
                                                      maxHeight: 150,
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              (2 * 16),
                                                    ),
                                                    child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        child: AdWidget(
                                                            ad: state
                                                                .bannerAd!)),
                                                  ))
                                              : const SizedBox(),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
