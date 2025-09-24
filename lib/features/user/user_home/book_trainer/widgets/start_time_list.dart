import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/controller/book_trainer_controller.dart';

class StartTimeList extends StatelessWidget {
  StartTimeList({super.key});

  final BookTrainerController controller = Get.find<BookTrainerController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.startTime.length,
          itemBuilder: (context, index) {
            var time = controller.startTime[index];
            return GestureDetector(
              onTap: () {
                for (var t in controller.startTime) {
                  t['isSelected'] = false;
                }
                time['isSelected'] = true;
                controller.startTime.refresh(); // 👈 notify Obx
              },
              child: Container(
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: time['isSelected']
                      ? Colors.green
                      : Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  time['time'],
                  style: TextStyle(
                    color: time['isSelected'] ? Colors.white : Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
