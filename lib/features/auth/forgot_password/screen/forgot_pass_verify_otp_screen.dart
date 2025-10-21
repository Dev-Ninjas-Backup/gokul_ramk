import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';
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
              Pinput(controller: controller.pinController,length: 6,),
              const SizedBox(height: 60),
              Obx(
                () => controller.enableResend.value
                    ? TextButton(
                        onPressed: () {
                          controller.resendCode();
                        },
                        child: Text('Resend Code'),
                      )
                    : SizedBox.shrink(),
              ),
              Obx(
                () => controller.enableResend.value == false
                    ? Text(
                        'Resend code in ${controller.secondsRemaining.value} s',
                      )
                    : SizedBox.shrink(),
              ),
              const SizedBox(height: 120),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoute.createNewPasswordScreen);
                },
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
