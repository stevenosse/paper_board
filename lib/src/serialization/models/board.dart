import 'package:paper_board/paper_board.dart';

class Board {
  final String id;
  final List<SketchBase> sketches;

  Board({
    required this.id,
    required this.sketches,
  });

  Board copyWith({
    String? id,
    List<SketchBase>? sketches,
  }) {
    return Board(
      id: id ?? this.id,
      sketches: sketches ?? this.sketches,
    );
  }

  Map<String, dynamic> serialize({SketchSerializer? serializer}) {
    final sz = serializer ?? const SketchSerializer();
    return {
      'id': id,
      'sketches': sketches.map((e) => sz.serialize(e)).toList(),
    };
  }

  factory Board.deserialize(Map<String, dynamic> json, {SketchDeserializer? serializer}) {
    final sz = serializer ?? const SketchDeserializer();
    final sketches = json['sketches'] as List<dynamic>;
    
    return Board(
      id: json['id'],
      sketches: sketches.map((e) => sz.deserialize(e)).toList(),
    );
  }
}
