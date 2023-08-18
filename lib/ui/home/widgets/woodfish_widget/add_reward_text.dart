import 'dart:math';
import 'package:flutter/material.dart';

class AddRewardText extends StatefulWidget {
  AddRewardText({Key? key, this.onRemove, this.childWidget}) : super(key: key);

  Widget? childWidget;
  Function(Key key)? onRemove;

  @override
  State<AddRewardText> createState() => _AddRewardTextState();
}

class _AddRewardTextState extends State<AddRewardText>
    with TickerProviderStateMixin {
  late AnimationController _curveAnimationController;
  late AnimationController _opacityAnimationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();

    _curveAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _opacityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _curveAnimation = CurvedAnimation(
        parent: _curveAnimationController, curve: Curves.fastOutSlowIn);

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(_opacityAnimationController);
    var rng = Random();
    var x = rng.nextInt(20).toDouble();
    var y = rng.nextInt(80).toDouble();
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -5))
            .animate(_curveAnimation);

    _curveAnimationController.forward();
    _opacityAnimationController.forward();

    _curveAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onRemove?.call(widget.key!);
      }
    });
  }

  @override
  void didUpdateWidget(covariant AddRewardText oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _curveAnimationController.forward(from: 0.0);
    _opacityAnimationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _curveAnimationController.dispose();
    _opacityAnimationController.dispose();

    widget.childWidget = null;
    widget.onRemove = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curveAnimationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: SlideTransition(
            position: _slideAnimation,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [widget.childWidget!],
            ),
          ),
        );
      },
    );
  }
}
