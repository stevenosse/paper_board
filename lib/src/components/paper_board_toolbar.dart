import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';
import 'package:paper_board/src/components/size_selector_widget.dart';
import 'package:paper_board/src/models/toolbar_item.dart';

typedef ToolbarItemBuilder = Widget Function(BuildContext context, ToolbarItem item, DrawingBoardController controller);

class PaperBoardToolbar extends StatefulWidget {
  PaperBoardToolbar({
    super.key,
    required this.controller,
    List<ToolbarItem>? items,
    this.itemBuilder,
  }) : items = items ?? standardToolbarItems;

  final DrawingBoardController controller;
  final List<ToolbarItem> items;
  final ToolbarItemBuilder? itemBuilder;

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
                  IconButton(
                    onPressed: () => controller.undo(),
                    icon: const Icon(Icons.undo),
                    color: controller.canUndo ? null : Colors.grey,
                  ),
                  IconButton(
                    onPressed: () => controller.redo(),
                    icon: const Icon(Icons.redo),
                    color: controller.canRedo ? null : Colors.grey,
                  ),
                  for (final item in widget.items)
                    widget.itemBuilder?.call(context, item, controller) ??
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Tooltip(
                            message: item.label!,
                            child: IconButton(
                              color: controller.currentSketch.runtimeType == item.sketch
                                  ? Theme.of(context).primaryColor
                                  : null,
                              icon: Icon(item.icon),
                              onPressed: () => item.handler!(controller),
                            ),
                          ),
                        ),
                  OverlayPortal(
                    controller: _sizeSelectorOverlayController,
                    overlayChildBuilder: (context) {
                      return Positioned(
                        left: 10.0,
                        bottom: 100,
                        child: SizeSelectorWidget(
                          initialSize: controller.currentSketch.thickness,
                          onSizeChanged: (size) => controller.setThickness(size),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: 'Size',
                        child: IconButton(
                          icon: const Icon(Icons.format_size),
                          onPressed: () => _sizeSelectorOverlayController.toggle(),
                        ),
                      ),
                    ),
                  ),
                  // TODO: Find better icons
                  OverlayPortal(
                    controller: _eraserSizeSelectorOverlayController,
                    overlayChildBuilder: (context) {
                      return Positioned(
                        left: 10.0,
                        bottom: 100,
                        child: SizeSelectorWidget(
                          initialSize: controller.eraserThickness,
                          onSizeChanged: (size) => controller.setEraserThickness(size),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: 'Eraser Size',
                        child: IconButton(
                          icon: const Icon(Icons.foundation),
                          onPressed: () => _eraserSizeSelectorOverlayController.toggle(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
