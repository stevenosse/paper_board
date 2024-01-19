import 'package:flutter/material.dart';
import 'package:paper_board/src/models/shapes/sketch_base.dart';

class LineSketch extends SketchBase {
  LineSketch({
    required super.points,
    super.color,
    super.filled,
    super.thickness,
  });

  @override
  String get type => 'line';

  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    if (points.length >= 2) {
      canvas.drawLine(points.first, points.last, paint);
    }
  }

  @override
  void sanitize() => points.removeRange(1, points.length - 1);

  @override
  SketchBase copyWith({List<Offset>? points, Color? color, bool? filled, double? thickness}) {
    return LineSketch(
      points: points ?? this.points,
      color: color ?? this.color,
      filled: filled ?? this.filled,
      thickness: thickness ?? this.thickness,
    );
  }
}
