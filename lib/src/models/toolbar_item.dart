import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
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
    icon: LineIcons.alternatePencil,
    sketch: PencilSketch,
    handler: (controller) => controller
        .setSketch(const PencilSketch(points: [], color: Colors.black)),
  ),
  ToolbarItem(
    label: 'Eraser',
    icon: LineIcons.eraser,
    sketch: EraserSketch,
    handler: (controller) => controller
        .setSketch(const EraserSketch(points: [], color: Colors.white)),
  ),
  ToolbarItem(
    label: 'Rectangle',
    icon: LineIcons.square,
    sketch: RectangleSketch,
    handler: (controller) => controller
        .setSketch(const RectangleSketch(points: [], color: Colors.black)),
  ),
  ToolbarItem(
    label: 'Sphere',
    icon: LineIcons.circle,
    sketch: SphereSketch,
    handler: (controller) => controller
        .setSketch(const SphereSketch(points: [], color: Colors.black)),
  ),
  ToolbarItem(
    label: 'Triangle',
    icon: Icons.change_history,
    sketch: TriangleSketch,
    handler: (controller) => controller
        .setSketch(const TriangleSketch(points: [], color: Colors.black)),
  ),
  ToolbarItem(
    label: 'Line',
    icon: LineIcons.lineChart,
    sketch: LineSketch,
    handler: (controller) =>
        controller.setSketch(const LineSketch(points: [], color: Colors.black)),
  ),
  ToolbarItem(
    label: 'Clear',
    icon: LineIcons.trash,
    handler: (controller) => controller.clear(),
  ),
];
