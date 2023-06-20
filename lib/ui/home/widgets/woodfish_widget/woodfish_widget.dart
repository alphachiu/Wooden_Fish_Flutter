import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/knock_text_widget.dart';

import 'bloc/woodfish_bloc.dart';
import 'bloc/woodfish_event.dart';
import 'bloc/woodfish_state.dart';

class Woodfish_widgetPage extends StatefulWidget {
  const Woodfish_widgetPage({Key? key}) : super(key: key);

  @override
  State<Woodfish_widgetPage> createState() => _Woodfish_windgePageState();
}

class _Woodfish_windgePageState extends State<Woodfish_widgetPage>
    with SingleTickerProviderStateMixin {
  late Timer autoKnockTimer;
  late int milliseconds = 500;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void startAuto(Woodfish_widgetBloc bloc) {
    autoKnockTimer =
        Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      bloc.add(IncrementEvent());
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
      create: (BuildContext context) => Woodfish_widgetBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<Woodfish_widgetBloc>(context);
    print("parant");
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocBuilder<Woodfish_widgetBloc, Woodfish_widgetState>(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
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
                                    Text(state.isAuto ? '自動' : '手動',
                                        style: TextStyle(fontSize: 20.0)),
                                    Switch(
                                        value: state.isAuto,
                                        onChanged: (isChange) {
                                          bloc.add(
                                              IsAutoEvent(isAuto: isChange));
                                          //milliseconds += 2000;
                                          if (!isChange) {
                                            stopAuto();
                                          } else {
                                            startAuto(bloc);
                                          }
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ), //MediaQuery.of(context).size.height
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              bloc.add(IncrementEvent());
                            },
                            child: Container(
                              // color: Colors.yellow,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Stack(
                                          children:
                                              state.knockAnimationWidgets),
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
                        ),
                      ],
                    ),
                  ],
                );
              },
            )),
      ),
    );
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