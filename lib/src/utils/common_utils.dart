import 'package:flutter/material.dart';

bool isShadeOfWhite(Color color, int threshold) {
  // Extract RGB components
  int red = color.red;
  int green = color.green;
  int blue = color.blue;

  // Calculate brightness using a simple formula (0.299*R + 0.587*G + 0.114*B)
  double brightness = 0.299 * red + 0.587 * green + 0.114 * blue;

  // Check if the brightness is above the specified threshold
  return brightness >= threshold;
}

bool isShadeOfBlack(Color color, int threshold) {
  // Extract RGB components
  int red = color.red;
  int green = color.green;
  int blue = color.blue;

  // Calculate brightness using a simple formula (0.299*R + 0.587*G + 0.114*B)
  double brightness = 0.299 * red + 0.587 * green + 0.114 * blue;

  // Check if the brightness is below the specified threshold
  return brightness <= threshold;
}
