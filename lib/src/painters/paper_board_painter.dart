import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

class PaperBoardPainter extends CustomPainter {
  final List<SketchBase> sketches;

  PaperBoardPainter({required this.sketches});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());

    for (final sketch in sketches) {
      if (sketch.shouldDraw) {
        sketch.draw(canvas, size);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant PaperBoardPainter oldDelegate) {
    return oldDelegate.sketches != sketches;
  }
}