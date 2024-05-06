import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';
import 'package:paper_board/src/drawing/painters/paper_board_painter.dart';
import 'package:paper_board/src/drawing/painters/sketch_painter.dart';

class PaperBoard extends StatefulWidget {
  const PaperBoard({
    super.key,
    this.controller,
    this.theme,
    this.readOnly = false,
  });

  final bool readOnly;
  final PaperBoardTheme? theme;
  final DrawingBoardController? controller;

  @override
  State<PaperBoard> createState() => _PaperBoardState();
}

class _PaperBoardState extends State<PaperBoard> {
  late final DrawingBoardController controller =
      widget.controller ?? DrawingBoardController();

  late bool _readOnly = widget.readOnly;

  void _onPointerDown(PointerDownEvent event) {
    if (_readOnly) return;

    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(event.position);

    controller.updateCurrentSketch(controller.currentSketch.copyWith(
      points: [...controller.currentSketch.points, offset],
    ));
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_readOnly) return;

    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(event.position);

    controller.updateCurrentSketch(controller.currentSketch.copyWith(
      points: [...controller.currentSketch.points, offset],
    ));
  }

  void _onPointerUp(PointerUpEvent event) {
    if (_readOnly) return;

    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(event.position);

    final sketch = controller.currentSketch.copyWith(
      points: [...controller.currentSketch.points, offset],
    );
    controller.addSketch(sketch);
    controller.resetCurrentSketch();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, snapshot) {
        return InteractiveViewer(
          onInteractionStart: (details) {
            if (details.pointerCount > 1) {
              _readOnly = true;
            }
          },
            
          onInteractionEnd: (details) {
            if (details.pointerCount <= 1) {
              Future.delayed(const Duration(milliseconds: 1000), () {
                _readOnly = widget.readOnly;
              });
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    color: widget.theme?.backgroundColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                  ),
                  RepaintBoundary(
                    key: controller.painterKey,
                    child: CustomPaint(
                      size: Size(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      ),
                      painter: PaperBoardPainter(
                        backgroundColor: widget.theme?.backgroundColor ??
                            Theme.of(context).scaffoldBackgroundColor,
                        sketches: [
                          ...controller.sketches,
                          // This fixes the issue with eraser not working
                          if (controller.currentSketch is EraserSketch)
                            controller.currentSketch
                        ],
                      ),
                    ),
                  ),
                  if (!_readOnly)
                    Listener(
                      onPointerUp: _onPointerUp,
                      onPointerMove: _onPointerMove,
                      onPointerDown: _onPointerDown,
                      child: RepaintBoundary(
                        child: CustomPaint(
                          size: Size(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          ),
                          painter: SketchPainter(
                            sketch: controller.currentSketch,
                          ),
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
