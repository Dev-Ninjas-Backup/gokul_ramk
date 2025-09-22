import 'package:flutter/material.dart';

import '../../../../../core/common/styles/global_text_style.dart';

Widget sessionCard(String time, String title, Color bgColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          time,
          style: getTextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
