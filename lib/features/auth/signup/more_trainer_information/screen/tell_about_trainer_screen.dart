import 'dart:io';

import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_label_textfield.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/auth/signup/more_trainer_information/controller/tell_about_trainer_controller.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/screen/trainer_profile_screen.dart';

import '../widgets/availability.dart';

class TellAboutTrainerScreen extends StatelessWidget {
  TellAboutTrainerScreen({super.key});

  final TellAboutTrainerController controller = Get.put(
    TellAboutTrainerController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TellUsPageHeading(),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(() {
                            final String currentNetworkImage =
                                Get.arguments?[1] as String? ?? '';
                            final File? localImageFile =
                                controller.selectedImage.value;
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: localImageFile != null
                                  ? FileImage(localImageFile) as ImageProvider
                                  : currentNetworkImage.isNotEmpty
                                  ? NetworkImage(currentNetworkImage)
                                  : controller.imageUrl.value.isNotEmpty
                                  ? NetworkImage(controller.imageUrl.value)
                                  : null,
                              child:
                                  (localImageFile == null &&
                                      currentNetworkImage.isEmpty &&
                                      controller.imageUrl.value.isEmpty)
                                  ? const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.grey,
                                    )
                                  : null,
                            );
                          }),

                          //                           Obx(() {
                          //   final String currentNetworkImage =
                          //       Get.arguments?[1] as String? ?? '';
                          //   final File? localImageFile = controller.selectedImage.value;

                          //   return CircleAvatar(
                          //     radius: 50,
                          //     backgroundColor: Colors.grey.shade200,
                          //     backgroundImage: localImageFile != null
                          //         ? FileImage(localImageFile)
                          //         : currentNetworkImage.isNotEmpty
                          //             ? NetworkImage(currentNetworkImage)
                          //             : controller.imageUrl.value.isNotEmpty
                          //                 ? NetworkImage(controller.imageUrl.value)
                          //                 : null,
                          //     child: (localImageFile == null &&
                          //             currentNetworkImage.isEmpty &&
                          //             controller.imageUrl.value.isEmpty)
                          //         ? const Icon(
                          //             Icons.person,
                          //             size: 60,
                          //             color: Colors.grey,
                          //           )
                          //         : null,
                          //   );
                          // })
                          // ,

                          // Edit Icon (tap to pick from gallery)
                          Positioned(
                            right: -5,
                            bottom: 15,
                            child: GestureDetector(
                              onTap: () async {
                                await controller.pickImageFromGallery();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  IconPath.editIcon,
                                  height: 24,
                                  width: 24,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomLabelTextField(
                      label: 'Full Name',
                      editingController: controller.fullNameController,
                      hintText: 'Enter your full name',
                    ),
                    SizedBox(height: 4),

                    Text('Nationality'),
                    CountryStateCityPicker(
                      country: controller.country,
                      state: controller.state,
                      city: controller.city,
                      dialogColor: Colors.grey.shade200,
                      textFieldDecoration: InputDecoration(
                        fillColor: Color(0xFFEAEAEA),
                        filled: true,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                CustomLabelTextField(
                  label: 'Area of Service',
                  editingController: controller.areaOfServiceController,
                  hintText: 'Add your Area',
                ),

                //Gender
                const SizedBox(height: 16),
                CustomLabelTextField(
                  maxLine: 5,
                  label: 'Bio/experience summary',
                  editingController: controller.bioController,
                  hintText: 'Add bio/experience summary',
                ),

                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text('Session Type'),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(
                        () => DropdownButton<String>(
                          isExpanded: true,
                          value: controller.sessionType.value,
                          underline: const SizedBox(),
                          hint: const Text("Select your session type"),
                          items: ['Online', 'Onsite'].map((f) {
                            return DropdownMenuItem<String>(
                              value: f,
                              child: Text(f[0].toUpperCase() + f.substring(1)),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              controller.sessionType.value = val,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    CustomLabelTextField(
                      editingController: controller.specializeController,
                      hintText: 'Add your specializations',

                      // onSubmitted: (_) => controller.addSpecialization(),
                      label: 'Specializations', // Optional: Add on Enter
                    ),

                    SizedBox(height: 16),

                    GestureDetector(
                      onTap: controller.addSpecialization,

                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 54, 115, 164),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Add Specialization",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Display added specializations as beautiful chips
                    Obx(
                      () => controller.specializationsList.isEmpty
                          ? Text(
                              "No specializations added yet",
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          : Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: controller.specializationsList
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    int index = entry.key;
                                    String specialization = entry.value;

                                    return Chip(
                                      label: Text(
                                        specialization,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      backgroundColor: Colors.blue.shade50,
                                      deleteIcon: Icon(Icons.close, size: 18),
                                      onDeleted: () => controller
                                          .removeSpecializationAt(index),
                                    );
                                  })
                                  .toList(),
                            ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                AvailabilityScreen(),

                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final success = await controller.submitProfile();
                    if (success) {
                      try {
                        if (Get.isRegistered<TrainerProfileController>()) {
                          // fetchTrainerProfile now returns Future<void>
                          await Get.find<TrainerProfileController>()
                              .fetchTrainerProfile();
                        }
                      } catch (e) {
                        debugPrint("Error refreshing profile: $e");
                      }
                      // Pass updated name and image so UI can show them immediately
                      final String updatedName =
                          controller.fullNameController.text.trim().isNotEmpty
                          ? controller.fullNameController.text.trim()
                          : controller.fullName.value;
                      final String updatedImage = controller.imageUrl.value;
                      final String updatedBio =
                          controller.bioController.text.trim().isNotEmpty
                          ? controller.bioController.text.trim()
                          : controller.currentBio.value;
                      final List<String> updatedSpecializations = controller
                          .specializationsList
                          .toList();

                      Get.off(
                        () => TrainerProfileScreen(),
                        arguments: [
                          updatedName,
                          updatedImage,
                          updatedBio,
                          updatedSpecializations,
                        ],
                      );
                    }
                  },

                  child: Text('Submit'),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
