import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paper_board/paper_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paper Board Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DrawingBoardController controller = DrawingBoardController();

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    final content = await rootBundle.loadString('assets/board.json');
    final boardJson = jsonDecode(content) as Map<String, dynamic>;
    Board board = Board.deserialize(boardJson);

    controller.load(board);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paper Board Demo'),
        elevation: 3.0,
      ),
      body: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Column(
          children: [
            Expanded(child: PaperBoard(controller: controller)),
            PaperBoardToolbar(controller: controller),
          ],
        ),
      ),
    );
  }
}
