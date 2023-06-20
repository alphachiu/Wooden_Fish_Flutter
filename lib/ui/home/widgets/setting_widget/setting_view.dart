import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import 'bloc/setting_bloc.dart';
import 'bloc/setting_event.dart';
import 'bloc/setting_state.dart';

class Setting_widgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Setting_widgetBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<Setting_widgetBloc>(context);

    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: Color(0xFFF5F6F9),
              body: BlocBuilder<Setting_widgetBloc, Setting_widgetState>(
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
                          color: Color(0xFFF5F6F9),
                          child: GroupedListView<dynamic, String>(
                            elements: state.sections,
                            groupComparator: (value1, value2) =>
                                value2.compareTo(value1),
                            // itemComparator: (item1, item2) =>
                            //     item1['name'].compareTo(item2['name']),
                            // order: GroupedListOrder.DESC,
                            // useStickyGroupSeparators: true,
                            groupSeparatorBuilder: (String value) => Container(
                              color: Color(0xFFF5F6F9),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 20, bottom: 10, top: 10),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            groupBy: (element) {
                              return element['group'];
                            },
                            indexedItemBuilder: (context, element, index) {
                              print('index = ${index}');

                              if (element['name_start'] != null) {
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
                                        child:
                                            ListTitle(element['name_start']!),
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
                              } else if (element['name_end'] != null) {
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
                                    child: ListTitle(element['name_end']!),
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
                                    child: ListTitle(element['name']!),
                                  ),
                                );
                                ;
                              }
                            },
                          ),
                        ))
                  ],
                );
              }))),
    );
  }

  Widget ListTitle(String titleNam) {
    return ListTile(
      title: Text(
        titleNam,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}
