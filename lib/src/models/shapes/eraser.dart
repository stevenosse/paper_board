import 'package:flutter/material.dart';
import 'package:paper_board/src/models/shapes/sketch_base.dart';

class EraserSketch extends SketchBase {
  EraserSketch({
    required super.points,
    super.color,
    super.thickness,
    super.filled,
  });

  @override
  SketchBase copyWith({List<Offset>? points, Color? color, double? thickness, bool? filled}) {
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
      ..color = color ?? Colors.white
      ..strokeWidth = thickness
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.addPolygon(points, false);
    canvas.drawPath(path, paint);
  }

  @override
  void sanitize() {}

  @override
  String get type => 'eraser';
}
