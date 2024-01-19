import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

class DrawingBoardController extends ChangeNotifier {
  SketchBase currentSketch = PencilSketch(points: []);
  List<SketchBase> sketches = [];

  void clear() {
    sketches = [];
    notifyListeners();
  }

  void setSketch(SketchBase sketch) {
    currentSketch = sketch;
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
}
