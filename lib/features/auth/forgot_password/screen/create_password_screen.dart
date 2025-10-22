import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/auth/forgot_password/controller/forgot_password_controller.dart';

class CreatePasswordScreen extends StatelessWidget {
  CreatePasswordScreen({super.key});

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
              children: [
                CustomAppBarTitle(title: 'Create New Password'),
                const SizedBox(height: 100),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text('Create Your New Password'),
                    Obx(
                      () => TextField(
                        controller: controller.newPasswordController,
                        obscureText: controller.isNewPassObsecure.value,
                        decoration: InputDecoration(
                          hintText: "*********",
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: Colors.grey.shade400,
                          ),
                          suffixIcon: controller.isNewPassObsecure.value
                              ? GestureDetector(
                                  onTap: () {
                                    controller.isNewPassObsecure.value =
                                        !controller.isNewPassObsecure.value;
                                  },
                                  child: ImageIcon(
                                    AssetImage(IconPath.eyecolse),
                                  ),
                                )
                              : IconButton(
                                  color: Colors.grey.shade600,
                                  onPressed: () {
                                    controller.isNewPassObsecure.value =
                                        !controller.isNewPassObsecure.value;
                                  },
                                  icon: Icon(Icons.remove_red_eye_outlined),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    //confirm new password
                    Text('Confirm Your New Password'),
                    Obx(
                      () => TextField(
                        controller: controller.newPassConfirmController,
                        obscureText: controller.isNewPassConfirmObsecure.value,
                        decoration: InputDecoration(
                          hintText: "*********",
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: Colors.grey.shade400,
                          ),
                          suffixIcon: controller.isNewPassConfirmObsecure.value
                              ? GestureDetector(
                                  onTap: () {
                                    controller.isNewPassConfirmObsecure.value =
                                        !controller
                                            .isNewPassConfirmObsecure
                                            .value;
                                  },
                                  child: ImageIcon(
                                    AssetImage(IconPath.eyecolse),
                                  ),
                                )
                              : IconButton(
                                  color: Colors.grey.shade600,
                                  onPressed: () {
                                    controller.isNewPassConfirmObsecure.value =
                                        !controller
                                            .isNewPassConfirmObsecure
                                            .value;
                                  },
                                  icon: Icon(Icons.remove_red_eye_outlined),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                    //Continue button
                    ElevatedButton(
                      onPressed: () {
                      controller.resetPasswordMethod(context);
                       
                      },
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
