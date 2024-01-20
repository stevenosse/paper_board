import 'package:flutter/material.dart';

mixin class DrawableSketch {
  bool shouldDraw = true;
  
  void draw(Canvas canvas, Size size) {}

  void sanitize() {}
}
