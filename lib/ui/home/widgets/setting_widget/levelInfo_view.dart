import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';

import 'bloc/setting_state.dart';

class LevelInfoView extends StatefulWidget {
  const LevelInfoView({Key? key, required this.state}) : super(key: key);

  final SettingWidgetState state;

  @override
  State<LevelInfoView> createState() => _LevelInfoViewState();
}

class _LevelInfoViewState extends State<LevelInfoView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                '修行目標',
                style: TextStyle(fontSize: 30),
              ),
              AnotherStepper(
                stepperList: widget.state.stepperData,
                stepperDirection: Axis.vertical,
                iconWidth: 40,
                iconHeight: 40,
                activeBarColor: const Color(0xff37CACF),
                inActiveBarColor: Colors.grey,
                inverted: false,
                verticalGap: 30,
                activeIndex: widget.state.currentStepperInt,
                barThickness: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
