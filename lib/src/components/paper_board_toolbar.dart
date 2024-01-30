import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paper_board/paper_board.dart';
import 'package:paper_board/src/components/size_selector_widget.dart';
import 'package:paper_board/src/models/toolbar_item.dart';

typedef ToolbarItemBuilder = Widget Function(
  BuildContext context,
  ToolbarItem item,
  DrawingBoardController controller,
);

class PaperBoardToolbar extends StatefulWidget {
  PaperBoardToolbar({
    super.key,
    required this.controller,
    List<ToolbarItem>? items,
    this.itemBuilder,
    this.backgroundColor,
    this.onExport,
  }) : items = items ?? standardToolbarItems;

  final DrawingBoardController controller;
  final List<ToolbarItem> items;
  final ToolbarItemBuilder? itemBuilder;
  final Color? backgroundColor;

  /// Called when the user taps the export button.
  /// The [String] argument is the base64 encoded png data.
  final ValueChanged<String?>? onExport;

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
          color: widget.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    onPressed:
                        !controller.canUndo ? null : () => controller.undo(),
                    icon: const Icon(LineIcons.undo),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  IconButton(
                    onPressed:
                        !controller.canRedo ? null : () => controller.redo(),
                    icon: const Icon(LineIcons.redo),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const _Divider(),
                  for (final item in widget.items)
                    widget.itemBuilder?.call(context, item, controller) ??
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Tooltip(
                            message: item.label!,
                            child: IconButton(
                              color: controller.currentSketch.runtimeType ==
                                      item.sketch
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface,
                              icon: Icon(item.icon),
                              onPressed: () => item.handler!(controller),
                            ),
                          ),
                        ),
                  const _Divider(),
                  OverlayPortal(
                    controller: _sizeSelectorOverlayController,
                    overlayChildBuilder: (context) {
                      return Positioned(
                        left: 10.0,
                        bottom: 100,
                        child: SizeSelectorWidget(
                          initialSize: controller.currentSketch.thickness,
                          onSizeChanged: (size) =>
                              controller.setThickness(size),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: 'Size',
                        child: IconButton(
                          icon: const Icon(LineIcons.ruler),
                          color: Theme.of(context).colorScheme.onSurface,
                          onPressed: () =>
                              _sizeSelectorOverlayController.toggle(),
                        ),
                      ),
                    ),
                  ),
                  OverlayPortal(
                    controller: _eraserSizeSelectorOverlayController,
                    overlayChildBuilder: (context) {
                      return Positioned(
                        left: 10.0,
                        bottom: 100,
                        child: SizeSelectorWidget(
                          initialSize: controller.eraserThickness,
                          onSizeChanged: (size) =>
                              controller.setEraserThickness(size),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: 'Eraser Size',
                        child: IconButton(
                          icon: const Icon(LineIcons.rulerCombined),
                          color: Theme.of(context).colorScheme.onSurface,
                          onPressed: () =>
                              _eraserSizeSelectorOverlayController.toggle(),
                        ),
                      ),
                    ),
                  ),
                  const _Divider(),
                  IconButton(
                    onPressed: () async {
                      final data = await controller.getPngData();
                      widget.onExport?.call(data);
                    },
                    icon: const Icon(LineIcons.image),
                    color: Theme.of(context).colorScheme.onSurface,
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

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kMinInteractiveDimension / 2,
      child: VerticalDivider(
        color: Theme.of(context).colorScheme.primaryContainer,
        thickness: 1.0,
        width: 1.0,
      ),
    );
  }
}
