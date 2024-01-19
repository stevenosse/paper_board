import 'package:flutter/material.dart';
import 'package:paper_board/src/models/shapes/sketch_base.dart';

final class RectangleSketch extends SketchBase {
  RectangleSketch({
    required super.points,
    super.color,
    super.thickness,
    super.filled,
  });

  @override
  String get type => 'rectangle';

  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.black
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    if (points.length >= 2) {
      canvas.drawRect(Rect.fromPoints(points.first, points.last), paint);
    }
  }

  @override
  void sanitize() => points.removeRange(1, points.length - 1);

  @override
  SketchBase copyWith({
    List<Offset>? points,
    Color? color,
    bool? filled,
    double? thickness,
  }) {
    return RectangleSketch(
      points: points ?? this.points,
      color: color ?? this.color,
      filled: filled ?? this.filled,
      thickness: thickness ?? this.thickness,
    );
  }
}
