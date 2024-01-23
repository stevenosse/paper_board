import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:paper_board/paper_board.dart';

abstract class SketchBase extends Equatable with DrawableSketch {
  const SketchBase({
    required this.points,
    this.color,
    this.thickness = kDefaultThickness,
    this.filled = false,
  });

  final List<Offset> points;
  final double thickness;
  final bool filled;
  final Color? color;

  String get type => 'base';

  @override
  bool get shouldDraw => true;

  @override
  void draw(Canvas canvas, Size size) {}

  @override
  List<Object?> get props => [points, thickness, filled, color];

  @override
  SketchBase sanitize() => this;

  SketchBase copyWith({
    List<Offset>? points,
    Color? color,
    bool? filled,
    double? thickness,
  });
}
