// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gokul_ramk/core/common/widgets/custom_label_textfield.dart';
// import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/controller/tell_about_youselt_controller.dart';
// import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';
// import 'package:gokul_ramk/routes/app_routes.dart';

// class TellUsAboutYourselfScreen2 extends StatelessWidget {
//   TellUsAboutYourselfScreen2({super.key});

//   final TellAboutYouseltController controller = Get.put(
//     TellAboutYouseltController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TellUsPageHeading(),

//                 const SizedBox(height: 16),
//                 CustomLabelTextField(
//                   label: 'Do you have any known heart condition?',
//                   editingController: controller.heartCondition,
//                   hintText: 'Yes/No',
//                 ),

//                 const SizedBox(height: 16),
//                 CustomLabelTextField(
//                   label: 'Do you feel chest pain during activity?',
//                   editingController: controller.chestPainController,
//                   hintText: 'Yes/No',
//                 ),

//                 const SizedBox(height: 16),
//                 CustomLabelTextField(
//                   label: 'Are you currently on any medication?',
//                   editingController: controller.medicationController,
//                   hintText: 'Yes/No',
//                 ),

//                 const SizedBox(height: 16),
//                 CustomLabelTextField(
//                   label: 'Do you have any injury that limits your activity?',
//                   editingController: controller.injuryController,
//                   hintText: 'Yes/No',
//                 ),

//                 const SizedBox(height: 16),
//                 CustomLabelTextField(
//                   label: 'Do you feel dizzy or faint during exercise?',
//                   editingController: controller.dizzyController,
//                   hintText: 'Yes/No',
//                 ),

//                 const SizedBox(height: 16),
//                 CustomLabelTextField(
//                   label: 'Any past surgeries affecting exercise?',
//                   editingController: controller.pastSurgeryController,
//                   hintText: 'Yes/No',
//                 ),
//                 const SizedBox(height: 26),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.toNamed(AppRoute.gettellUsAboutYourGoalsScreen());
//                   },
//                   child: Text('Continue'),
//                 ),

//                 const SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/controller/tell_about_youselt_controller.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class TellUsAboutYourselfScreen2 extends StatelessWidget {
  TellUsAboutYourselfScreen2({super.key});

  final controller = Get.put(TellAboutYouseltController());

  @override
  Widget build(BuildContext context) {
    Widget buildBoolQuestion(String label, RxBool value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Obx(
            () => Row(
              children: [
                ChoiceChip(
                  label: const Text("Yes"),
                  selected: value.value == true,
                  onSelected: (_) => value.value = true,
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text("No"),
                  selected: value.value == false,
                  onSelected: (_) => value.value = false,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TellUsPageHeading(),
                const SizedBox(height: 16),

                buildBoolQuestion('Do you have any known heart condition?', controller.heartCondition),
                const SizedBox(height: 16),

                buildBoolQuestion('Do you feel chest pain during activity?', controller.chestPain),
                const SizedBox(height: 16),

                buildBoolQuestion('Are you currently on any medication?', controller.medication),
                const SizedBox(height: 16),

                buildBoolQuestion('Do you have any injury that limits your activity?', controller.hasInjuries),
                const SizedBox(height: 16),

                buildBoolQuestion('Do you feel dizzy or faint during exercise?', controller.hasDizziness),
                const SizedBox(height: 16),

                buildBoolQuestion('Any past surgeries affecting exercise?', controller.hasSurgery),

                const SizedBox(height: 26),
                ElevatedButton(
                  onPressed: () {
                    // You can send bool values to API directly here
                    final data = {
                      "heartCondition": controller.heartCondition.value,
                      "chestPain": controller.chestPain.value,
                      "medication": controller.medication.value,
                      "injury": controller.hasInjuries.value,
                      "dizzy": controller.hasDizziness.value,
                      "pastSurgery": controller.hasSurgery.value,
                    };
                    if (kDebugMode) {
                      print(data);
                    } // for debug
                    Get.toNamed(AppRoute.gettellUsAboutYourGoalsScreen());
                  },
                  child: const Text('Continue'),
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
