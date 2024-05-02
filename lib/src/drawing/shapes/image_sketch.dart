import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide Image;
import 'package:paper_board/paper_board.dart';

final class ImageSketch extends SketchBase {
  const ImageSketch({
    required this.image,
  }) : super(
          color: Colors.transparent,
          points: const [],
          thickness: 0,
          filled: false,
        );

  final ui.Image image;

  @override
  SketchBase copyWith({
    List<Offset>? points,
    Color? color,
    bool? filled,
    double? thickness,
    Uint8List? pngData,
  }) {
    return ImageSketch(
      image: image,
    );
  }

  @override
  Future<void> draw(Canvas canvas, Size size) async {
    canvas.drawImage(image, Offset.zero, Paint());
  }
}
