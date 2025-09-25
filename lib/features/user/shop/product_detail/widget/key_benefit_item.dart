import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class KeyBenefitItem extends StatelessWidget {
  final String icon;
  final String text;

  const KeyBenefitItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: getTextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: getTextStyle(fontSize: 14))),
        
      ],
    );
  }
}
