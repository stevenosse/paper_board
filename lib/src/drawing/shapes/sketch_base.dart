import 'package:flutter/widgets.dart';
import 'package:paper_board/src/drawing/mixins/drawable_sketch.dart';

abstract class SketchBase with DrawableSketch {
  SketchBase({
    required this.points,
    this.color,
    this.thickness = 2,
    this.filled = false,
  });

  List<Offset> points;
  final double thickness;
  final bool filled;
  final Color? color;

  String get type => 'base';

  @override
  bool get shouldDraw => true;

  @override
  void draw(Canvas canvas, Size size) {}

  @override
  void sanitize() {}

  SketchBase copyWith({
    List<Offset>? points,
    Color? color,
    bool? filled,
    double? thickness,
  });
}
