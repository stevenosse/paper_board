import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paper_board/paper_board.dart';

void main() {
  late SketchSerializer serializer;

  setUp(() {
    serializer = const SketchSerializer();
  });

  group('[SketchSerializer] - ', () {
    test('Sketches are serialized', () {
      const sketch = PencilSketch(
        points: [Offset(1, 1)],
        color: Colors.red,
        thickness: 2,
      );

      final json = serializer.serialize(sketch);

      expect(json['type'], 'pencil');
      expect(json['points'], [
        {'x': 1.0, 'y': 1.0}
      ]);
      expect(json['color'], Colors.red.value);
      expect(json['thickness'], 2);
    });

    test('Sketches are serialized with default values', () {
      const sketch = PencilSketch(
        points: [Offset(1, 1)],
      );

      final json = serializer.serialize(sketch);

      expect(json['type'], 'pencil');
      expect(json['points'], [
        {'x': 1.0, 'y': 1.0}
      ]);
      expect(json['color'], null);
      expect(json['thickness'], kDefaultThickness);
    });
  });
}
