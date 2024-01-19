import 'dart:ui';

import 'package:paper_board/paper_board.dart';

class Board {
  final List<SketchBase> sketches;
  final Color? backgroundColor;

  const Board({
    required this.sketches,
    this.backgroundColor,
  });

  Board copyWith({
    List<SketchBase>? sketches,
    Color? backgroundColor,
  }) {
    return Board(
      sketches: sketches ?? this.sketches,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}