import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/knock_text_widget.dart';

import 'woodfish_event.dart';
import 'woodfish_state.dart';

class Woodfish_widgetBloc
    extends Bloc<Woodfish_widgetEvent, Woodfish_widgetState> {
  List<Widget> textAnimationWidgets = [];

  Woodfish_widgetBloc() : super(Woodfish_widgetState().init()) {
    on<InitEvent>(_init);
    on<TotalIncrementEvent>(_increment);
    on<TotalIncrementWidgetEvent>(_incrementWidget);
  }

  void _init(InitEvent event, Emitter<Woodfish_widgetState> emit) async {
    emit(state.clone());
  }

  void _incrementWidget(
      TotalIncrementWidgetEvent event, Emitter<Woodfish_widgetState> emit) {
    KnockTextWidget knockWidget = KnockTextWidget(onRemove: (widget) async {
      await _removeWidget(widget);
      state.textAnimationWidgets = textAnimationWidgets;
    });
    textAnimationWidgets.add(knockWidget);
    state.textAnimationWidgets = textAnimationWidgets;
  }

  void _increment(
      TotalIncrementEvent event, Emitter<Woodfish_widgetState> emit) {
    state.totalCount++;

    emit(state.clone());
  }

  Future<void> _removeWidget(KnockTextWidget widget) async {
    if (widget.onRemove != null) {
      print('_removeWidget');
      textAnimationWidgets.remove(widget);
    }
  }
}
