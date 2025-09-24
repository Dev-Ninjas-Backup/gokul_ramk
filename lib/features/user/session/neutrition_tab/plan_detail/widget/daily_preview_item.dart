import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class DailyPreviewItem extends StatelessWidget {
  final String text;
  const DailyPreviewItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(text, style: getTextStyle(fontSize: 14,)),
        ),
      ],
    );
  }
}
