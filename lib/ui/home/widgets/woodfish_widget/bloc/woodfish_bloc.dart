import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/knock_text_widget.dart';

import 'woodfish_event.dart';
import 'woodfish_state.dart';

class Woodfish_widgetBloc
    extends Bloc<Woodfish_widgetEvent, Woodfish_widgetState> {
  List<Widget> _knockAnimationWidgets = [];

  Woodfish_widgetBloc() : super(Woodfish_widgetState().init()) {
    on<InitEvent>(_init);
    on<IncrementEvent>(_increment);
  }

  void _init(InitEvent event, Emitter<Woodfish_widgetState> emit) async {
    emit(state.clone());
  }

  void _increment(IncrementEvent event, Emitter<Woodfish_widgetState> emit) {
    state.totalCount++;
    KnockTextWidget knockWidget = KnockTextWidget(childWidget:const Text(
      "＋ 1",
      style: TextStyle(fontSize: 24.0),
    ),onRemove: (widget) async {
      await _removeWidget(widget);
    });

    _knockAnimationWidgets.add(Stack(
      children: [knockWidget],
    ));
    state.knockAnimationWidgets = _knockAnimationWidgets;
    emit(state.clone());
  }

  Future<void> _removeWidget(KnockTextWidget widget) async {
    if (widget.onRemove != null) {
      print('_removeWidget');
      _knockAnimationWidgets.remove(widget);
      state.knockAnimationWidgets = _knockAnimationWidgets;
    }
  }
}
