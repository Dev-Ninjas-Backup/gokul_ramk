import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class IngredientItemWidget extends StatelessWidget {
  final String text;
  const IngredientItemWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text("• $text", style: getTextStyle(fontSize: 15)),
    );
  }
}
