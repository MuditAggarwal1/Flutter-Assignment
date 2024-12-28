// Helper: Convert hex color to Flutter Color
import 'package:flutter/material.dart';

Color convertHexToColor(String? hexColor) {
  if (hexColor == null || hexColor.isEmpty) return Colors.black;
  hexColor = hexColor.replaceFirst('#', '');
  if (hexColor.length == 6) {
    return Color(int.parse('FF$hexColor', radix: 16));
  } else if (hexColor.length == 8) {
    return Color(int.parse(hexColor, radix: 16));
  }
  return Colors.black;
}
