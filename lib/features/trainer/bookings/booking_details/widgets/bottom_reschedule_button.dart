import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/bookings/reschedule/calender/controller/reschedule_contrller.dart';

class BottomRescheduleButton extends StatelessWidget {
  const BottomRescheduleButton({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controller = Get.put(RescheduleContrller(), tag: 'reschedule');

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // TODO: cancel logic
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: BorderSide(color: Colors.red),
            ),
            child: Text("Cancel"),
          ),
        ),

        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Get.to(RescheduleScreen());
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: Text("Reschedule"),
          ),
        ),
      ],
    );
  }
}
