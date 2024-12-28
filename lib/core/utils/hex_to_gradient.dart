import 'dart:math';

import 'package:famcards/core/utils/hex_to_color.dart';
import 'package:famcards/features/cards/data/models/bg_gradient_model.dart';
import 'package:flutter/material.dart';

LinearGradient convertHexToGradient(BgGradient bgGradient) {
  final radians = bgGradient.angle * (pi / 180);

  final Alignment start = Alignment(
    -1 * cos(radians),
    -1 * sin(radians),
  );
  final Alignment end = Alignment(
    cos(radians),
    sin(radians),
  );

  return LinearGradient(
    begin: start,
    end: end,
    colors: bgGradient.colors
        .map((hexColor) => convertHexToColor(hexColor))
        .toList(),
  );
}
