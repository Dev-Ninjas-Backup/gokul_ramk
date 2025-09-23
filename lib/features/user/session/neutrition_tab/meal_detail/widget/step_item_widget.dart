import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class StepItemWidget extends StatelessWidget {
  final int index;
  final String text;
  const StepItemWidget({super.key, required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text("${index + 1}. $text", style: getTextStyle(fontSize: 15)),
    );
  }
}
