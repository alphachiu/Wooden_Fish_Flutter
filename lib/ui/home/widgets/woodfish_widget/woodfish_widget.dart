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
          Scaffold(body: BlocBuilder<Woodfish_widgetBloc, Woodfish_widgetState>(
        builder: (context, state) {
          return Stack(
            children: [
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add)]),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '總共敲了${state.totalCount} 次',
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3,
                        left: 100,
                        right: 100),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: CustomPaint(
                        painter: MonkMuyuPainter(),
                        size: Size(100, 200),
                      ),
                      onTap: () {
                        bloc.add(TotalIncrementEvent());
                        bloc.add(TotalIncrementWidgetEvent());
                      },
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

class MonkMuyuPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    // 绘制木鱼的框架
    Path framePath = Path()
      ..moveTo(size.width * 0.4, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.6, size.height)
      ..lineTo(size.width * 0.5, size.height * 0.8)
      ..lineTo(size.width * 0.4, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(framePath, paint);

    // 绘制木鱼的撞击部分
    paint.color = Colors.red;
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.5),
      size.width * 0.15,
      paint,
    );

    // 绘制木鱼的敲击棍
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    canvas.drawLine(
      Offset(size.width * 0.5, size.height),
      Offset(size.width * 0.5, size.height * 0.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class KnockTextWidgets extends StatefulWidget {
  const KnockTextWidgets({Key? key, this.count}) : super(key: key);
  final int? count;

  @override
  State<KnockTextWidgets> createState() => _KnockTextWidgetsState();
}

class _KnockTextWidgetsState extends State<KnockTextWidgets>
    with SingleTickerProviderStateMixin {
  List<Widget> textAnimationWidgets = [];

  @override
  void didUpdateWidget(covariant KnockTextWidgets oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    KnockTextWidget textAnimationWidget = KnockTextWidget(onRemove: (widget) {
      print(" knock dispose 1");
      _removeWidget(widget);
      print("textAnimationWidgets length = ${textAnimationWidgets.length}");
    });
    textAnimationWidgets.add(textAnimationWidget);
    //  textAnimationWidget.onRemove = _removeWidget;

    // if (widget.count! > textAnimationWidgets.length) {
    //   for (int i = textAnimationWidgets.length; i < widget.count!; i++) {
    //     KnockTextWidget textAnimationWidget = KnockTextWidget();
    //     textAnimationWidgets.add(textAnimationWidget);
    //     textAnimationWidget.onRemove = _removeWidget;
    //   }
    // } else if (widget.count! < textAnimationWidgets.length) {
    //   int diff = textAnimationWidgets.length - widget.count!;
    //   for (int i = 0; i < diff; i++) {
    //     var a = (textAnimationWidgets[i]) as KnockTextWidget;
    //     _removeWidget(a);
    //   }
    // }

    // KnockTextWidget knockWidget = KnockTextWidget();
    // textAnimationWidgets.add(knockWidget);
    //
    // knockWidget.onRemove = _removeWidget;
  }

  void _removeWidget(KnockTextWidget widget) {
    if (widget.onRemove != null) {
      print('remove');
      textAnimationWidgets.remove(widget);
      // setState(() {
      //
      // });
    }

    // if (widget.onRemove != null) {
    //   widget.onRemove!(widget);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: textAnimationWidgets,
    );
  }
}
