import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_label_textfield.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/controller/tell_about_youselt_controller.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class TellUsAboutYourselfScreen1 extends StatelessWidget {
  TellUsAboutYourselfScreen1({super.key});

  final TellAboutYouseltController controller = Get.put(
    TellAboutYouseltController(),
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
                    Text('Gender'),
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
                          value: controller.selectedGender.value,
                          underline: const SizedBox(),
                          hint: const Text("Select Your Gender"),
                          items: ['Male', 'Female'].map((f) {
                            return DropdownMenuItem<String>(
                              value: f,
                              child: Text(f[0].toUpperCase() + f.substring(1)),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              controller.selectedGender.value = val,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomLabelTextField(
                  label: 'Your age',
                  editingController: controller.ageController,
                  hintText: 'Enter your age',
                ),

                const SizedBox(height: 16),
                CustomLabelTextField(
                  label: 'Your height',
                  editingController: controller.heightController,
                  hintText: 'Enter your height',
                ),

                const SizedBox(height: 16),
                CustomLabelTextField(
                  label: 'Your weight',
                  editingController: controller.weightController,
                  hintText: 'Enter your weight',
                ),
                const SizedBox(height: 26),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.gettellUsAboutYourselfScreen2());
                  },

                  child: Text('Continue'),
                ),

                const SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.center,
                  'To give you a better experience and results we need to know about you. Please complete these steps so that we can create a personalized experience only for you.',
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
