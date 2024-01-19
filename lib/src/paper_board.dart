import 'package:flutter/material.dart';
import 'package:paper_board/src/drawing_board_controller.dart';
import 'package:paper_board/src/models/shapes/sketch_base.dart';

class PaperBoard extends StatefulWidget {
  const PaperBoard({
    super.key,
    this.controller,
  });

  final DrawingBoardController? controller;

  @override
  State<PaperBoard> createState() => _PaperBoardState();
}

class _PaperBoardState extends State<PaperBoard> {
  late final DrawingBoardController controller = widget.controller ?? DrawingBoardController();

  void _onPointerDown(PointerDownEvent event) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(event.position);

    controller.updateCurrentSketch(controller.currentSketch.copyWith(
      points: [...controller.currentSketch.points, offset],
    ));
  }

  void _onPointerMove(PointerMoveEvent event) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(event.position);

    controller.updateCurrentSketch(controller.currentSketch.copyWith(
      points: [...controller.currentSketch.points, offset],
    ));
  }

  void _onPointerUp(PointerUpEvent event) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(event.position);

    controller.sketches.add(controller.currentSketch.copyWith(
      points: [...controller.currentSketch.points, offset],
    )..sanitize());
    controller.currentSketch = controller.currentSketch.copyWith(points: []);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, snapshot) {
        return Column(
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: RepaintBoundary(
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: CustomPaint(
                          painter: _PaperBoardPainter(sketches: controller.sketches),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Listener(
                          onPointerUp: _onPointerUp,
                          onPointerMove: _onPointerMove,
                          onPointerDown: _onPointerDown,
                          child: CustomPaint(
                            painter: _SketchPainter(sketch: controller.currentSketch),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PaperBoardPainter extends CustomPainter {
  final List<SketchBase> sketches;

  _PaperBoardPainter({required this.sketches});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());

    for (final sketch in sketches) {
      if (sketch.shouldDraw) {
        sketch.draw(canvas, size);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PaperBoardPainter oldDelegate) {
    return oldDelegate.sketches != sketches;
  }
}

class _SketchPainter extends CustomPainter {
  final SketchBase sketch;

  _SketchPainter({required this.sketch});

  @override
  void paint(Canvas canvas, Size size) {
    if (!sketch.shouldDraw) {
      return;
    }
    
    canvas.saveLayer(Offset.zero & size, Paint());
    sketch.draw(canvas, size);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SketchPainter oldDelegate) {
    return oldDelegate.sketch != sketch;
  }
}
