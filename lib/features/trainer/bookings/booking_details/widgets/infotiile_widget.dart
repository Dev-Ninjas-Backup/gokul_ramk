import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

Widget infoTile(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: getTextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
