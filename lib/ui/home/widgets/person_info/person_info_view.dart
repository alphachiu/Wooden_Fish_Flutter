import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:woodenfish_bloc/repository/models/setting_model.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/widgets/person_info/bloc/person_info_state.dart';
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
                title: const Text('個人資訊'),
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
                      var gridsElement = element.element;

                      return (gridsElement != null && gridsElement.isNotEmpty)
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 20,
                                              crossAxisCount: 5,
                                              childAspectRatio: 1.5),
                                      itemCount: gridsElement?.length,
                                      itemBuilder: (context, index) {
                                        var bgColor =
                                            gridsElement[index].element;
                                        var isSelectBg = state.currentBg ==
                                            gridsElement[index].bgName;
                                        var isDefault =
                                            gridsElement[index].bgName ==
                                                BgElement.none;
                                        return GestureDetector(
                                          onTap: () {
                                            bloc.add(SelectBgEvent(
                                                currentBg: gridsElement[index]
                                                    .bgName));
                                            woodenFishBloc.add(ChangBgEvent());
                                          },
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 5,
                                                    color: isSelectBg
                                                        ? const Color(
                                                            0xff37CACF)
                                                        : Colors.transparent),
                                                shape: BoxShape.circle,
                                                color: bgColor,
                                              ),
                                              child: isDefault
                                                  ? const Center(
                                                      child: Text('預設',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.blue)),
                                                    )
                                                  : const SizedBox()),
                                        );
                                      }),
                                ),
                              ),
                            )
                          : SizedBox();
                    },
                  ),
                );
              }))),
    );
  }
}
