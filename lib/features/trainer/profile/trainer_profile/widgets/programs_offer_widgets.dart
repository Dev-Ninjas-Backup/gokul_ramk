import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class ProgramsOfferedWidget extends StatelessWidget {
  const ProgramsOfferedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<TrainerProfileController>()
        ? Get.find<TrainerProfileController>()
        : Get.put(TrainerProfileController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with "See All" button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Programs Offered",
              style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.getallProgramsScreen());
              },
              child: Text(
                "See All",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        Obx(() {
          // Show loading state
          if (controller.programs.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "No programs available",
                  style: getTextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryFontColor,
                  ),
                ),
              ),
            );
          }

          // Show only first 4 programs
          final displayPrograms = controller.programs.take(4).toList();

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: displayPrograms.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final program = displayPrograms[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoute.getTrainerProgramDetailsScreen(),
                    parameters: {'programId': program.id},
                  );
                },
                child: Container(
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
                      // Program thumbnail or placeholder
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            program.thumbnailUrl != null &&
                                program.thumbnailUrl!.isNotEmpty
                            ? Image.network(
                                program.thumbnailUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.blue.shade300,
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.blue.shade300,
                                ),
                              ),
                      ),
                      SizedBox(height: 12),

                      // Program title
                      Text(
                        program.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),

                      // Program description
                      Text(
                        program.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryFontColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Program duration and price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${program.duration} weeks",
                            style: getTextStyle(
                              fontSize: 11,
                              color: Color(0xFF888888),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "\$${program.price}",
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
