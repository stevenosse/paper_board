import 'package:flutter/material.dart';
import 'package:paper_board/src/models/shapes/sketch_base.dart';

class PencilSketch extends SketchBase {
  PencilSketch({
    required super.points,
    super.color,
    super.thickness,
    super.filled,
  });

  @override
  String get type => 'pencil';

  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.black
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addPolygon(points, false);
    canvas.drawPath(path, paint);
  }

  @override
  void sanitize() {}

  @override
  SketchBase copyWith({List<Offset>? points, Color? color, double? thickness, bool? filled}) {
    return PencilSketch(
      points: points ?? this.points,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      filled: filled ?? this.filled,
    );
  }
}
