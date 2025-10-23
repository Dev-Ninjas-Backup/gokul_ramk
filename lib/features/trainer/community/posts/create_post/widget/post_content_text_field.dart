import 'package:flutter/material.dart';

class PostContentTextField extends StatelessWidget {
  final String hint;
  final Function(String) onChanged;
  final int maxLines;

  const PostContentTextField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
