import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';
import 'package:paper_board/src/components/size_selector_widget.dart';

class PaperBoardToolbar extends StatefulWidget {
  const PaperBoardToolbar({super.key, required this.controller});

  final DrawingBoardController controller;

  @override
  State<PaperBoardToolbar> createState() => _PaperBoardToolbarState();
}

class _PaperBoardToolbarState extends State<PaperBoardToolbar> {
  DrawingBoardController get controller => widget.controller;

  final _sizeSelectorOverlayController = OverlayPortalController();
  final _eraserSizeSelectorOverlayController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        return Card(
          margin: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  OverlayPortal(
                    controller: _sizeSelectorOverlayController,
                    overlayChildBuilder: (context) {
                      return Positioned(
                        left: 10.0,
                        bottom: kMinInteractiveDimension * 1.7,
                        child: SizeSelectorWidget(
                          initialSize: controller.thickness,
                          onSizeChanged: (value) {
                            widget.controller.setThickness(value);
                            _sizeSelectorOverlayController.toggle();
                          },
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        _sizeSelectorOverlayController.toggle();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Stroke Size: ${controller.thickness}'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      thickness: .7,
                      color: Colors.grey,
                    ),
                  ),
                  OverlayPortal(
                    controller: _eraserSizeSelectorOverlayController,
                    overlayChildBuilder: (context) {
                      return Positioned(
                        left: 10.0,
                        bottom: kMinInteractiveDimension * 1.7,
                        child: SizeSelectorWidget(
                          initialSize: controller.eraserThickness,
                          onSizeChanged: (value) {
                            widget.controller.setEraserThickness(value);
                            _eraserSizeSelectorOverlayController.toggle();
                          },
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        _eraserSizeSelectorOverlayController.toggle();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Erazer Size: ${controller.eraserThickness}'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      thickness: .7,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.controller.setSketch(EraserSketch(points: []));
                    },
                    color: widget.controller.currentSketch is EraserSketch ? Colors.red : Colors.grey,
                    icon: const Icon(Icons.stop_rounded),
                  ),
                  const SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      thickness: .7,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.controller.setSketch(PencilSketch(points: []));
                    },
                    color: widget.controller.currentSketch is PencilSketch ? Colors.blue : Colors.grey,
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.controller.setSketch(RectangleSketch(points: []));
                    },
                    color: widget.controller.currentSketch is RectangleSketch ? Colors.blue : Colors.grey,
                    icon: const Icon(Icons.crop_square),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.controller.setSketch(SphereSketch(points: []));
                    },
                    color: widget.controller.currentSketch is SphereSketch ? Colors.blue : Colors.grey,
                    icon: const Icon(Icons.circle_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.controller.setSketch(TriangleSketch(points: []));
                    },
                    color: widget.controller.currentSketch is TriangleSketch ? Colors.blue : Colors.grey,
                    icon: const Icon(Icons.change_history),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.controller.setSketch(LineSketch(points: []));
                    },
                    color: widget.controller.currentSketch is LineSketch ? Colors.blue : Colors.grey,
                    icon: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
