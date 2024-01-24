import 'dart:ui';

import 'package:paper_board/src/drawing/shapes/sketch_base.dart';

class EmptySketch extends SketchBase {
  const EmptySketch({
    required super.points,
    required super.color,
    super.thickness,
    super.filled,
  });

  @override
  bool get shouldDraw => false;

  @override
  SketchBase copyWith(
      {List<Offset>? points, Color? color, bool? filled, double? thickness}) {
    return EmptySketch(
      points: points ?? this.points,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      filled: filled ?? this.filled,
    );
  }

  @override
  void draw(Canvas canvas, Size size) {}

  @override
  String get type => 'empty';
}
