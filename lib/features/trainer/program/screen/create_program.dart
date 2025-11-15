import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

import '../controller/program_controller.dart';
import '../widgets/text_field.dart';
import 'workout_plan.dart';

class CreateProgramScreen extends StatelessWidget {
final ProgramController controller = Get.put(ProgramController());
   CreateProgramScreen({super.key});

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
            onPressed: () {
              Get.back();
            },
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Thumbnail
            Text(
              "Thumbnail",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {

              controller.thumbnailPickFromGallery();
              },
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 40, color: Colors.grey),
                    SizedBox(height: 6),
                    Text(
                      "Click here to upload thumbnail image",
                      style: getTextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // ✅ Program Info
            Text(
              "Program Info",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            SizedBox(height: 20),
            Text(
              "Program Name",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Program Name
            buildTextField("Add program name"),

            SizedBox(height: 12),
            SizedBox(height: 20),
            Text(
              "Duration",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Duration with calendar icon
            buildTextField(
              "Add program duration",
              suffixIcon: Icons.calendar_today,
            ),

            SizedBox(height: 12),
            SizedBox(height: 20),
            Text(
              "Category",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Category
            buildTextField("Add program category"),

            SizedBox(height: 12),
            SizedBox(height: 20),
            Text(
              "Description",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Description
            buildTextField(
              "Write a description about this program",
              maxLines: 3,
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final controller = Get.put(ProgramController());

                  controller.createProgram(
                    name: "HIIT Program",
                    duration: "4 weeks",
                    category: "Fat Burn",
                    description:
                        "This program helps burn fat and improve stamina.",
                  );

                  Get.to(() => WorkoutPlanScreen());
                },
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
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
