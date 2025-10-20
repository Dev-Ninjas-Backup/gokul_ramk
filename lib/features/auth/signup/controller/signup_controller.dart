import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/show_easy_loading_error.dart';
import 'package:gokul_ramk/core/services/auth_service.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class SignupController extends GetxController {
  final authServiceController = Get.put(AuthServiceController());
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var selectedRole = RxnString();

  bool validateSignup() {
    final fullName = fullNameController.text.trim();
    final emailOrPhone = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final role = selectedRole.value;

    if (fullName.isEmpty) {
      showEasyLoadingError(message: "Please enter your full name.");
      return false;
    }

    if (emailOrPhone.isEmpty) {
      showEasyLoadingError(message: "Please enter your email or phone number.");
      return false;
    }

    // Simple email or phone check
    if (!emailOrPhone.contains('@') && emailOrPhone.length < 8) {
      showEasyLoadingError(
        message: "Please enter a valid email or phone number.",
      );
      return false;
    }

    if (password.isEmpty) {
      showEasyLoadingError(message: "Please enter a password.");
      return false;
    }

    if (password.length < 8) {
      showEasyLoadingError(
        message: "Password must be at least 8 characters long.",
      );
      return false;
    }

    if (confirmPassword.isEmpty) {
      showEasyLoadingError(message: "Please confirm your password.");
      return false;
    }

    if (password != confirmPassword) {
      showEasyLoadingError(message: "Passwords do not match.");
      return false;
    }

    if (role == null || role.isEmpty) {
      showEasyLoadingError(message: "Please select your role.");
      return false;
    }

    return true;
  }

  Future<void> signUpMethod() async {
    Map<String, dynamic> emailOrPhone = {};
    if (emailController.text.contains("@")) {
      emailOrPhone = {"email": emailController.text};
    } else {
      emailOrPhone = {"phone": emailController.text};
    }
    if (validateSignup()) {
      final NetworkResponse response = await authServiceController.signUp(
        fullName: fullNameController.text,
        emailOrPhone: emailOrPhone,
        password: passwordController.text,
        role: selectedRole.value!,
      );
      if (response.isSuccess) {
        Get.toNamed(AppRoute.loginScreen);
      } else {
        showEasyLoadingError(message: "Signup failed");
      }
    }
  }
}
