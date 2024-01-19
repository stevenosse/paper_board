import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

class PaperBoardToolbar extends StatelessWidget {
  const PaperBoardToolbar({super.key, required this.controller});

  final DrawingBoardController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Card(
          margin: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.setSketch(EraserSketch(points: []));
                  },
                  color: controller.currentSketch is EraserSketch ? Colors.red : Colors.grey,
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
                    controller.setSketch(PencilSketch(points: []));
                  },
                  color: controller.currentSketch is PencilSketch ? Colors.blue : Colors.grey,
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    controller.setSketch(RectangleSketch(points: []));
                  },
                  color: controller.currentSketch is RectangleSketch ? Colors.blue : Colors.grey,
                  icon: const Icon(Icons.crop_square),
                ),
                IconButton(
                  onPressed: () {
                    controller.setSketch(SphereSketch(points: []));
                  },
                  color: controller.currentSketch is SphereSketch ? Colors.blue : Colors.grey,
                  icon: const Icon(Icons.circle_outlined),
                ),
                IconButton(
                  onPressed: () {
                    controller.setSketch(TriangleSketch(points: []));
                  },
                  color: controller.currentSketch is TriangleSketch ? Colors.blue : Colors.grey,
                  icon: const Icon(Icons.change_history),
                ),
                IconButton(
                  onPressed: () {
                    controller.setSketch(LineSketch(points: []));
                  },
                  color: controller.currentSketch is LineSketch ? Colors.blue : Colors.grey,
                  icon: const Icon(Icons.remove),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
