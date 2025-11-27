import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/community/challenges/controller/challenges_controller.dart';

import '../../../program/widgets/text_field.dart';

class CreateChallengeScreen extends StatefulWidget {
  const CreateChallengeScreen({super.key});

  @override
  State<CreateChallengeScreen> createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends State<CreateChallengeScreen> {
  late ChallengesController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChallengesController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarTitle(title: 'Create Challenge'),
              const SizedBox(height: 16),

              // Thumbnail/Cover Image
              Text(
                "Cover Image",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Obx(
                () => GestureDetector(
                  onTap: () => controller.pickCoverImage(),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: controller.selectedImage.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  controller.selectedImage.value!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Click here to upload cover image",
                                    style: getTextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                      ),
                      // Delete image button
                      if (controller.selectedImage.value != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => controller.clearImage(),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.close,
                                size: 24,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Challenge Info Section
              Text(
                "Challenge Info",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),
              Text(
                "Challenge Title",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              buildTextField(
                "Enter challenge title",
                controller: controller.challengeTitle,
              ),

              SizedBox(height: 20),
              Text(
                "Description",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              buildTextField(
                "Write a description about this challenge",
                maxLines: 3,
                controller: controller.challengeDescription,
              ),

              SizedBox(height: 20),
              Text(
                "Challenge Format",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Obx(
                () => Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedFormat.value,
                    hint: Text('Select challenge format'),
                    underline: SizedBox.shrink(),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, size: 18),
                    items: controller.options
                        .map(
                          (format) => DropdownMenuItem(
                            value: format,
                            child: Text(
                              format,
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.fontColor,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedFormat.value = value;
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Challenge Location",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Obx(
                () => AbsorbPointer(
                  absorbing: controller.selectedFormat.value == 'ONLINE',
                  child: Opacity(
                    opacity: controller.selectedFormat.value == 'ONLINE'
                        ? 0.5
                        : 1.0,
                    child: buildTextField(
                      "Enter challenge location",
                      suffixIcon: Icons.location_on_outlined,
                      controller: controller.challengeLocation,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Challenge Category",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Obx(
                () => Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedCategory.value,
                    hint: Text('Select challenge category'),
                    underline: SizedBox.shrink(),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, size: 18),
                    items: controller.categoryOptions
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.fontColor,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedCategory.value = value;
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Target Value",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              buildTextField(
                "e.g., 1000",
                controller: controller.targetValue,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20),
              Text(
                "Target Unit",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              buildTextField(
                "e.g., kilometers, steps, minutes",
                controller: controller.targetUnit,
              ),

              SizedBox(height: 20),
              Text(
                "Start Date & Time",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Obx(
                () => GestureDetector(
                  onTap: () => controller.selectStartDate(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.startDate.value != null
                                ? _formatDateTime(controller.startDate.value!)
                                : "Select start date",
                            style: getTextStyle(
                              fontSize: 14,
                              color: controller.startDate.value != null
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "End Date & Time",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Obx(
                () => GestureDetector(
                  onTap: () => controller.selectEndDate(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.endDate.value != null
                                ? _formatDateTime(controller.endDate.value!)
                                : "Select end date",
                            style: getTextStyle(
                              fontSize: 14,
                              color: controller.endDate.value != null
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[50],
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: getTextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF148CBB),
                        ),
                        onPressed: controller.isCreatingChallenge.value
                            ? null
                            : () => controller.createChallenge(),
                        child: controller.isCreatingChallenge.value
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text("Create Challenge"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
  }
}
