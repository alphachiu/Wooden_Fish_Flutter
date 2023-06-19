import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class KnockTextWidget extends StatefulWidget {
  KnockTextWidget({Key? key, this.onRemove}) : super(key: key);

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
      duration: Duration(seconds: 1),
    );

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    var rng = Random();
    var x = rng.nextInt(20).toDouble();
    var y = rng.nextInt(20).toDouble();
    _slideAnimation =
        Tween<Offset>(begin: const Offset(1, 1), end: Offset(x - 5, -y))
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
            child: Text(
              "＋ 1",
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        );
      },
    );
  }
}
