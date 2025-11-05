import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/auth/login/controller/login_controller.dart';
import 'package:gokul_ramk/features/auth/login/service/google_sign_in_services.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  "Welcome Back!",
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Your fitness journey continues here.",
                  style: getTextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 50),

                // Email
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your email or phone",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.isObsecure.value,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: controller.isObsecure.value
                          ? GestureDetector(
                              onTap: () {
                                controller.isObsecure.value =
                                    !controller.isObsecure.value;
                              },
                              child: ImageIcon(AssetImage(IconPath.eyecolse)),
                            )
                          : IconButton(
                              color: Colors.grey.shade600,
                              onPressed: () {
                                controller.isObsecure.value =
                                    !controller.isObsecure.value;
                              },
                              icon: Icon(Icons.remove_red_eye_outlined),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Remember me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.isChecked.value,
                            activeColor: Colors.blueAccent,
                            onChanged: (val) {
                              if (val != null) {
                                controller.isChecked.value = val;
                              }
                            },
                          ),
                        ),
                        Text("Remember me"),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.getforgotPasswordScreen());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Login Button
                ElevatedButton(
                  onPressed: () async {
                    controller.loginMethod();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                  ),
                  child: Text('Login'),
                ),

                const SizedBox(height: 40),

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
                const SizedBox(height: 20),

                // Social Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    InkWell(
                      onTap: () async {
                        final GoogleSignInService googleService =
                            GoogleSignInService();
                        if (googleService.isAuthorized == false) {
                          await googleService.signIn();
                        }
                      },
                      child: Image.asset(IconPath.googleIcon),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(IconPath.facebookIcon),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.getsignUpScreen());
                        print("djfidshfdisfjdisfj ");
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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
