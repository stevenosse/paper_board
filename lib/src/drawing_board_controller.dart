import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

class DrawingBoardController extends ChangeNotifier {
  SketchBase currentSketch = PencilSketch(points: []);
  List<SketchBase> sketches = [];

  double thickness = 2.0;
  double eraserThickness = 5.0;

  void clear() {
    sketches = [];
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

  void addSketch(SketchBase sketch) {
    sketches = [...sketches, sketch];
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
}
