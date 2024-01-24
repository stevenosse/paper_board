import 'package:flutter/material.dart';
import 'package:paper_board/src/drawing/shapes/sketch_base.dart';

const kShadeTreshold = 200;

class PencilSketch extends SketchBase {
  const PencilSketch({
    required super.points,
    required super.color,
    super.thickness,
    super.filled,
  });

  @override
  String get type => 'pencil';

  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addPolygon(points, false);
    canvas.drawPath(path, paint);
  }

  @override
  PencilSketch copyWith({List<Offset>? points, Color? color, double? thickness, bool? filled}) {
    return PencilSketch(
      points: points ?? this.points,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      filled: filled ?? this.filled,
    );
  }
}
