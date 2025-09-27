import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class InfoWidget extends StatelessWidget {
  final String text;
  const InfoWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text, style: getTextStyle(color: Colors.white)),
      backgroundColor: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    );
  }
}
