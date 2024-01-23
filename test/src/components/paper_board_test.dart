import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paper_board/paper_board.dart';

void main() {
  late DrawingBoardController controller;

  setUp(() {
    controller = DrawingBoardController();
  });

  Widget buildPaperBoard() {
    return MaterialApp(
      home: Scaffold(
        body: PaperBoard(controller: controller),
      ),
    );
  }

  testWidgets('Can draw pencil', (tester) async {
    await tester.pumpWidget(buildPaperBoard());

    // Simulate a tap + drag gesture
    await tester.dragFrom(const Offset(100, 100), const Offset(200, 200));
    await tester.pumpAndSettle();

    expect(controller.sketches, hasLength(1));
  });
}
