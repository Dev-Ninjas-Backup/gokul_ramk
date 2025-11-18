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
              "Duration",
              controller.durationC,
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
