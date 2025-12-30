import 'package:flutter/material.dart';

class CustomLabelTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController editingController;
  final IconData? icon;
  final int? maxLine;
  final TextInputType? keyboardType;
  const CustomLabelTextField({
    super.key,
    required this.label,
    required this.editingController,
    required this.hintText,
    this.icon,
    this.maxLine,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 3,
      children: [
        Text(label),
        TextField(
          maxLines: maxLine ?? 1,
          controller: editingController,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon != null
                ? Icon(icon, color: Colors.grey.shade400)
                : null,
          ),
        ),
      ],
    );
  }
}
