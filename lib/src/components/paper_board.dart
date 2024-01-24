import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';
import 'package:paper_board/src/drawing/painters/paper_board_painter.dart';
import 'package:paper_board/src/drawing/painters/sketch_painter.dart';

class PaperBoard extends StatefulWidget {
  const PaperBoard({
    super.key,
    this.controller,
    this.theme,
  });

  final PaperBoardTheme? theme;
  final DrawingBoardController? controller;

  @override
  State<PaperBoard> createState() => _PaperBoardState();
}

class _PaperBoardState extends State<PaperBoard> {
  late final DrawingBoardController controller =
      widget.controller ?? DrawingBoardController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.setSketchColor(widget.theme?.defaultSketchColor ??
          Theme.of(context).colorScheme.onBackground);
    });
    super.initState();
  }

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

    final sketch = controller.currentSketch.copyWith(
      points: [...controller.currentSketch.points, offset],
    );
    controller.addSketch(sketch);
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
                  border: Border.all(
                      color: widget.theme?.borderColor ??
                          Theme.of(context).colorScheme.onSurface),
                  color: widget.theme?.backgroundColor ??
                      Theme.of(context).colorScheme.background,
                ),
                child: RepaintBoundary(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          CustomPaint(
                            size: Size.fromHeight(constraints.maxHeight),
                            painter: PaperBoardPainter(
                              backgroundColor: widget.theme?.backgroundColor,
                              sketches: [
                                ...controller.sketches,
                                // This fixes the issue with eraser not working
                                if (controller.currentSketch is EraserSketch)
                                  controller.currentSketch
                              ],
                            ),
                          ),
                          Listener(
                            onPointerUp: _onPointerUp,
                            onPointerMove: _onPointerMove,
                            onPointerDown: _onPointerDown,
                            child: CustomPaint(
                              size: Size.fromHeight(constraints.maxHeight),
                              painter: SketchPainter(
                                  sketch: controller.currentSketch),
                            ),
                          )
                        ],
                      );
                    },
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
