import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/bookings/reschedule/calender/screen/reschedule_screen.dart.dart';

class BottomRescheduleButton extends StatelessWidget {
  const BottomRescheduleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Color(0XFFE8F4F8),
              side: BorderSide(color: Color(0XFF148CBB)),
            ),
            child: Text(
              "Cancel",
              style: getTextStyle(
                color: Color(0XFF148CBB),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Get.to(RescheduleScreen());
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0XFF148CBB)),
            child: Text(
              "Reschedule",
              style: getTextStyle(
                color: AppColors.background,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
