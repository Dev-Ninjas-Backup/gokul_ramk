import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class CategoriesItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const CategoriesItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: NetworkImage(icon),
          ),
          const SizedBox(height: 6),
          Text(title, style: getTextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
