import 'package:flutter_test/flutter_test.dart';
import 'package:paper_board/paper_board.dart';

void main() {
  group('DrawingBoardController -', () {
    test('Set sketch updates the current sketch', () {
      final controller = DrawingBoardController();

      const sketch = PencilSketch(points: []);
      controller.setSketch(sketch);

      expect(controller.currentSketch, sketch);
    });

    test(
        'When non eraser sketch is set, it is copied with thickness and filled',
        () {
      final controller = DrawingBoardController();

      const sketch = PencilSketch(points: []);
      controller.setSketch(sketch);

      expect(controller.currentSketch.thickness, kDefaultThickness);
      expect(controller.currentSketch.filled, false);
    });

    test('When eraser sketch is set, it is copied with eraser thickness', () {
      final controller = DrawingBoardController();

      const sketch = EraserSketch(points: []);
      controller.setSketch(sketch);

      expect(controller.currentSketch.thickness, kDefaultEraserThickness);
    });

    test('Update current sketch updates the current sketch', () {
      final controller = DrawingBoardController();

      const sketch = PencilSketch(points: [Offset(1, 1)]);
      controller.updateCurrentSketch(sketch);

      expect(controller.currentSketch, sketch);
    });

    test('Remove sketch removes the sketch from the list', () {
      final controller = DrawingBoardController();

      const sketch = PencilSketch(points: [Offset(1, 1)]);
      controller.addSketch(sketch);
      controller.removeSketch(sketch);

      expect(controller.sketches, isEmpty);
    });

    test('Add sketch adds the sketch to the list', () {
      final controller = DrawingBoardController();

      const sketch = PencilSketch(points: [Offset(1, 1)]);
      controller.addSketch(sketch);

      expect(controller.sketches, [sketch]);
    });

    test('Set sketches sets the sketches', () {
      final controller = DrawingBoardController();

      const sketch = PencilSketch(points: [Offset(1, 1)]);
      controller.setSketches([sketch]);

      expect(controller.sketches, [sketch]);
    });

    test('Set fill sketches sets the fill sketches', () {
      final controller = DrawingBoardController();

      controller.setFillSketches(true);

      expect(controller.fillSketches, true);
    });

    test('Set fill sketches updates the current sketch', () {
      final controller = DrawingBoardController();

      const sketch = PencilSketch(points: [Offset(1, 1)]);
      controller.setSketch(sketch);
      controller.setFillSketches(true);

      expect(controller.currentSketch.filled, true);
    });

    test(
        'Set fill sketches does not update the current sketch if it is an eraser',
        () {
      final controller = DrawingBoardController();

      const sketch = EraserSketch(points: [Offset(1, 1)]);
      controller.setSketch(sketch);
      controller.setFillSketches(true);

      expect(controller.currentSketch.filled, false);
    });

    test('Set thickness sets the thickness', () {
      final controller = DrawingBoardController();

      controller.setThickness(10);

      expect(controller.thickness, 10);
    });

    test('Set thickness updates the current sketch', () {
      final controller = DrawingBoardController();

      const sketch = PencilSketch(points: [Offset(1, 1)]);
      controller.setSketch(sketch);
      controller.setThickness(10);

      expect(controller.currentSketch.thickness, 10);
    });

    test('Set thickness does not update the current sketch if it is an eraser',
        () {
      final controller = DrawingBoardController();

      const sketch = EraserSketch(points: [Offset(1, 1)]);
      controller.setSketch(sketch);
      controller.setThickness(10);

      expect(controller.currentSketch.thickness, kDefaultEraserThickness);
    });

    test('Can undo returns true if undo service can undo', () {
      final controller = DrawingBoardController();

      expect(controller.canUndo, false);

      controller.undoService.execute(AddSketchCommand(
        sketch: const PencilSketch(points: [Offset(1, 1)]),
        controller: controller,
      ));

      expect(controller.canUndo, true);
    });

    test('Can redo returns true if undo service can redo', () {
      final controller = DrawingBoardController();

      expect(controller.canRedo, false);

      controller.undoService.execute(AddSketchCommand(
        sketch: const PencilSketch(points: [Offset(1, 1)]),
        controller: controller,
      ));

      expect(controller.canRedo, false);

      controller.undoService.undo();

      expect(controller.canRedo, true);
    });

    test('Undo undoes the last command', () {
      final controller = DrawingBoardController();

      expect(controller.sketches, isEmpty);

      controller.undoService.execute(AddSketchCommand(
        sketch: const PencilSketch(points: [Offset(1, 1)]),
        controller: controller,
      ));

      expect(controller.sketches, isNotEmpty);

      controller.undo();

      expect(controller.sketches, isEmpty);
    });

    test('Redo redoes the last command', () {
      final controller = DrawingBoardController();

      expect(controller.sketches, isEmpty);

      controller.undoService.execute(AddSketchCommand(
        sketch: const PencilSketch(points: [Offset(1, 1)]),
        controller: controller,
      ));

      expect(controller.sketches, isNotEmpty);

      controller.undo();

      expect(controller.sketches, isEmpty);

      controller.redo();

      expect(controller.sketches, isNotEmpty);
    });

    test('Clear clears the sketches', () {
      final controller = DrawingBoardController();

      expect(controller.sketches, isEmpty);

      controller.undoService.execute(AddSketchCommand(
        sketch: const PencilSketch(points: [Offset(1, 1)]),
        controller: controller,
      ));

      expect(controller.sketches, isNotEmpty);

      controller.clear();

      expect(controller.sketches, isEmpty);
    });

    test('Serialize returns the serialized board', () {
      final controller = DrawingBoardController();

      expect(controller.save(), {"sketches": []});
    });

    test('Deserialize sets the sketches', () {
      final controller = DrawingBoardController();

      controller.load(Board.deserialize({"sketches": []}));

      expect(controller.sketches, isEmpty);
    });
  });
}
