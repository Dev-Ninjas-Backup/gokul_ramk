import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class HighlightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String image;
  final Color buttonColor;
  final VoidCallback onTap;

  const HighlightCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.image,
    required this.buttonColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: buttonColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: getTextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                SizedBox(
                  width: 145,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Text('Error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
