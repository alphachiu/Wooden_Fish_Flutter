import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/setting_bloc.dart';
import 'bloc/setting_event.dart';
import 'bloc/setting_state.dart';

class SettingListTitle extends StatelessWidget {
  const SettingListTitle(
      {Key? key, this.onTap, required this.name, required this.state})
      : super(key: key);

  final String name;
  final VoidCallback? onTap;
  final SettingWidgetState state;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingWidgetBloc>(context);
    Widget? switchWidget;
    Widget? trailing = Icon(Icons.chevron_right);
    if (name == "顯示祈福文") {
      switchWidget = Switch.adaptive(
          activeColor: const Color(0xff37CACF),
          value: state.setting.isDisplayPrayWord,
          onChanged: (isChange) {
            bloc.add(SwitchShowWordEvent(switchDisplay: isChange));
          });
      trailing = null;
    } else if (name == "震動") {
      switchWidget = Switch.adaptive(
          activeColor: const Color(0xff37CACF),
          value: state.setting.isVibration,
          onChanged: (isChange) {
            bloc.add(SwitchVibrationEvent(switchVibration: isChange));
          });
      trailing = null;
    }

    return ListTile(
      dense: true,
      onTap: onTap,
      trailing: trailing,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          switchWidget != null ? switchWidget : const SizedBox()
        ],
      ),
    );
  }
}
