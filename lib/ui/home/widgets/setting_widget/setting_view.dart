import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/widgets/setting_widget/levelInfo_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/setting_widget/setting_listTitle.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_bloc.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_event.dart'
    as wood_fish_b;
import 'package:woodenfish_bloc/utils/alert_dialog.dart';
import 'package:woodenfish_bloc/utils/route_paths.dart';
import 'package:woodenfish_bloc/utils/wooden_fish_util.dart';

import '../../../../repository/ads_repository.dart';
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
          woodenRepository: RepositoryProvider.of<WoodenRepository>(context),
          adsRepository: RepositoryProvider.of<AdsRepository>(context))
        ..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SettingWidgetBloc>(context);

    return BlocConsumer<SettingWidgetBloc, SettingWidgetState>(
        listener: (context, state) {
      state.isDisplayLevelList
          ? showLevelLine(context, state)
          : const SizedBox();
    }, builder: (context, state) {
      return BlocBuilder<SettingWidgetBloc, SettingWidgetState>(
          builder: (context, state) {
        var statusHeight = 0.0;
        var avatarPosition = 0.0;
        var avatarSize = 0.0;
        if (MediaQuery.of(context).size.width >
            MediaQuery.of(context).size.height) {
          statusHeight = 10;
          avatarSize = 80;
          avatarPosition = 80;
        } else {
          statusHeight = 64;
          avatarPosition = MediaQuery.of(context).size.height * 0.18;
          avatarSize = 150;
        }

        print('state level = ${state.setting.level}');
        state.levelName = WoodenFishUtil.internal()
            .getLevelNameElementFromString(state.setting.level);

        return Scaffold(
          backgroundColor: const Color(0xFFF5F6F9),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xff37CACF),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: statusHeight,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Text(
                                              '修行等級: ${state.levelName}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                bloc.add(
                                                    ReviewLevelStepperEvent());
                                              },
                                              child: ClipOval(
                                                  child: Container(
                                                height: 20,
                                                width: 20,
                                                color: Colors.blue,
                                                child: const Center(
                                                    child: Text(
                                                  "!",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await showTFDialog(context,
                                              controller: controller,
                                              content: "輸入您的修行者名稱(預設：靜心小僧)",
                                              title: "請輸入名稱",
                                              doneActon: (word) {
                                            bloc.add(
                                                EditeNameEvent(name: word));
                                          });
                                        },
                                        child: const Icon(
                                          Icons.edit_note,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "修行者: ${state.setting.userName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              color: const Color(0xFFF5F6F9),
                              child: GroupedListView(
                                padding: const EdgeInsets.only(top: 50),
                                shrinkWrap: true,
                                elements: state.sections,
                                groupComparator: (value1, value2) {
                                  return value2.compareTo(value1);
                                },
                                // itemComparator: (item1, item2) =>
                                //     item1.id.compareTo(item2.id),
                                // order: GroupedListOrder.DESC,
                                sort: false,
                                // useStickyGroupSeparators: true,
                                groupSeparatorBuilder: (String value) =>
                                    Container(
                                  color: const Color(0xFFF5F6F9),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 20,
                                        bottom: 10,
                                        top: 10),
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
                                              padding:
                                                  EdgeInsets.only(left: 20),
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
                                            print(
                                                'name = ${settingModel.name}');
                                            if (settingModel.name == '給予鼓勵') {
                                              showSupport(context);
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  } else if (settingModel.position ==
                                      SettingPosition.mid) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, bottom: 0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: SettingListTitle(
                                              name: settingModel.name,
                                              state: state,
                                              onTap: () {},
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Divider(
                                                color: Colors.black45,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, bottom: 0),
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: SettingListTitle(
                                            name: settingModel.name,
                                            state: state,
                                            onTap: () async {
                                              if (settingModel.name ==
                                                  "變更祈福文") {
                                                await showTFDialog(context,
                                                    controller: controller,
                                                    content: "輸入祈福文(預設：+1)",
                                                    title: settingModel.name,
                                                    doneActon: (word) {
                                                  if (word.isEmpty) {
                                                    bloc.add(
                                                        EditeDisplayWordEvent(
                                                            displayWord: "+1"));
                                                  } else {
                                                    bloc.add(
                                                        EditeDisplayWordEvent(
                                                            displayWord: word));
                                                  }
                                                });
                                              } else if (settingModel.name ==
                                                  "自動敲擊設置") {
                                                Navigator.pushNamed(context,
                                                    RoutePaths.autoSetting);
                                              } else if (settingModel.name ==
                                                  "佈景設置") {
                                                Navigator.pushNamed(context,
                                                    RoutePaths.personInfo);
                                              }
                                            },
                                          )),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            !state.nativeAdIsLoaded
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      color: Colors.white,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: 300,
                                          minHeight: 120,
                                          maxHeight: 150,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              (2 * 16),
                                        ),
                                        child: AdWidget(ad: state.nativeAd!),
                                      ),
                                    ))
                                : const SizedBox(),
                            const SizedBox(
                              height: 30,
                            ),
                            Text('Version: ${state.version}'),
                          ],
                        ),
                      ))
                ],
              ),
              Positioned(
                top: avatarPosition,
                child: InkWell(
                  onTap: () {
                    bloc.add(SavePersonAvatarEvent());
                  },
                  child: SizedBox(
                    height: avatarSize,
                    width: avatarSize,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: state.avatarPhoto?.image,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
    });
  }
}
