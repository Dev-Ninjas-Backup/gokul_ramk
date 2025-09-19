import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/app_texts.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/controller/tell_about_youselt_controller.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

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
                controller: controller.dateController,
                decoration: InputDecoration(hintText: 'Date'),
                readOnly: true,
                onTap: () {
                  controller.pickDate();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(AppRoute.getUserNavBarScreen());
                },
                child: Text('Continue to Homepage'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
