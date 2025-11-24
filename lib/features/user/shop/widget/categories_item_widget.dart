import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class CategoriesItemWidget extends StatelessWidget {
  final String iconUrl;
  final String title;
  final VoidCallback onTap;

  const CategoriesItemWidget({
    super.key,
    required this.iconUrl,
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
            child: ClipOval(
              child: Image.network(
                iconUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image_rounded, size: 30);
                },
              ),
            ),
          ),

          const SizedBox(height: 6),
          Text(title, style: getTextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
