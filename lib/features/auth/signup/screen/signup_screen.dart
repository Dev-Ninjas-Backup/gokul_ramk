import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/common/widgets/custom_label_textfield.dart';
import 'package:gokul_ramk/core/common/widgets/show_easy_loading_error.dart';
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
                //Full Name
                CustomLabelTextField(
                  label: 'Full Name',
                  icon: Icons.person_4_outlined,
                  hintText: 'Enter your full name',
                  editingController: controller.fullNameController,
                ),
                //Email
                CustomLabelTextField(
                  label: 'Email or Phone',
                  icon: Icons.email_outlined,
                  hintText: 'Enter your email or phone',
                  editingController: controller.emailController,
                ),
                //Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text('Password'),
                    TextField(
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
                //Confirm Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text('Confirm Password'),
                    TextField(
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
                //Select Role
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text(
                      "Your Role (If you're a trainer then, select trainer)",
                    ),
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
                          value: controller.selectedRole.value,
                          underline: const SizedBox(),
                          hint: const Text("Select your role"),
                          items: ['User', 'Trainer'].map((f) {
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
                //create account button
                ElevatedButton(
                  onPressed: () {
                    if (controller.selectedRole.value == 'User') {
                      Get.toNamed(AppRoute.gettellUsAboutYourselfScreen1());
                    } else if (controller.selectedRole.value == 'Trainer') {
                      Get.toNamed(AppRoute.getTrainerTellAboutScreen());
                    } else {
                      showEasyLoadingError();
                    }
                  },
                  child: Text('Create Account'),
                ),
                const SizedBox(height: 10),
                // Divider
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 10),

                // Social Login
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

                // Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(AppRoute.getloginScreen());
                      },
                      child: Text(
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


