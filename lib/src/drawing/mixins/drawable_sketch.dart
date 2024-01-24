import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

mixin class DrawableSketch {
  bool get shouldDraw => true;

  /// Draw the sketch on the canvas.
  ///
  /// This method is called after [prepare] and can be used to draw the sketch
  void draw(Canvas canvas, Size size) {}

  /// Sanitize the sketch.
  ///
  /// This method is called each time a sketch is added to the [DrawingBoardController]
  void sanitize() {}
}
