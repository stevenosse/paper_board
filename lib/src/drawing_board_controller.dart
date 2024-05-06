import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paper_board/paper_board.dart';

const kDefaultThickness = 2.0;
const kDefaultEraserThickness = 5.0;

class DrawingBoardController extends ChangeNotifier {
  late GlobalKey painterKey = GlobalKey();

  DrawingBoardController({
    UndoService? undoService,
  }) : undoService = undoService ?? UndoService();

  Iterable<SketchBase> sketches = [];
  late Color sketchColor = Colors.black;
  late SketchBase currentSketch =
      PencilSketch(points: const [], color: sketchColor);

  double thickness = kDefaultThickness;
  double eraserThickness = kDefaultEraserThickness;

  bool fillSketches = false;

  final UndoService undoService;

  bool get canUndo => undoService.canUndo;
  bool get canRedo => undoService.canRedo;

  void resetCurrentSketch() {
    currentSketch = currentSketch.copyWith(
      points: const [],
      color: sketchColor,
      thickness: thickness,
      filled: fillSketches,
    );
  }

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

  void setSketches(Iterable<SketchBase> sketches) {
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
  Future<void> load({
    List<SketchBase> sketches = const [],
    Uint8List? image,
    Size? size = const Size(1080, 1920),
  }) async {
    setSketches(sketches);

    if (image != null) {
      final codec = await ui.instantiateImageCodec(
        image.buffer.asUint8List(),
        targetHeight: size?.height.toInt(),
        targetWidth: size?.width.toInt(),
      );
      var frame = await codec.getNextFrame();

      addSketch(ImageSketch(image: frame.image));
    }

    undoService.clear();

    notifyListeners();
  }

  void undo() {
    undoService.undo();
    notifyListeners();
  }

  void redo() {
    undoService.redo();
    notifyListeners();
  }

  Future<ByteData?> getImageData() async {
    try {
      final RenderRepaintBoundary boundary = painterKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(
        pixelRatio: View.of(painterKey.currentContext!).devicePixelRatio,
      );
      return await image.toByteData(format: ui.ImageByteFormat.png);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getPngData() async {
    final data = await getImageData();
    if (data == null) {
      return null;
    }
    return 'data:image/png;base64,${base64Encode(data.buffer.asUint8List())}';
  }
}
