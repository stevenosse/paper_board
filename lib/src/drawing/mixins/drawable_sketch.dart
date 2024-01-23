import 'package:flutter/material.dart';

mixin class DrawableSketch {
  bool get shouldDraw => true;
  
  void draw(Canvas canvas, Size size) {}

  void sanitize() {}
}
