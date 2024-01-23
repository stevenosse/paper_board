import 'package:paper_board/paper_board.dart';
import 'package:paper_board/src/drawing/shapes/sketch_base.dart';

class SketchSerializer {
  const SketchSerializer();

  Map<String, dynamic> serialize(SketchBase sketch) {
    return {
      'type': sketch.type,
      'points': sketch.points.map((e) => {'x': e.dx, 'y': e.dy}).toList(),
      'color': sketch.color?.value,
      'thickness': sketch.thickness,
    };
  }
}
