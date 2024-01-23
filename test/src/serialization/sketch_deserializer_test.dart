import 'package:flutter_test/flutter_test.dart';
import 'package:paper_board/paper_board.dart';

void main() {
  late SketchDeserializer deserializer;

  setUp(() {
    deserializer = const SketchDeserializer();
  });

  group('[SketchDeserializer] - ', () {
    test('Pencil sketches are deserialized', () {
      final json = {
        'type': 'pencil',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
        'thickness': 2.0,
        'filled': true,
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<PencilSketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, 2);
      expect(sketch.filled, true);
    });

    test('Line sketches are deserialized', () {
      final json = {
        'type': 'line',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
        'thickness': 2.0,
        'filled': true,
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<LineSketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, 2);
      expect(sketch.filled, true);
    });

    test('Eraser sketches are deserialized', () {
      final json = {
        'type': 'eraser',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
        'thickness': 2.0,
        'filled': true,
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<EraserSketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, 2);
      expect(sketch.filled, true);
    });

    test('Rectangle sketches are deserialized', () {
      final json = {
        'type': 'rectangle',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
        'thickness': 2.0,
        'filled': true,
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<RectangleSketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, 2);
      expect(sketch.filled, true);
    });

    test('Sphere sketches are deserialized', () {
      final json = {
        'type': 'sphere',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
        'thickness': 2.0,
        'filled': true,
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<SphereSketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, 2);
      expect(sketch.filled, true);
    });

    test('Triangle sketches are deserialized', () {
      final json = {
        'type': 'triangle',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
        'thickness': 2.0,
        'filled': true,
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<TriangleSketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, 2);
      expect(sketch.filled, true);
    });

    test('Empty sketches are deserialized', () {
      final json = {
        'type': 'empty',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
        'thickness': 2.0,
        'filled': true,
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<EmptySketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, 2);
      expect(sketch.filled, true);
    });

    test('Sketches are deserialized with default values', () {
      final json = {
        'type': 'empty',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<EmptySketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, kDefaultThickness);
      expect(sketch.filled, false);
    });

    test('Sketches are deserialized with default values', () {
      final json = {
        'type': 'empty',
        'points': [
          {'x': 1.0, 'y': 1.0}
        ],
      };

      final sketch = deserializer.deserialize(json);

      expect(sketch, isA<EmptySketch>());
      expect(sketch.points, [const Offset(1, 1)]);
      expect(sketch.color, isNull);
      expect(sketch.thickness, kDefaultThickness);
      expect(sketch.filled, false);
    });
  });
}
