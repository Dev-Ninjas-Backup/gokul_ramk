import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';

class ProgramsOfferedWidget extends StatelessWidget {
  const ProgramsOfferedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrainerProfileController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Programs Offered",
          style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16),

        Obx(
          () => GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.programs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.13,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final program = controller.programs[index];
              return Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .02),
                      blurRadius: 4,
                      offset: Offset(2, 6),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      radius: 26,
                      child: Image.asset(program.icon, fit: BoxFit.cover),
                    ),
                    SizedBox(height: 12),

                    Text(
                      program.title,
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),

                    Text(
                      program.description,
                      style: getTextStyle(
                        fontSize: 14,
                        color: AppColors.secondaryFontColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
