import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/app_texts.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/controller/tell_about_youselt_controller.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';

class ConsentAgrementScreen extends StatelessWidget {
  ConsentAgrementScreen({super.key});

  final TellAboutYouseltController controller = Get.put(
    TellAboutYouseltController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            spacing: 22,
            children: [
              TellUsPageHeading(title: 'Consent & Agreement'),
              Text(AppTexts.agreementText),
              TextField(decoration: InputDecoration(hintText: 'Signature')),
              TextField(
                controller: controller.date,
                decoration: InputDecoration(hintText: 'Date'),
                readOnly: true,
                onTap: () {
                  controller.pickDate();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async => await controller.submitOnboarding(),

                // onPressed: () {
                //   Get.offAllNamed(AppRoute.getUserNavBarScreen());
                // },
                child: Text('Continue to Book Trainer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
