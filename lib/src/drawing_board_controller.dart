import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

class DrawingBoardController extends ChangeNotifier {
  DrawingBoardController({
    UndoService? undoService,
  }) : undoService = undoService ?? UndoService();

  SketchBase currentSketch = PencilSketch(points: []);
  List<SketchBase> sketches = [];

  double thickness = 2.0;
  double eraserThickness = 5.0;

  final UndoService undoService;

  bool get canUndo => undoService.canUndo;
  bool get canRedo => undoService.canRedo;

  void undo() {
    undoService.undo();
    notifyListeners();
  }

  void redo() {
    undoService.redo();
    notifyListeners();
  }

  void setSketch(SketchBase sketch) {
    if (sketch is EraserSketch) {
      currentSketch = sketch.copyWith(thickness: eraserThickness);
    } else {
      currentSketch = sketch;
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

  void setThickness(double thickness) {
    currentSketch = currentSketch.copyWith(thickness: thickness);
    this.thickness = thickness;
    notifyListeners();
  }

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
}
