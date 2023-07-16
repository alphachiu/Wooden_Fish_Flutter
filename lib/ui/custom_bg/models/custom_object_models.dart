import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';

class CustomObjectModel {
  CustomObjectModel(int ms, this.rect, List<double> r, Size size) :
  startTimeMs = ms,
  scale = lerpDouble(1, 0.3, r[0])!,
  rotation = pi * lerpDouble(-1, 1, r[2])!,
  xSimulation = FrictionSimulation(0.75, r[1] * size.width, lerpDouble(size.width / 2, -size.width / 2, r[1])!),
  ySimulation = GravitySimulation(lerpDouble(10, 1000, r[0])!, -rect.height / 2, size.height + rect.height / 2, 100);

  final int startTimeMs;
  final Rect rect;
  final Simulation xSimulation;
  final Simulation ySimulation;
  final double scale;
  final double rotation;

  double x(int ms) => xSimulation.x(_normalizeTime(ms));

  double y(int ms) => ySimulation.x(_normalizeTime(ms));

  bool isDead(int ms) => ySimulation.isDone(_normalizeTime(ms));

  double _normalizeTime(int ms) => (ms - startTimeMs) / Duration.millisecondsPerSecond;

  RSTransform transform(int ms, Size size) {
  final translateY = y(ms);
  return RSTransform.fromComponents(
  translateX: x(ms),
  translateY: translateY,
  anchorX: 0,
  anchorY: 0,
  rotation: rotation * translateY / size.height,
  scale: 1,
  );
  }
}