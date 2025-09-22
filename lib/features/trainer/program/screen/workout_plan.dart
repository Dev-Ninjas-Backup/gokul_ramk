import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/program_controller.dart';
import '../model/program_model.dart';
import '../widgets/text_field.dart';
import 'program_detail.dart';

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProgramController());

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
            Text(
              "Workout Plan",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // ✅ Day Selector with GetX
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  bool isSelected = controller.selectedDay.value == index;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => controller.changeDay(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.green[50]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Day ${index + 1}",
                              style: getTextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.green : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 24),

            // ✅ Exercise
            Text(
              "Exercise",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            buildTextField("Search exercise", suffixIcon: Icons.search),

            SizedBox(height: 20),

            // ✅ Sets
            Text(
              "Sets",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            buildTextField("Add sets"),

            SizedBox(height: 20),

            // ✅ Reps
            Text(
              "Reps",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            buildTextField("Add reps"),

            SizedBox(height: 20),

            // ✅ Duration
            Text(
              "Duration",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            buildTextField("Add reps"),

            SizedBox(height: 24),

            // ✅ Attach Video
            Text(
              "Attach a short video (optional)",
              style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 36, color: Colors.grey),
                    SizedBox(height: 6),
                    Text(
                      "Click here to upload short video",
                      style: getTextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32),

            // ✅ Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final controller = Get.find<ProgramController>();

                  final session = WorkoutSession(
                    exercise: "Full Body HIIT", // replace with field value
                    sets: "3",
                    reps: "12",
                    duration: "20 min",
                  );

                  controller.addSession(session);

                  Get.to(() => ProgramDetailsScreen());
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
          ],
        ),
      ),
    );
  }
}
