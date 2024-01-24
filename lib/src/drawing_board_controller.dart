import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

const kDefaultThickness = 2.0;
const kDefaultEraserThickness = 5.0;

class DrawingBoardController extends ChangeNotifier {
  final Board initialBoard;
  final SketchSerializer? serializer;

  DrawingBoardController({
    this.initialBoard = const Board(sketches: []),
    UndoService? undoService,
    this.serializer,
  })  : undoService = undoService ?? UndoService(),
        sketches = initialBoard.sketches;

  late SketchBase currentSketch =
      PencilSketch(points: const [], color: sketchColor);
  List<SketchBase> sketches = [];
  Color sketchColor = Colors.black;

  double thickness = kDefaultThickness;
  double eraserThickness = kDefaultEraserThickness;

  bool fillSketches = false;

  final UndoService undoService;

  bool get canUndo => undoService.canUndo;
  bool get canRedo => undoService.canRedo;

  void setSketchColor(Color color) {
    if (currentSketch is! EraserSketch) {
      currentSketch = currentSketch.copyWith(color: color);
    }
    sketchColor = color;
    notifyListeners();
  }

  void setSketch(SketchBase sketch) {
    if (sketch is EraserSketch) {
      currentSketch = sketch.copyWith(thickness: eraserThickness);
    } else {
      currentSketch =
          sketch.copyWith(thickness: thickness, filled: fillSketches);
    }
    notifyListeners();
  }

  void updateCurrentSketch(SketchBase sketch) {
    currentSketch = sketch;
    notifyListeners();
  }

  void removeSketch(SketchBase sketch) {
    sketches = sketches.where((s) => s != sketch).toList();
    notifyListeners();
  }

  void addSketch(SketchBase sketch) {
    undoService.execute(AddSketchCommand(
      sketch: sketch,
      controller: this,
    ));
    notifyListeners();
  }

  void setSketches(List<SketchBase> sketches) {
    this.sketches = sketches;
    notifyListeners();
  }

  /// Determines whether the current sketch should be filled
  void setFillSketches(bool value) {
    fillSketches = value;
    if (currentSketch is! EraserSketch) {
      currentSketch = currentSketch.copyWith(filled: value);
    }
    notifyListeners();
  }

  /// Sets the thickness of the current sketch
  void setThickness(double thickness) {
    if (currentSketch is! EraserSketch) {
      currentSketch = currentSketch.copyWith(thickness: thickness);
    }
    this.thickness = thickness;
    notifyListeners();
  }

  /// Sets the thickness of the eraser
  void setEraserThickness(double thickness) {
    eraserThickness = thickness;
    if (currentSketch is EraserSketch) {
      currentSketch = currentSketch.copyWith(thickness: thickness);
    }
    notifyListeners();
  }

  void clear() {
    sketches = [];
    notifyListeners();
  }

  /// Returns a JSON representation of the current board
  ///
  /// Uses the default serializer if none is provided
  Map<String, dynamic> save() {
    final board = Board(
      sketches: sketches,
    );

    return board.serialize(serializer: serializer);
  }

  /// Loads a board from a JSON representation
  ///
  /// Example:
  /// ```json
  /// {
  ///     "sketches": [
  ///      {
  ///          "type": "pencil",
  ///          "points": [
  ///              {
  ///                  "x": 71.14285714285714,
  ///                  "y": 148.85714285714286
  ///              },
  ///             ...
  ///          ],
  ///          "color": null,
  ///          "thickness": 2.0
  ///      },
  /// }
  /// ```
  void load(Board board) {
    setSketches(board.sketches);
  }

  void undo() {
    undoService.undo();
    notifyListeners();
  }

  void redo() {
    undoService.redo();
    notifyListeners();
  }
}
