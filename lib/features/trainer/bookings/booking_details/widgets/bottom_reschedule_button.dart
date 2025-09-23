import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';

class BottomRescheduleButton extends StatelessWidget {
  const BottomRescheduleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // TODO: cancel logic
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            child: const Text("Cancel"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // TODO: reschedule logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text("Reschedule"),
          ),
        ),
      ],
    );
  }
}
