import 'package:flutter/material.dart';
import 'package:paper_board/paper_board.dart';

class SketchDeserializer {
  SketchBase deserialize(Map<String, dynamic> json) {
    return SketchBase(
      points: (json['points'] as List<dynamic>).map((e) => Offset(e[0], e[1])).toList(),
      color: Color(json['color']),
      thickness: json['thickness'],
      filled: json['filled'],
    ); 
  }
}