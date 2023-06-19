import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/knock_text_widget.dart';

import 'bloc/woodfish_bloc.dart';
import 'bloc/woodfish_event.dart';
import 'bloc/woodfish_state.dart';

// class Woodfish_widgetPage extends StatefulWidget {
//   const Woodfish_widgetPage({Key? key}) : super(key: key);
//
//   @override
//   State<Woodfish_widgetPage> createState() => _Woodfish_windgePageState();
// }
//
// class _Woodfish_windgePageState extends State<Woodfish_widgetPage>
//     with SingleTickerProviderStateMixin {
//   List<Widget> textAnimationWidgets = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void didUpdateWidget(covariant Woodfish_widgetPage oldWidget) {
//     // TODO: implement didUpdateWidget
//     super.didUpdateWidget(oldWidget);
//     print('111');
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   Future<void> _removeWidget(KnockTextWidget widget) async {
//     if (widget.onRemove != null) {
//       // widget.onRemove!(widget);
//       print('_removeWidget');
//       textAnimationWidgets.remove(widget);
//
//       // setState(() {
//       //
//       // });
//     }
//   }
//
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
//     print("parant");
//     return SafeArea(
//       child:
//           Scaffold(body: BlocBuilder<Woodfish_widgetBloc, Woodfish_widgetState>(
//         builder: (context, state) {
//           return Stack(
//             children: [
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '總共敲了${state.totalCount} 次',
//                         style: TextStyle(fontSize: 30.0),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: MediaQuery.of(context).size.height * 0.3,
//                         left: 100,
//                         right: 100),
//                     child: InkWell(
//                       highlightColor: Colors.transparent,
//                       splashColor: Colors.transparent,
//                       child: Icon(
//                         Icons.heart_broken,
//                         size: 150.0,
//                       ),
//                       onTap: () {
//                         bloc.add(TotalIncrementEvent());
//                         bloc.add(TotalIncrementWidgetEvent());
//                         // KnockTextWidget knockWidget =
//                         //     KnockTextWidget(onRemove: (widget) async {
//                         //   await _removeWidget(widget);
//                         // });
//                         // textAnimationWidgets.add(knockWidget);
//                         //knockWidget.onRemove = _removeWidget;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Center(
//                 child: Column(children: state.textAnimationWidgets
//                     // [
//                     //   Center(
//                     //       child: KnockTextWidgets(
//                     //     count: state.totalCount,
//                     //   ))
//                     // ],
//                     ),
//               )
//             ],
//           );
//         },
//       )),
//     );
//   }
// }

class Woodfish_widgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Woodfish_widgetBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<Woodfish_widgetBloc>(context);

    return SafeArea(
      child:
          Scaffold(backgroundColor: Colors.redAccent,body: BlocBuilder<Woodfish_widgetBloc, Woodfish_widgetState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '總共敲了${state.totalCount} 次',
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ],
                      ),
                    ),
                  ), //MediaQuery.of(context).size.height
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Stack(children: state.knockAnimationWidgets),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: const Image(image: AssetImage('assets/images/wooden-fish.png'),width: 250,height: 250,),
                                onTap: () {
                                  bloc.add(IncrementEvent());
                                },
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
          );
        },
      )),
    );
  }
}
