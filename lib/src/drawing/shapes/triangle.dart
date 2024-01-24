import 'package:flutter/material.dart';
import 'package:paper_board/src/drawing/shapes/sketch_base.dart';

class TriangleSketch extends SketchBase {
  const TriangleSketch({
    required super.points,
    required super.color,
    super.thickness,
    super.filled,
  });

  @override
  String get type => 'triangle';

  @override
  void draw(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke;

    if (points.length >= 2) {
      final ySideSize = points.first.distanceTo(points.last);
      final xSideSize = ySideSize * 2 / 3;

      final xCenter = points.first.dx;
      final yCenter = points.first.dy;

      final xLeft = xCenter - xSideSize / 2;
      final xRight = xCenter + xSideSize / 2;

      final yBottom = yCenter + ySideSize / 2;
      final yTop = yCenter - ySideSize / 2;

      final path = Path()
        ..moveTo(xCenter, yTop)
        ..lineTo(xRight, yBottom)
        ..lineTo(xLeft, yBottom)
        ..lineTo(xCenter, yTop);

      canvas.drawPath(path, paint);
    }
  }

  @override
  TriangleSketch sanitize() =>
      copyWith(points: [...points]..removeRange(1, points.length - 1));

  @override
  TriangleSketch copyWith(
      {List<Offset>? points, Color? color, double? thickness, bool? filled}) {
    return TriangleSketch(
      points: points ?? this.points,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      filled: filled ?? this.filled,
    );
  }
}

extension on Offset {
  double distanceTo(Offset other) {
    return (this - other).distance;
  }
}
