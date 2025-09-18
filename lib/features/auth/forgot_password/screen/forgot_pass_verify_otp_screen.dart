import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:pinput/pinput.dart';

class ForgotPassVerifyOtpScreen extends StatelessWidget {
  ForgotPassVerifyOtpScreen({super.key});

  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              CustomAppBarTitle(title: 'Forgot Password'),
              const SizedBox(height: 60),
              Text('Code has been sent to +1 111 ******99'),
              const SizedBox(height: 60),
              Pinput(controller: controller.pinController),
              const SizedBox(height: 60),
              Obx(
                () =>controller.enableResend.value == true? TextButton(
                  onPressed: () {
                    controller.resendCode();
                  },
                  child: Text('Resend Code'),
                ): SizedBox.shrink(),
              ),
              Obx(
                () => Text(
                  'Resend code in ${controller.secondsRemaining.value} s',
                ),
              ),
              const SizedBox(height: 120),
              ElevatedButton(onPressed: () {}, child: Text('Verify')),
            ],
          ),
        ),
      ),
    );
  }
}
