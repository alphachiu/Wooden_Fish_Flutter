import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/knock_text_widget.dart';
import 'package:woodenfish_bloc/utils/AudioPlayUtil.dart';
import 'woodfish_event.dart';
import 'woodfish_state.dart';

class Woodfish_widgetBloc
    extends Bloc<Woodfish_widgetEvent, Woodfish_widgetState> {


  Woodfish_widgetBloc({required  WoodenRepository woodenRepository}) :
        _woodenRepository = woodenRepository,
        super(Woodfish_widgetState().init()) {
    on<InitEvent>(_init);
    on<IncrementEvent>(_increment);
    on<IsAutoEvent>(_isAutoEvent);
  }

 final WoodenRepository _woodenRepository;
  final List<Widget> _knockAnimationWidgets = [];
  late Timer autoKnockTimer;


  void _init(InitEvent event, Emitter<Woodfish_widgetState> emit) async {

   // await _woodenRepository.deleteSetting();
    emit(state.clone());
  }

  void _increment(IncrementEvent event, Emitter<Woodfish_widgetState> emit) async{
    state.totalCount++;
    state.setting = _woodenRepository.getSetting();
    print('state.setting isDisplay = ${state.setting.isDisplay}');

    if(state.setting.isVibration){
      await HapticFeedback.vibrate();
    }

    if(state.setting.isDisplay){
      AudioPlayUtil().play('sounds/woodenFish_01.wav');

      KnockTextWidget knockWidget = KnockTextWidget(
          childWidget: const Text(
            "＋ 1",
            style: TextStyle(fontSize: 24.0),
          ),
          onRemove: (widget) async {
            await _removeWidget(widget);
          });

      _knockAnimationWidgets.add(Stack(
        children: [knockWidget],
      ));
      state.knockAnimationWidgets = _knockAnimationWidgets;
    }
    emit(state.clone());
  }

  void _isAutoEvent(IsAutoEvent event, Emitter<Woodfish_widgetState> emit) {
    state.isAuto = event.isAuto;

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
