import 'package:flutter/material.dart';
import 'package:paper_board/src/drawing/shapes/sketch_base.dart';

class SphereSketch extends SketchBase {
  SphereSketch({
    required super.points,
    super.color,
    super.thickness,
    super.filled,
  });

  @override
  String get type => 'sphere';

  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.black
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    if (points.length >= 2) {
      canvas.drawOval(Rect.fromPoints(points.first, points.last), paint);
    }
  }

  @override
  void sanitize() => points.removeRange(1, points.length - 1);

  @override
  SketchBase copyWith({List<Offset>? points, Color? color, double? thickness, bool? filled}) {
    return SphereSketch(
      points: points ?? this.points,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      filled: filled ?? this.filled,
    );
  }
}
