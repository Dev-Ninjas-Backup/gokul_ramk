// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

// import '../controller/program_controller.dart';
// import '../widgets/text_field.dart';
// import 'workout_plan.dart';

// class CreateProgramScreen extends StatelessWidget {
//   final ProgramController controller = Get.put(ProgramController());
//   CreateProgramScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           "New Program",
//           style: getTextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//             },
//             child: Text(
//               "Cancel",
//               style: getTextStyle(
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),

//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ✅ Thumbnail
//             Text(
//               "Thumbnail",
//               style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),

//            Obx(
//     () => GestureDetector(
//       onTap: () {
//         // If image exists → do nothing on tap (or you can allow re-pick)
//         // If no image → pick new one
//         if (controller.thumbnailImage.value == null) {
//           controller.pickFromGallery();
//         }
//       },
//       child: Container(
//         width: double.infinity,
//         height: 140,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey[300]!),
//           // Show selected image as background if exists
//           image: controller.thumbnailImage.value != null
//               ? DecorationImage(
//                   image: FileImage(
//                     File(controller.thumbnailImage.value!.path),
//                   ),
//                   fit: BoxFit.cover,
//                 )
//               : null,
//         ),
//         child: Stack(
//           children: [
//             // Placeholder (only visible when no image)
//             if (controller.thumbnailImage.value == null)
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.image, size: 40, color: Colors.grey),
//                     SizedBox(height: 8),
//                     Text(
//                       "Click here to upload thumbnail image",
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),

//             // Remove button (only when image exists)
//             if (controller.thumbnailImage.value != null)
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: GestureDetector(
//                   onTap: controller.removeThumbnail,
//                   child: Container(
//                     padding: EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: Colors.black54,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     ),
//   )

// ,

//             SizedBox(height: 20),

//             // ✅ Program Info
//             Text(
//               "Program Info",
//               style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
//             SizedBox(height: 20),
//             Text(
//               "Program Name",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),

//             // Program Name
//             buildTextField("Add program name", controller: controller.nameC),

//             SizedBox(height: 12),
//             SizedBox(height: 20),
//             Text(
//               "Duration",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),

//             // Duration with calendar icon
//             buildTextField(
//               "Add program duration",
//               controller: controller.durationC,
//             ),

//             SizedBox(height: 12),
//             SizedBox(height: 20),
//             Text(
//               "Category",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),

//             /// CATEGORY TYPE DROPDOWN
//             Obx(() {
//               return DropdownButtonFormField<String>(
//                 initialValue: controller.selectedCategoryId.value,
//                 items: controller.categories.map((cat) {
//                   return DropdownMenuItem(value: cat.id, child: Text(cat.name));
//                 }).toList(),
//                 onChanged: (val) {
//                   controller.selectedCategoryId.value = val;
//                 },
//               );
//             }),

//             SizedBox(height: 12),
//             SizedBox(height: 20),
//             Text(
//               "Description",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),

//             // Description
//             buildTextField(
//               "Write a description about this program",
//               controller: controller.descriptionC,
//               maxLines: 3,
//             ),

//             SizedBox(height: 12),
//             SizedBox(height: 20),
//             Text(
//               "Price",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             buildTextField("Price", controller: controller.priceC),
//             SizedBox(height: 12),
//             SizedBox(height: 20),
//             Text(
//               "Max Participants",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             buildTextField(
//               "Max Participants",
//               controller: controller.maxParticipantsC,
//             ),

//             SizedBox(height: 35),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // final controller = Get.put(ProgramController());

//                   // controller.createProgram(
//                   //   name: "HIIT Program",
//                   //   duration: "4 weeks",
//                   //   category: "Fat Burn",
//                   //   description:
//                   //       "This program helps burn fat and improve stamina.",
//                   // );

//                   Get.to(() => WorkoutPlanScreen());
//                 },
//                 child: Text(
//                   "Continue",
//                   style: getTextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 48),
//           ],
//         ),
//       ),
//     );
//   }
// }

// features/trainer/program/screen/create_program_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../controller/program_controller.dart';
import '../widgets/text_field.dart';
import 'workout_plan.dart';

class CreateProgramScreen extends StatelessWidget {
  CreateProgramScreen({super.key}) {
    // STEP 1: Register NetworkClient (fixes "NetworkClient not found")
    if (!Get.isRegistered<NetworkClient>()) {
      Get.put(
        NetworkClient(
          onUnAuthorize: () {
            Get.snackbar("Session Expired", "Logging you out...");
            Get.offAllNamed('/login'); // change to your login route
          },
        ),
      );
    }

    // STEP 2: Register ProgramController (fixes "ProgramController not found")
    Get.put(ProgramController());
  }

  // Now safely find it — NO ERROR!
  late final ProgramController controller = Get.find<ProgramController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "New Program",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: getTextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Text(
              "Thumbnail",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(
              () => GestureDetector(
                onTap: controller.pickThumbnail,
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                    image: controller.thumbnailFile.value != null
                        ? DecorationImage(
                            image: FileImage(controller.thumbnailFile.value!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      if (controller.thumbnailFile.value == null)
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 40, color: Colors.grey),
                              SizedBox(height: 8),
                              Text(
                                "Click here to upload thumbnail image",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (controller.thumbnailFile.value != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: controller.removeThumbnail,
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.black54,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              "Program Info",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildField("Program Name", controller.nameC),
            _buildField(
              "Duration (weeks)",
              controller.durationC,
              keyboardType: TextInputType.number,
            ),
            _buildField(
              "Sessions per Week",
              controller.sessionsPerWeekC,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),
            Text(
              "Category",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(
              () => DropdownButtonFormField<String>(
                initialValue: controller.selectedCategoryId.value,
                items: controller.categories
                    .map(
                      (c) => DropdownMenuItem(value: c.id, child: Text(c.name)),
                    )
                    .toList(),
                onChanged: (v) => controller.selectedCategoryId.value = v,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 1.5),
                  ),
                ),
              ),
            ),

            _buildField("Description", controller.descriptionC, maxLines: 4),
            _buildField(
              "Price (\$)",
              controller.priceC,
              keyboardType: TextInputType.number,
            ),
            _buildField(
              "Max Participants",
              controller.maxParticipantsC,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 35),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => WorkoutPlanScreen()),
                child: Text(
                  "Continue",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController c, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          label,
          style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        buildTextField(
          label,
          controller: c,
          maxLines: maxLines,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
