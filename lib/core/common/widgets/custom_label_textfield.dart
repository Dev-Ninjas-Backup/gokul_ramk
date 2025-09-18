import 'package:flutter/material.dart';

class CustomLabelTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController editingController;
  final IconData icon;
  const CustomLabelTextField({
    super.key,
    required this.label,
    required this.editingController,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 3,
      children: [
        Text(label),
        TextField(
          controller: editingController,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: Colors.grey.shade400),
          ),
        ),
      ],
    );
  }
}
