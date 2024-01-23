import 'package:paper_board/paper_board.dart';

class Board {
  final List<SketchBase> sketches;

  const Board({
    required this.sketches,
  });

  Board copyWith({
    List<SketchBase>? sketches,
  }) {
    return Board(
      sketches: sketches ?? this.sketches,
    );
  }

  Map<String, dynamic> serialize({SketchSerializer? serializer}) {
    final sz = serializer ?? const SketchSerializer();
    return {
      'sketches': sketches.map((e) => sz.serialize(e)).toList(),
    };
  }

  factory Board.deserialize(Map<String, dynamic> json,
      {SketchDeserializer? serializer}) {
    final sz = serializer ?? const SketchDeserializer();
    final sketches = json['sketches'] as List<dynamic>;

    return Board(
      sketches: sketches.map((e) => sz.deserialize(e)).toList(),
    );
  }
}
