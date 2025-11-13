import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/app_texts.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/controller/view_trainer_profile_controller.dart';
import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/widget/profile_info_card.dart';
import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/widget/section_tile_program_card.dart';
import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/widget/trainer_profile_header_widget.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class ViewTrainerProfileScreen extends StatelessWidget {
  final controller = Get.put(ViewTrainerProfileController());

  ViewTrainerProfileScreen({super.key});

  final String arguments = Get.arguments ?? '';

  @override
  Widget build(BuildContext context) {
    bool formMytrainer = arguments == 'myTrainer';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBarTitle(title: 'Trainer Profile'),
              const SizedBox(height: 16),
              // Profile Header
              TrainerProfileHeaderWidget(
                imageUrl:
                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                name: "Sarah Johnson",
                location: "Florida, USA",
                fromMyTrainer: formMytrainer,
              ),
              const SizedBox(height: 20),

              // About Section
              SectionTitle(title: "About Sarah"),
              const SizedBox(height: 8),
              Text(
                AppTexts.aboutTrainer,
                textAlign: TextAlign.justify,
                style: getTextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.withValues(alpha: 0.2),
                        foregroundColor: Colors.green,
                      ),
                      child: Text(
                        'Message Trainer',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryButtonColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {

                        Get.toNamed(AppRoute.tellUsAboutYourselfScreen1);


                        // if(formMytrainer){
                        //   Get.toNamed(AppRoute.bookTrainerScreen,arguments: 'myTrainer');
                        // }else{
                        //   Get.toNamed(AppRoute.bookTrainerScreen);
                        // }
                        


                      },
                      child: Text(
                        formMytrainer ? 'Reschedule' : 'Book Trainer',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Rating & Info
              Obx(
                () => ProfileInfoCard(
                  rating: controller.rating.value,
                  clients: controller.clients.value,
                ),
              ),
              const SizedBox(height: 20),

              // Programs Offered
              SectionTitle(title: "Programs Offered"),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.87,
                children: const [
                  ProgramCard(
                    icon: Icons.favorite,
                    title: "Weight Loss Program",
                    subtitle: "Comprehensive fat burning and nutrition plan",
                  ),
                  ProgramCard(
                    icon: Icons.fitness_center,
                    title: "Muscle Gain",
                    subtitle: "Strength building and muscle development",
                  ),
                  ProgramCard(
                    icon: Icons.directions_run,
                    title: "Cardio Routine",
                    subtitle: "High-intensity cardiovascular training",
                  ),
                  ProgramCard(
                    icon: Icons.self_improvement,
                    title: "Yoga Sessions",
                    subtitle: "Flexibility and mindfulness practice",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
