import 'package:flutter/material.dart';
import '../../../../../core/common/styles/global_text_style.dart';

/// Small widget for stats boxes
class StatBox extends StatelessWidget {
  final String title;
  final String value;
  final bool isCentered;

  const StatBox({
    super.key,
    required this.title,
    required this.value,
    this.isCentered = false, // default = left-aligned
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ensures full width if allowed by parent
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: isCentered
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getTextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
          ),
        ],
      ),
    );
  }
}
