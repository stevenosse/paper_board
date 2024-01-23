import 'package:paper_board/paper_board.dart';

class AddSketchCommand implements UndoableCommand {
  final SketchBase sketch;
  final DrawingBoardController controller;

  AddSketchCommand({
    required this.sketch,
    required this.controller,
  });

  @override
  void execute() {
    final sketches =[...controller.sketches, sketch.sanitize()];
    controller.setSketches(sketches);
  }

  @override
  void undo() {
    controller.removeSketch(sketch);
  }

  @override
  void redo() {
    execute();
  }
}
