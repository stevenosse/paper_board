import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

class SketchDeserializer {
  const SketchDeserializer();

  // TODO: We need to find a way to be able to deserialize custom sketches
  SketchBase deserialize(Map<String, dynamic> json) {
    return switch (json['type']) {
      'line' => LineSketch(
          points: (json['points'] as List<dynamic>).map((e) => Offset(e[0], e[1])).toList(),
          color: json['color'] == null ? null : Color(json['color']),
          thickness: json['thickness'],
          filled: json['filled'] ?? false,
        ),
      'pencil' => PencilSketch(
          points: (json['points'] as List<dynamic>).map((e) => Offset(e[0], e[1])).toList(),
          color: json['color'] == null ? null : Color(json['color']),
          thickness: json['thickness'],
          filled: json['filled'] ?? false,
        ),
      'eraser' => EraserSketch(
          points: (json['points'] as List<dynamic>).map((e) => Offset(e[0], e[1])).toList(),
          color: json['color'] == null ? null : Color(json['color']),
          thickness: json['thickness'],
          filled: json['filled'] ?? false,
        ),
      'rectangle' => RectangleSketch(
          points: (json['points'] as List<dynamic>).map((e) => Offset(e[0], e[1])).toList(),
          color: json['color'] == null ? null : Color(json['color']),
          thickness: json['thickness'],
          filled: json['filled'] ?? false,
        ),
      'sphere' => SphereSketch(
          points: (json['points'] as List<dynamic>).map((e) => Offset(e[0], e[1])).toList(),
          color: json['color'] == null ? null : Color(json['color']),
          thickness: json['thickness'],
          filled: json['filled'] ?? false,
        ),
      'triangle' => TriangleSketch(
          points: (json['points'] as List<dynamic>).map((e) => Offset(e[0], e[1])).toList(),
          color: json['color'] == null ? null : Color(json['color']),
          thickness: json['thickness'],
          filled: json['filled'] ?? false,
        ),
      _ => SketchBase(
          points: (json['points'] as List<dynamic>).map((e) => Offset(e[0], e[1])).toList(),
          color: json['color'] == null ? null : Color(json['color']),
          thickness: json['thickness'],
          filled: json['filled'] ?? false,
        )
    };
  }
}
