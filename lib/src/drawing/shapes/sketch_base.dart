import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';
import 'package:paper_board/src/utils/common_utils.dart';

abstract class SketchBase extends Equatable with DrawableSketch {
  const SketchBase({
    required this.points,
    required this.color,
    this.thickness = kDefaultThickness,
    this.filled = false,
  });

  final List<Offset> points;
  final double thickness;
  final bool filled;
  final Color color;

  String get type => 'base';

  @override
  bool get shouldDraw => true;

  @override
  void draw(Canvas canvas, Size size) {}

  @override
  List<Object?> get props => [points, thickness, filled, color];

  /// Prepare the sketch for drawing.
  ///
  /// This method is called before [draw] and can be used to prepare the sketch
  /// Wether to invert colors (to be used in dark mode) or any other preparation
  SketchBase prepare() => copyWith(
        color: switch ((
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark,
          isShadeOfWhite(color, kShadeTreshold),
          isShadeOfBlack(color, kShadeTreshold),
        )) {
          (true, true, _) => Colors.black,
          (true, _, true) => Colors.white,
          _ => color,
        },
      );

  @override
  SketchBase sanitize() => this;

  SketchBase copyWith({
    List<Offset>? points,
    Color? color,
    bool? filled,
    double? thickness,
  });
}
