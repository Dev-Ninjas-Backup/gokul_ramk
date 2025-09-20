import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/book_trainer/controller/book_trainer_controller.dart';

class DurationWidget extends StatelessWidget {
  DurationWidget({super.key});

  final BookTrainerController controller = Get.find<BookTrainerController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.decrementDuration();
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade100,
            child: Icon(Icons.horizontal_rule_sharp),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 78, vertical: 10),
            child: Obx(
              () => Text(
                "${controller.duration.value.toString()} hours",
                style: getTextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.incrementDuration();
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade100,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
