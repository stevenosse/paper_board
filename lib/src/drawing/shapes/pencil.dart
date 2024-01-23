import 'package:flutter/material.dart';
import 'package:paper_board/src/drawing/shapes/sketch_base.dart';

class PencilSketch extends SketchBase {
  const PencilSketch({
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
  PencilSketch sanitize() {
    final sanitizedPoints = <Offset>{...points};
    for (var i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final distance = (p1.distance - p2.distance).abs();
      if (distance < 0.5) {
        sanitizedPoints.remove(p1);
      }
    }

    return copyWith(points: sanitizedPoints.toList());
  }

  @override
  PencilSketch copyWith(
      {List<Offset>? points, Color? color, double? thickness, bool? filled}) {
    return PencilSketch(
      points: points ?? this.points,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      filled: filled ?? this.filled,
    );
  }
}
