import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/common/widgets/custom_label_textfield.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/auth/signup/controller/signup_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                CustomAppBarTitle(title: 'Create Your Account'),
                CustomLabelTextField(
                  label: 'Full Name',
                  icon: Icons.person_4_outlined,
                  hintText: 'Enter your full name',
                  editingController: controller.fullNameController,
                ),
                CustomLabelTextField(
                  label: 'Email or Phone',
                  icon: Icons.email_outlined,
                  hintText: 'Enter your email or phone',
                  editingController: controller.emailController,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    const Text('Password'),
                    TextField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        hintText: '*******',
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    const Text('Confirm Password'),
                    TextField(
                      obscureText: true,
                      controller: controller.confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: '*******',
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    const Text(
                      "Your Role (If you're a trainer then, select trainer)",
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(
                        () => DropdownButton<String>(
                          isExpanded: true,
                          value: controller.selectedRole.value,
                          underline: const SizedBox(),
                          hint: const Text("Select your role"),
                          items: ['USER', 'TRAINER'].map((f) {
                            return DropdownMenuItem<String>(
                              value: f,
                              child: Text(f[0].toUpperCase() + f.substring(1)),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              controller.selectedRole.value = val,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    EasyLoading.show();
                    controller.signUpMethod();
                  },

                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Create Account'),
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or"),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(IconPath.googleIcon),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(IconPath.facebookIcon),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(AppRoute.getloginScreen());
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
