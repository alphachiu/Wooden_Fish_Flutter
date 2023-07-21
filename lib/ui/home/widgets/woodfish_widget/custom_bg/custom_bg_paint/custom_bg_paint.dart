import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:woodenfish_bloc/ui/home/widgets/woodfish_widget/custom_bg/models/custom_object_models.dart';

class FallingBirdsPainter extends CustomPainter {
  FallingBirdsPainter({required this.objectImage, required this.notifier})
      : super(repaint: notifier);

  final ui.Image? objectImage;
  final ValueNotifier<Duration> notifier;
  final imagePaint = Paint();
  final backgroundPaint = Paint()..color = Colors.black26;
  final random = Random();
  final birds = <CustomObjectModel>[];
  int nextReport = 0;

  static const spriteRects = [
    Rect.fromLTRB(000, 0, 103, 140),
    Rect.fromLTRB(103, 0, 217, 140),
    Rect.fromLTRB(217, 0, 312, 140),
    Rect.fromLTRB(312, 0, 410, 140),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.drawPaint(backgroundPaint);
    if (objectImage != null) {
      final ms = DateTime.now().millisecondsSinceEpoch;
      if (random.nextDouble() < 0.30) {
        // drop new bird
        birds.add(CustomObjectModel(ms, spriteRects[random.nextInt(10)],
            List.generate(10, (i) => random.nextDouble()), size));
      }

      final transforms = birds.map((bird) => bird.transform(ms, size)).toList();
      final rects = birds.map((bird) => bird.rect).toList();

      canvas.drawAtlas(
          objectImage!, transforms, rects, null, null, null, imagePaint);

      // dead birds cleanup
      birds.removeWhere((bird) => bird.isDead(ms));

      if (ms >= nextReport) {
        nextReport = ms + 100;
        print('flying birds population: ${birds.length}');
      }
    }
  }

  @override
  bool shouldRepaint(FallingBirdsPainter oldDelegate) => false;
}
