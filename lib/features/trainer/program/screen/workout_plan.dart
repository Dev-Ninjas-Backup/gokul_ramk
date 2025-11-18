// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
// import '../controller/program_controller.dart';
// import '../model/program_model.dart';
// import '../widgets/text_field.dart';
// import 'program_detail.dart';

// class WorkoutPlanScreen extends StatelessWidget {
//   const WorkoutPlanScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ProgramController());

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
//             Text(
//               "Workout Plan",
//               style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),

//             // ✅ Day Selector with GetX
//             Obx(
//               () => Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(4, (index) {
//                   bool isSelected = controller.selectedDay.value == index;
//                   return Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 4),
//                       child: GestureDetector(
//                         onTap: () => controller.changeDay(index),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.green[50]
//                                 : Colors.grey[200],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Day ${index + 1}",
//                               style: getTextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: isSelected ? Colors.green : Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),

//             SizedBox(height: 24),

//             // ✅ Exercise
//             Text(
//               "Exercise",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             buildTextField("Search exercise", suffixIcon: Icons.search,controller: controller.exerciseIdC),

//             SizedBox(height: 20),

//             // ✅ Sets
//             Text(
//               "Sets",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             buildTextField("Add sets",controller: controller.setsC),

//             SizedBox(height: 20),

//             // ✅ Reps
//             Text(
//               "Reps",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             buildTextField("Add reps",controller: controller.repsC),

//             SizedBox(height: 20),

//             // ✅ Duration
//             Text(
//               "Duration",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             buildTextField("Add Duration",controller: controller.workoutDurationC),

//             SizedBox(height: 24),

//             // ✅ Attach Video
//             Text(
//               "Attach a short video (optional)",
//               style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                 width: double.infinity,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey[300]!),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.image, size: 36, color: Colors.grey),
//                     SizedBox(height: 6),
//                     Text(
//                       "Click here to upload short video",
//                       style: getTextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(height: 32),

//             // ✅ Continue Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(

//  onPressed: controller.submitProgram

//                 // onPressed: () {
//                 //   final controller = Get.find<ProgramController>();

//                 //   final session = WorkoutSession(
//                 //     exercise: "Full Body HIIT", // replace with field value
//                 //     sets: "3",
//                 //     reps: "12",
//                 //     duration: "20 min",
//                 //   );

//                 //   controller.addSession(session);

//                 //   Get.to(() => ProgramDetailsScreen());
//                 // },

//               , child: Text(
//                   "Continue",
//                   style: getTextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/program_controller.dart';
import '../widgets/text_field.dart';

class WorkoutPlanScreen extends StatelessWidget {
  final ProgramController controller = Get.find<ProgramController>();

  WorkoutPlanScreen({super.key});

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
            Text(
              "Workout Plan",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Day Selector
            Obx(
              () => Row(
                children: List.generate(
                  7,
                  
                  (i) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => controller.changeDay(i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 6),
                          decoration: BoxDecoration(
                            color: controller.selectedDay.value == i
                                ? Colors.green[50]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Day ${i + 1}",
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              fontWeight: FontWeight.bold,
                              color: controller.selectedDay.value == i
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            _field(
              "Exercise ID / Name",
              controller.exerciseIdC,
              suffixIcon: Icons.search,
            ),
            _field("Sets", controller.setsC),
            _field("Reps", controller.repsC),
            _field("Duration (minutes)", controller.workoutDurationC),

            const SizedBox(height: 30),
            Text(
              "Intro Video",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(
              () => GestureDetector(
                onTap: controller.pickIntroVideo,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: controller.introVideoFile.value == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.video_call,
                                size: 40,
                                color: Colors.grey,
                              ),
                              Text("Tap to add intro video"),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.video_file,
                                size: 50,
                                color: Colors.green,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: controller.removeIntroVideo,
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

            const SizedBox(height: 40),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitProgram,
                  child: controller.isLoading.value
                      ? const Text("Creating Program...")
                      : Text(
                          "Create Program",
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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

  Widget _field(String label, TextEditingController c, {IconData? suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          label,
          style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        buildTextField(label, controller: c, suffixIcon: suffixIcon),
      ],
    );
  }
}
