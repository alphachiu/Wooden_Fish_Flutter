import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:woodenfish_bloc/repository/models/auto_knock_setting.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_bloc.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_event.dart';
import 'package:woodenfish_bloc/ui/home/page/bottom_tabbar/bloc/bottom_tabbar_state.dart';
import 'package:woodenfish_bloc/ui/home/widgets/auto_setting/bloc/auto_setting_state.dart';

import 'bloc/auto_setting_bloc.dart';
import 'bloc/auto_setting_event.dart';

class AutoSettingPage extends StatefulWidget {
  const AutoSettingPage({Key? key}) : super(key: key);

  @override
  State<AutoSettingPage> createState() => _AutoSettingPageState();
}

class _AutoSettingPageState extends State<AutoSettingPage> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AutoSettingBloc(
          woodenRepository: RepositoryProvider.of<WoodenRepository>(context))
        ..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<AutoSettingBloc>(context);

    final btBloc = BlocProvider.of<BottomTabBarBloc>(context);

    return Container(
      color: const Color(0xFFF5F6F9),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff37CACF),
              shadowColor: Colors.transparent,
              title: const Text('自動敲擊設置'),
            ),
            body: BlocBuilder<AutoSettingBloc, AutoSettingState>(
                builder: (context, state) {
              return Container(
                  color: const Color(0xFFF5F6F9),
                  child: GroupedListView(
                    elements: state.sectionList,
                    // groupComparator: (value1, value2) {
                    //   return value2.compareTo(value1);
                    // },
                    groupSeparatorBuilder: (String value) => Container(
                      color: const Color(0xFFF5F6F9),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 20, bottom: 10, top: 10),
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    groupBy: (element) {
                      var group = element;
                      return group.group;
                    },
                    indexedItemBuilder: (context, element, index) {
                      if (state.autoKnockSetting.limitCount != 0) {
                        controller.text =
                            "${state.autoKnockSetting.limitCount}";
                      }

                      if (index == 0) {
                        Widget thirdLayerWidget = const SizedBox();

                        if (state.isAutoStop) {
                          if (state.autoStopType == AutoStop.count) {
                            thirdLayerWidget = Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                controller: controller,
                                decoration: const InputDecoration(
                                    hintText: '請輸入停止的指定數字'),
                                onChanged: (value) {
                                  var limitInt = value;
                                  if (value.isEmpty ||
                                      int.parse(limitInt) <= 1) {
                                    limitInt = '1';
                                  }
                                  btBloc.add(InputLimitCountEvent(
                                      limitCount: int.parse(limitInt)));
                                },
                              ),
                            );
                          } else {
                            FocusScope.of(context).requestFocus(FocusNode());
                            thirdLayerWidget = Row(
                              children: [
                                Expanded(
                                  child: CupertinoSlidingSegmentedControl(
                                    padding: const EdgeInsets.all(8),
                                    thumbColor: const Color(0xff37CACF),
                                    backgroundColor: const Color(0xFFF0F1F3),
                                    groupValue: state.countDownType,
                                    onValueChanged: (value) {
                                      bloc.add(ChangeCountDownTypeEvent(
                                          isChange: value!));
                                      btBloc.add(
                                          SetCountDownEvent(timeType: value));
                                    },
                                    children: state.countDownSegmentMap,
                                  ),
                                )
                              ],
                            );
                          }
                        }

                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      )),
                                  child: ListTile(
                                      title: Text(element.name),
                                      trailing: Switch.adaptive(
                                          activeColor: const Color(0xff37CACF),
                                          value: state.isAutoStop,
                                          onChanged: (isChange) {
                                            print('isChange = ${isChange}');

                                            bloc.add(SwitchAutoStopEvent(
                                                isChange: isChange));

                                            btBloc.add(
                                                TipEvent(isChange: isChange));
                                          })),
                                ),
                                state.isAutoStop
                                    ? Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child:
                                                      CupertinoSlidingSegmentedControl(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    thumbColor:
                                                        const Color(0xff37CACF),
                                                    backgroundColor:
                                                        const Color(0xFFF0F1F3),
                                                    groupValue:
                                                        state.autoStopType,
                                                    onValueChanged: (value) {
                                                      bloc.add(
                                                          ChangeAutoStopTypeEvent(
                                                              isChange:
                                                                  value!));
                                                      btBloc.add(
                                                          ChangeTypeEvent(
                                                              change: value!));
                                                    },
                                                    children: state
                                                        .autoStopSegmentMap,
                                                  ),
                                                ))
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: thirdLayerWidget,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ))
                                    : Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                                child: SizedBox(
                                              height: 10,
                                            ))
                                          ],
                                        ),
                                      ),
                              ],
                            ));
                      } else {
                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              element.name,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              '${state.setting.autoSpeed}(S)',
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 10),
                                    child: Slider(
                                        activeColor: const Color(0xff37CACF),
                                        inactiveColor: const Color(0xFFF0F1F3),
                                        value: state.setting.autoSpeed,
                                        max: 5,
                                        min: 1,
                                        label: "${state.setting.autoSpeed}",
                                        onChanged: (value) {
                                          var v = value.toStringAsFixed(1);
                                          double progress = double.parse(v);
                                          bloc.add(SliderProgressEvent(
                                              progress: progress));
                                        }),
                                  ),
                                ),
                              ],
                            ));
                      }
                    },
                  ));
            })),
      ),
    );
  }
}

// class Auto_settingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => Auto_settingBloc()..add(InitEvent()),
//       child: Builder(builder: (context) => _buildPage(context)),
//     );
//   }
//
//   Widget _buildPage(BuildContext context) {
//     final bloc = BlocProvider.of<Auto_settingBloc>(context);
//
//     return Container(
//       color: const Color(0xFFF5F6F9),
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: const Color(0xFFF9BEAE7),
//             shadowColor: Colors.transparent,
//             title: const Text('自動敲擊設置'),
//           ),
//         ),
//       ),
//     );
//   }
// }
