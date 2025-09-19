import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_label_textfield.dart';
import 'package:gokul_ramk/features/auth/signup/more_trainer_information/controller/tell_about_trainer_controller.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

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
                //Gender
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text('Area of Service'),
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
                          value: controller.selectedAreaOfService.value,
                          underline: const SizedBox(),
                          hint: const Text("Select your area of service"),
                          items: ['Fitness', 'Health'].map((f) {
                            return DropdownMenuItem<String>(
                              value: f,
                              child: Text(f[0].toUpperCase() + f.substring(1)),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              controller.selectedAreaOfService.value = val,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomLabelTextField(
                  label: 'Bio/experience summary',
                  editingController: controller.bioController,
                  hintText: 'Add bio/experience summary',
                ),

                const SizedBox(height: 16),
                CustomLabelTextField(
                  label: 'Specializations',
                  editingController: controller.specializeController,
                  hintText: 'Add your specializations',
                ),

                const SizedBox(height: 16),
                CustomLabelTextField(
                  label: 'Availability',
                  editingController: controller.availabialityController,
                  hintText: 'Add your availability days in a week ',
                ),

                const SizedBox(height: 16),
                CustomLabelTextField(
                  label: 'Session Types',
                  editingController: controller.sessionController,
                  hintText: 'Add your session types ',
                ),
                const SizedBox(height: 26),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.trainerNavBarScreen);
                  },

                  child: Text('Continue'),
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
