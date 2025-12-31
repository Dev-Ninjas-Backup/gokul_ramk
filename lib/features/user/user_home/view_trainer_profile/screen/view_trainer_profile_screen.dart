// // ignore_for_file: unused_import

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
// import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
// import 'package:gokul_ramk/core/utils/constants/app_texts.dart';
// import 'package:gokul_ramk/core/utils/constants/colors.dart';
// import 'package:gokul_ramk/features/user/user_home/controller/user_home_controller.dart';
// import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/controller/view_trainer_profile_controller.dart';
// import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/widget/profile_info_card.dart';
// import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/widget/section_tile_program_card.dart';
// import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/widget/trainer_profile_header_widget.dart';
// import 'package:gokul_ramk/routes/app_routes.dart';

// class ViewTrainerProfileScreen extends StatelessWidget {
// final String trainerId;
//   final controller = Get.put(ViewTrainerProfileController());
//     final homecontroller = Get.find<UserHomeController>();

//   ViewTrainerProfileScreen({required this.trainerId,super.key});

//   final String arguments = Get.arguments ?? '';

//   @override
//   Widget build(BuildContext context) {
//     homecontroller.fetchTrainerDetailsMethod(trainerId);

//   final trainerDetails=homecontroller.trainerDetails.value;
//     bool formMytrainer = arguments == 'myTrainer';
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CustomAppBarTitle(title: 'Trainer Profile'),
//               const SizedBox(height: 16),
//               // Profile Header
//               TrainerProfileHeaderWidget(
//                 imageUrl:
//                     trainerDetails!.image.toString(),
//                 name: trainerDetails.name,
//                 location: trainerDetails.city.toString(),
//                 fromMyTrainer: formMytrainer,
//               ),
//               const SizedBox(height: 20),

//               // About Section
//               SectionTitle(title: "About Sarah"),
//               const SizedBox(height: 8),
//               Text(
//                 trainerDetails.bio.toString(),
//                 textAlign: TextAlign.justify,
//                 style: getTextStyle(fontSize: 14),
//               ),
//               const SizedBox(height: 20),

//               // Action Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green.withValues(alpha: 0.2),
//                         foregroundColor: Colors.green,
//                       ),
//                       child: Text(
//                         'Message Trainer',
//                         style: getTextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.primaryButtonColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                       controller.checkOnboarding();
//                         // Get.toNamed(AppRoute.tellUsAboutYourselfScreen1);

//                         // if(formMytrainer){
//                         //   Get.toNamed(AppRoute.bookTrainerScreen,arguments: 'myTrainer');
//                         // }else{
//                         //   Get.toNamed(AppRoute.bookTrainerScreen);
//                         // }
//                       },
//                       child: Text(
//                         formMytrainer ? 'Reschedule' : 'Book Trainer',
//                         style: getTextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.background,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Rating & Info
//               Obx(
//                 () => ProfileInfoCard(
//                   rating: controller.rating.value,
//                   clients: controller.clients.value,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Programs Offered
//               SectionTitle(title: "Programs Offered"),
//               const SizedBox(height: 12),
//               GridView.count(
//                 crossAxisCount: 2,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.87,
//                 children: const [
//                   ProgramCard(
//                     icon: Icons.favorite,
//                     title: "Weight Loss Program",
//                     subtitle: "Comprehensive fat burning and nutrition plan",
//                   ),
//                   ProgramCard(
//                     icon: Icons.fitness_center,
//                     title: "Muscle Gain",
//                     subtitle: "Strength building and muscle development",
//                   ),
//                   ProgramCard(
//                     icon: Icons.directions_run,
//                     title: "Cardio Routine",
//                     subtitle: "High-intensity cardiovascular training",
//                   ),
//                   ProgramCard(
//                     icon: Icons.self_improvement,
//                     title: "Yoga Sessions",
//                     subtitle: "Flexibility and mindfulness practice",
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/routes/app_routes.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/user/user_home/controller/user_home_controller.dart';
import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/controller/view_trainer_profile_controller.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../widget/profile_info_card.dart';
import '../widget/section_tile_program_card.dart';
import '../widget/trainer_profile_header_widget.dart';

class ViewTrainerProfileScreen extends StatelessWidget {
  final String trainerId;

  ViewTrainerProfileScreen({required this.trainerId, super.key});

  final profileController = Get.put(ViewTrainerProfileController());
  final homeController = Get.find<UserHomeController>();

  @override
  Widget build(BuildContext context) {
    // Fetch trainer only once AFTER build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchTrainerDetailsMethod(trainerId);
    });

    final bool fromMyTrainer = (Get.arguments ?? '') == 'myTrainer';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (homeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final trainer = homeController.trainerDetails.value;

          if (trainer == null) {
            return const Center(child: Text("Trainer details not found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBarTitle(title: 'Trainer Profile'),
                const SizedBox(height: 16),

                // Profile Header
                TrainerProfileHeaderWidget(
                  imageUrl: trainer.image ?? "",
                  name: trainer.name,
                  location: trainer.city ?? "Not specified",
                  nationality: trainer.nationality ?? "Not specified",
                  fromMyTrainer: fromMyTrainer,
                ),
                const SizedBox(height: 20),

                // About Section
                SectionTitle(title: "About Trainer"),
                const SizedBox(height: 8),
                Text(
                  trainer.bio ?? "",
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
                        onPressed: () {
                          // Navigate to message detail screen with trainer info
                          Get.toNamed(
                            '/message/detail',
                            arguments: {
                              'partnerId': trainer.id,
                              'partnerName': trainer.name,
                              'partnerImage': trainer.image,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          backgroundColor: Colors.green.withOpacity(0.2),
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
                          profileController.checkOnboarding();
                          // Navigate to booking screen and pass the trainer id so the booking screen
                          // can pre-fill the trainerId automatically.
                          Get.toNamed(
                            AppRoute.bookTrainerScreen,
                            arguments: trainer.id,
                          );
                        },
                        child: Text(
                          fromMyTrainer ? 'Reschedule' : 'Book Trainer',
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
                    rating: profileController.rating.value,
                    clients: profileController.clients.value,
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
          );
        }),
      ),
    );
  }
}
