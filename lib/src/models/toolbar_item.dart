import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

typedef ActionHandler = void Function(DrawingBoardController controller);

class ToolbarItem {
  final String? label;
  final IconData? icon;
  final Type? sketch;
  final ActionHandler? handler;

  const ToolbarItem({
    this.label,
    this.icon,
    this.handler,
    this.sketch,
  });
}

final standardToolbarItems = [
  ToolbarItem(
    label: 'Pencil',
    icon: Icons.edit,
    sketch: PencilSketch,
    handler: (controller) =>
        controller.setSketch(const PencilSketch(points: [])),
  ),
  ToolbarItem(
    label: 'Eraser',
    icon: Icons.stop_rounded,
    sketch: EraserSketch,
    handler: (controller) =>
        controller.setSketch(const EraserSketch(points: [])),
  ),
  ToolbarItem(
    label: 'Rectangle',
    icon: Icons.crop_square,
    sketch: RectangleSketch,
    handler: (controller) =>
        controller.setSketch(const RectangleSketch(points: [])),
  ),
  ToolbarItem(
    label: 'Sphere',
    icon: Icons.circle_outlined,
    sketch: SphereSketch,
    handler: (controller) =>
        controller.setSketch(const SphereSketch(points: [])),
  ),
  ToolbarItem(
    label: 'Triangle',
    icon: Icons.change_history,
    sketch: TriangleSketch,
    handler: (controller) =>
        controller.setSketch(const TriangleSketch(points: [])),
  ),
  ToolbarItem(
    label: 'Line',
    icon: Icons.line_style,
    sketch: LineSketch,
    handler: (controller) => controller.setSketch(const LineSketch(points: [])),
  ),
  ToolbarItem(
    label: 'Clear',
    icon: Icons.clear,
    handler: (controller) => controller.clear(),
  ),
];
