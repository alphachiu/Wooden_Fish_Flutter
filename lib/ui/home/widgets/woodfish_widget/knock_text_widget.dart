import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/repository/models/Local_setting.dart';

class KnockTextWidget extends StatefulWidget {
  KnockTextWidget(
      {Key? key, this.onRemove, this.childWidget, required this.isTopGod})
      : super(key: key);

  Widget? childWidget;
  bool isTopGod;
  Function(KnockTextWidget knock)? onRemove;

  @override
  State<KnockTextWidget> createState() => _KnockTextWidgetState();
}

class _KnockTextWidgetState extends State<KnockTextWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _rotationAnimationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _curveAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _rotationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _curveAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    var rng = Random();
    var x = rng.nextInt(20).toDouble();
    var y = rng.nextInt(80).toDouble();
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: Offset(x - 5, -80))
            .animate(_curveAnimation);

    var end = (rng.nextDouble() * 2) - 1;
    _rotationAnimation = Tween(begin: 0.0, end: widget.isTopGod ? end : 0.0)
        .animate(_rotationAnimationController);

    _scaleAnimation = Tween(begin: 1.0, end: widget.isTopGod ? 2.0 : 1.0)
        .animate(_rotationAnimationController);

    _animationController.forward();
    _rotationAnimationController.forward();

    _curveAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('_animation finish');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onRemove?.call(widget);
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant KnockTextWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _animationController.forward(from: 0.0);
    _rotationAnimationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationAnimationController.dispose();
    widget.childWidget = null;
    widget.onRemove = null;

    super.dispose();
    print("knock dispose");
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: SlideTransition(
            position: _slideAnimation,
            child: RotationTransition(
              alignment: Alignment.center,
              turns: _rotationAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [widget.childWidget!],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
