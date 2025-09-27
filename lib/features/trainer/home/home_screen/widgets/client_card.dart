import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';

import '../../../../../core/common/styles/global_text_style.dart';

Widget clientCard(String name) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Placeholder for image
        Container(
          height: 120,
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Imagepath.trainer),
              fit: BoxFit.cover,
            ),

            borderRadius: BorderRadius.circular(12),
          ),
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "Done 25kg this month",
          style: getTextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
