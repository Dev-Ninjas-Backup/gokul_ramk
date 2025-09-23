import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/controller/book_trainer_controller.dart';

class StatContainer extends StatelessWidget {
  StatContainer({super.key});

  final BookTrainerController controller = Get.find<BookTrainerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                "Selected: ${controller.selectedDatesText}, ${controller.selectedStartTime}",
                style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(height: 16),
            Obx(
              () => Text(
                "Duration: ${controller.duration.value.toString()} hours",
                style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Advance Payment (20%): \$24",
              style: getTextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
