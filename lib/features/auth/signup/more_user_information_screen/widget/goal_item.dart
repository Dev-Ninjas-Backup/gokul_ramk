import 'package:flutter/material.dart';

class GoalItem extends StatelessWidget {
  final String title;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalItem({
    super.key,
    required this.title,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title $emoji",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            if (isSelected)
              const Icon(Icons.check_box, color: Colors.blue)
            else
              const Icon(Icons.check_box_outline_blank, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
