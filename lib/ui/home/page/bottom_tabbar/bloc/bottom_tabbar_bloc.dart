import 'package:bloc/bloc.dart';
import 'package:woodenfish_bloc/repository/wooden_repository.dart';

import 'bottom_tabbar_event.dart';
import 'bottom_tabbar_state.dart';

class BottomTabBarBloc extends Bloc<BottomTabBarEvent, BottomTabBarState> {
  BottomTabBarBloc({required WoodenRepository woodenRepository})
      : _woodenRepository = woodenRepository,
        super(BottomTabBarState().init()) {
    on<BTInitEvent>(_init);
    on<TipEvent>(_tipView);
    on<ChangeTypeEvent>(_changeType);
    on<InputLimitCountEvent>(_limitCount);
    on<CountDownEvent>(_countDown);
    on<CurrentCountEvent>(_currentCount);
  }
  final WoodenRepository _woodenRepository;

  void _init(BTInitEvent event, Emitter<BottomTabBarState> emit) async {
    emit(state.clone());
  }

  void _tipView(TipEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting.isAutoStop = event.isChange;
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);

    state.isHiddenTip = event.isChange;
    emit(state.clone());
  }

  void _changeType(
      ChangeTypeEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting.type = event.change;
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);

    state.currentType = event.change;
    emit(state.clone());
  }

  void _limitCount(
      InputLimitCountEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting.limitCount = event.limitCount;
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);

    state.limitCount = event.limitCount;
    emit(state.clone());
  }

  void _currentCount(
      CurrentCountEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting.currentCount = event.count;
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);

    state.currentCount = event.count;
    emit(state.clone());
  }

  void _countDown(CountDownEvent event, Emitter<BottomTabBarState> emit) async {
    //save autoKnock state
    state.autoKnockSetting.countDownCount = event.second;
    _woodenRepository.saveAutoKnockSetting(state.autoKnockSetting);

    state.limitCountDown = event.second;
    emit(state.clone());
  }
}
