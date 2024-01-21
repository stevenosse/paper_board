import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

class SketchPainter extends CustomPainter {
  final SketchBase sketch;

  SketchPainter({required this.sketch});

  @override
  void paint(Canvas canvas, Size size) {
    if (!sketch.shouldDraw) {
      return;
    }

    if (sketch is! EraserSketch) {
      sketch.draw(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant SketchPainter oldDelegate) {
    return oldDelegate.sketch != sketch;
  }
}
