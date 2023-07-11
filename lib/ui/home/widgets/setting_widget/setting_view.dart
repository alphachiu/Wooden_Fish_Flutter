import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/widgets/setting_widget/setting_listTitle.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_bloc.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_event.dart'
    as wood_fish_b;
import 'package:woodenfish_bloc/utils/alert_dialog.dart';
import 'package:woodenfish_bloc/utils/route_paths.dart';

import 'bloc/setting_bloc.dart';
import 'bloc/setting_event.dart';
import 'bloc/setting_state.dart';

class SettingWidgetPage extends StatefulWidget {
  const SettingWidgetPage({Key? key}) : super(key: key);

  @override
  State<SettingWidgetPage> createState() => _SettingWidgetPageState();
}

class _SettingWidgetPageState extends State<SettingWidgetPage> {
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
      create: (BuildContext context) => SettingWidgetBloc(
          woodenRepository: RepositoryProvider.of<WoodenRepository>(context))
        ..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SettingWidgetBloc>(context);

    print("setting parant");

    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: const Color(0xFFF5F6F9),
              body: BlocBuilder<SettingWidgetBloc, SettingWidgetState>(
                  builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.red,
                        )),
                    Expanded(
                        flex: 8,
                        child: Container(
                          color: const Color(0xFFF5F6F9),
                          child: GroupedListView(
                            elements: state.sections,
                            groupComparator: (value1, value2) {
                              return value2.compareTo(value1);
                            },
                            // itemComparator: (item1, item2) =>
                            //     item1.id.compareTo(item2.id),
                            // order: GroupedListOrder.DESC,
                            sort: false,
                            useStickyGroupSeparators: true,
                            groupSeparatorBuilder: (String value) => Container(
                              color: Color(0xFFF5F6F9),
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
                              var settingModel = element as GroupListModel;

                              if (settingModel.position ==
                                  SettingPosition.head) {
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
                                        child: SettingListTitle(
                                          name: settingModel.name,
                                          state: state,
                                          onTap: () {},
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Divider(
                                            color: Colors.black45,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (settingModel.position ==
                                  SettingPosition.end) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        )),
                                    child: SettingListTitle(
                                      name: settingModel.name,
                                      state: state,
                                      onTap: () {
                                        print('name = ${settingModel.name}');
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: SettingListTitle(
                                        name: settingModel.name,
                                        state: state,
                                        onTap: () async {
                                          if (settingModel.name == "變更祈福文") {
                                            await showTFDialog(context,
                                                controller: controller,
                                                content: "輸入祈福文(預設：+1)",
                                                title: settingModel.name,
                                                doneActon: (word) {
                                              if (word.isEmpty) {
                                                bloc.add(ChangeDisplayWordEvent(
                                                    displayWord: "+1"));
                                              } else {
                                                bloc.add(ChangeDisplayWordEvent(
                                                    displayWord: word));
                                              }
                                            });
                                          } else if (settingModel.name ==
                                              "自動敲擊設置") {
                                            Navigator.pushNamed(context,
                                                RoutePaths.autoSetting);
                                          } else if (settingModel.name ==
                                              "個人設定") {
                                            Navigator.pushNamed(
                                                context, RoutePaths.personInfo);
                                          }
                                        },
                                      )),
                                );
                              }
                            },
                          ),
                        ))
                  ],
                );
              }))),
    );
  }
}

// class Setting_widgetPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => Setting_widgetBloc(
//           woodenRepository: RepositoryProvider.of<WoodenRepository>(context))
//         ..add(InitEvent()),
//       child: Builder(builder: (context) => _buildPage(context)),
//     );
//   }
//
//   Widget _buildPage(BuildContext context) {
//
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//           child: Scaffold(
//               backgroundColor: const Color(0xFFF5F6F9),
//               body: BlocBuilder<Setting_widgetBloc, Setting_widgetState>(
//                   builder: (context, state) {
//                 return Column(
//                   children: [
//                     Expanded(
//                         flex: 2,
//                         child: Container(
//                           color: Colors.red,
//                         )),
//                     Expanded(
//                         flex: 8,
//                         child: Container(
//                           color: const Color(0xFFF5F6F9),
//                           child: GroupedListView(
//                             elements: state.sections,
//                             groupComparator: (value1, value2) {
//                               return value2.compareTo(value1);
//                             },
//                             // itemComparator: (item1, item2) =>
//                             //     item1['name'].compareTo(item2['name']),
//                             // order: GroupedListOrder.DESC,
//                             // useStickyGroupSeparators: true,
//                             groupSeparatorBuilder: (String value) => Container(
//                               color: Color(0xFFF5F6F9),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 30, right: 20, bottom: 10, top: 10),
//                                 child: Text(
//                                   value,
//                                   style: const TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                             groupBy: (element) {
//                               var group = element as SettingModel;
//                               return group.group;
//                             },
//                             indexedItemBuilder: (context, element, index) {
//                               var settingModel = element as SettingModel;
//
//                               if (settingModel.position ==
//                                   SettingPosition.head) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 15, right: 15, bottom: 0),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(10),
//                                               topRight: Radius.circular(10),
//                                             )),
//                                         child: SettingListTitle(
//                                           name: settingModel.name,
//                                           state: state,
//                                           onTap: () {},
//                                         ),
//                                       ),
//                                       Container(
//                                         color: Colors.white,
//                                         child: const Padding(
//                                           padding: EdgeInsets.only(left: 20),
//                                           child: Divider(
//                                             color: Colors.black45,
//                                             height: 1,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               } else if (settingModel.position ==
//                                   SettingPosition.end) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 15, right: 15, top: 0),
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(10),
//                                           bottomRight: Radius.circular(10),
//                                         )),
//                                     child: SettingListTitle(
//                                       name: settingModel.name,
//                                       state: state,
//                                       onTap: () {
//                                         print('name = ${settingModel.name}');
//                                       },
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 15, right: 15),
//                                   child: Container(
//                                       decoration: const BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10))),
//                                       child: SettingListTitle(
//                                         name: settingModel.name,
//                                         state: state,
//                                         onTap: () {
//                                           if (settingModel.name == "變更祈福文") {
//                                             showWordAlertDialog(context,
//                                                 content: "輸入祈福文",
//                                                 title: settingModel.name,
//                                                 doneActon: () {});
//                                           }
//                                         },
//                                       )),
//                                 );
//                               }
//                             },
//                           ),
//                         ))
//                   ],
//                 );
//               }))),
//     );
//   }
// }
