import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/show_easy_loading_error.dart';

class SignupController extends GetxController {
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
      showEasyLoadingError("Please enter your full name.");
      return false;
    }

    if (emailOrPhone.isEmpty) {
      showEasyLoadingError("Please enter your email or phone number.");
      return false;
    }

    // Simple email or phone check
    if (!emailOrPhone.contains('@') && emailOrPhone.length < 8) {
      showEasyLoadingError("Please enter a valid email or phone number.");
      return false;
    }

    if (password.isEmpty) {
      showEasyLoadingError("Please enter a password.");
      return false;
    }

    if (password.length < 8) {
      showEasyLoadingError("Password must be at least 8 characters long.");
      return false;
    }

    if (confirmPassword.isEmpty) {
      showEasyLoadingError("Please confirm your password.");
      return false;
    }

    if (password != confirmPassword) {
      showEasyLoadingError("Passwords do not match.");
      return false;
    }

    if (role == null || role.isEmpty) {
      showEasyLoadingError("Please select your role.");
      return false;
    }

    return true;
  }
}
