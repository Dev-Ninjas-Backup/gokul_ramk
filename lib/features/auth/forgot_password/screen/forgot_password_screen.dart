import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                CustomAppBarTitle(title: 'Forgot Password'),
                Image.asset(Imagepath.forgotBackground),
                Text(
                  'Select which contact details should we use to reset your password',
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.smsSelected.value = true;
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.smsSelected.value
                              ? Colors.green
                              : Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        spacing: 16,
                        children: [
                          Image.asset(Imagepath.forgotMessage, scale: 1.2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('via SMS:'),
                              Text('+1 11 *******99'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.smsSelected.value = false;
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.smsSelected.value
                              ? Colors.grey.shade400
                              : Colors.green,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        spacing: 16,
                        children: [
                          Image.asset(Imagepath.forgotEmail, scale: 1.2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('via email:'),
                              Text('ad********@gmail.com'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.forgotPassVerifyOtpScreen);
                  },
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
