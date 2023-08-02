import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';

import 'bloc/setting_state.dart';

class LevelInfoView extends StatelessWidget {
  const LevelInfoView({Key? key, required this.state}) : super(key: key);

  final SettingWidgetState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            '修行目標',
            style: TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 20),
            child: AnotherStepper(
              stepperList: state.stepperData,
              stepperDirection: Axis.vertical,
              iconWidth: 40,
              iconHeight: 40,
              activeBarColor: Colors.green,
              inActiveBarColor: Colors.grey,
              inverted: false,
              verticalGap: 30,
              activeIndex: state.currentStepperInt,
              barThickness: 8,
            ),
          ),
        ],
      ),
    );
  }
}
