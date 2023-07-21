import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class KnockTextWidget extends StatefulWidget {
  KnockTextWidget({Key? key, this.onRemove, this.childWidget})
      : super(key: key);

  Widget? childWidget;
  Function(KnockTextWidget knock)? onRemove;

  @override
  State<KnockTextWidget> createState() => _KnockTextWidgetState();
}

class _KnockTextWidgetState extends State<KnockTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    var rng = Random();
    var x = rng.nextInt(20).toDouble();
    var y = rng.nextInt(80).toDouble();
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: Offset(x - 5, -80))
            .animate(_animation);

    _animationController.forward();

    _animation.addStatusListener((status) {
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
  }

  @override
  void dispose() {
    _animationController.dispose();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: widget.childWidget!),
              ],
            ),
          ),
        );
      },
    );
  }
}
