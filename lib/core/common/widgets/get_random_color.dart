import 'dart:math';
import 'package:flutter/material.dart';

Color getRandomDeepColor() {
  final random = Random();
  return random.nextBool() ? Colors.blue.shade800 : Colors.green.shade800;
}

