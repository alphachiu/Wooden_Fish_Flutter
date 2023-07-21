import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/bloc/person_info_state.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/person_info_bg_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/person_info_sound_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/pserson_info_skin_view.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_bloc.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/bloc/woodfish_event.dart';

import 'bloc/person_info_bloc.dart';
import 'bloc/person_info_event.dart';

class PersonInfoPage extends StatelessWidget {
  const PersonInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PersonInfoBloc(
          woodenRepository: RepositoryProvider.of<WoodenRepository>(context))
        ..add(PersonInfoInitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<PersonInfoBloc>(context);
    final woodenFishBloc = context.read<WoodFishWidgetBloc>();

    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xff37CACF),
                shadowColor: Colors.transparent,
                title: const Text('佈景設置'),
              ),
              body: BlocBuilder<PersonInfoBloc, PersonInfoState>(
                  builder: (context, state) {
                return Container(
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
                      var titleName = element.name;
                      var groupName = element.group;
                      var elementList = element.elementList;
                      List<ElementModel<WoodenFishBgElement, Color>>?
                          bgElementList;
                      List<ElementModel<WoodenFishSkinElement, Image>>?
                          skinElementList;
                      List<ElementModel<WoodenFishSoundElement, String>>?
                          soundElementList;

                      if (elementList
                          is List<ElementModel<WoodenFishBgElement, Color>>) {
                        bgElementList = elementList;
                      } else if (elementList
                          is List<ElementModel<WoodenFishSkinElement, Image>>) {
                        skinElementList = elementList;
                      } else if (elementList is List<
                          ElementModel<WoodenFishSoundElement, String>>) {
                        soundElementList = elementList;
                      }

                      if (groupName == "背景設置") {
                        return PersonInfoBgView(
                            titleName: titleName,
                            gridsElement: bgElementList ?? [],
                            state: state,
                            onTap: (index) {
                              print('index = $index');
                              bloc.add(SelectBgEvent(
                                  currentBg: bgElementList![index].name));
                              woodenFishBloc.add(ChangWoodenFishStateEvent());
                            },
                            switchOnTap: (isChange) {
                              bloc.add(SwitchPrayEvent(switchPray: isChange));
                              woodenFishBloc.add(ChangWoodenFishStateEvent());
                            });
                      } else if (groupName == "木魚外觀") {
                        return PersonInfoSkinView(
                            gridsElement: skinElementList ?? [],
                            state: state,
                            onTap: (index) {
                              print('index = $index');
                              bloc.add(SelectSkinEvent(
                                  currentSkin: skinElementList![index].name));
                              woodenFishBloc.add(ChangWoodenFishStateEvent());
                            });
                      } else if (groupName == "聲音設置") {
                        return PersonInfoSoundView(
                            gridsElement: soundElementList ?? [],
                            state: state,
                            onTap: (index) {
                              print('index = $index');
                              bloc.add(SelectSoundEvent(
                                  currentSound: soundElementList![index].name));

                              woodenFishBloc.add(ChangWoodenFishStateEvent());
                            });
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                );
              }))),
    );
  }
}
