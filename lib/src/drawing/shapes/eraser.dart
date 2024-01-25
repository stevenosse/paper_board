import 'package:flutter/material.dart';
import 'package:paper_board/src/drawing/shapes/sketch_base.dart';

class EraserSketch extends SketchBase {
  const EraserSketch({
    required super.points,
    required super.color,
    super.thickness,
    super.filled,
  });

  @override
  SketchBase copyWith(
      {List<Offset>? points, Color? color, double? thickness, bool? filled}) {
    return EraserSketch(
      points: points ?? this.points,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      filled: filled ?? this.filled,
    );
  }

  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.addPolygon(points, false);
    canvas.drawPath(path, paint);
  }

  @override
  String get type => 'eraser';
}
