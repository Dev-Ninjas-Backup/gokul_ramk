import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/show_easy_loading_error.dart';
import 'package:gokul_ramk/core/services/auth_service.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/auth/signup/widgets/show_dialog.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class SignupController extends GetxController {
  final authServiceController = Get.put(AuthServiceController());
  final SharedPreferencesHelperController sharedPreferencesHelperController =
      Get.put(SharedPreferencesHelperController());

  RxBool smsSelected = false.obs;
  final pinController = TextEditingController();

  var secondsRemaining = 30.obs; // countdown starts from 30 seconds
  var enableResend = true.obs;
  Timer? timer;
  void resendCode() {
    startTimer();
  }

  void startTimer() {
    enableResend.value = false;
    secondsRemaining.value = 60;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        timer.cancel();
      }
    });
  }

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

  Future<void> otpResendRequestMethod() async {
    Map<String, dynamic> emailOrPhone = {};
    if (emailController.text.contains("@")) {
      emailOrPhone = {"email": emailController.text};
    } else {
      emailOrPhone = {"phone": emailController.text};
    }
    if (validateSignup()) {
      final NetworkResponse response = await authServiceController
          .requestRsendotp(email: emailController.text);
      if (response.isSuccess) {
        sharedPreferencesHelperController.saveEmailOrPhone(
          emailOrPhone.containsKey("email")
              ? emailOrPhone["email"]
              : emailOrPhone["phone"],
        );
        Get.toNamed(AppRoute.emailVerificationScreen);
      } else {
        showEasyLoadingError(message: "Signup failed");
      }
      
    }
    
  }

  // Future<void> otpRequestMethod() async {
  //   Map<String, dynamic> emailOrPhone = {};
  //   if (emailController.text.contains("@")) {
  //     emailOrPhone = {"email": emailController.text};
  //   } else {
  //     emailOrPhone = {"phone": emailController.text};
  //   }
  //   if (validateSignup()) {
  //     final NetworkResponse response = await authServiceController
  //         .requestSendotp(email: emailController.text);
  //     if (response.isSuccess==true && response.statusCode==200) {
  //       sharedPreferencesHelperController.saveEmailOrPhone(
  //         emailOrPhone.containsKey("email")
  //             ? emailOrPhone["email"]
  //             : emailOrPhone["phone"],
  //       );
  //       Get.toNamed(AppRoute.emailVerificationScreen);
  //     } else {
  //       showEasyLoadingError(message: "Request Failed");
  //     }
  //   }
  // }

  Future<void> verifyEmailMethod(BuildContext context) async {
    Map<String, dynamic> emailOrPhone = {};
    if (emailController.text.contains("@")) {
      emailOrPhone = {"email": emailController.text};
    } else {
      emailOrPhone = {"phone": emailController.text};
    }
    if (validateSignup()) {
      final NetworkResponse response = await authServiceController
          .requestVerifyEmail(email: emailOrPhone["email"], otp: pinController.text);
      if (response.isSuccess == true && response.statusCode == 200|| response.statusCode==201) {
        // ignore: use_build_context_synchronously
        SuccessDialogEmail.show(context);
      } else {
        showEasyLoadingError(message: "Verification failed");
      }
    }
    
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
      if (response.isSuccess == true && response.statusCode == 200 ||
          response.statusCode == 201) {
        sharedPreferencesHelperController.saveEmailOrPhone(
          emailOrPhone.containsKey("email")
              ? emailOrPhone["email"]
              : emailOrPhone["phone"],
        );
        Get.toNamed(AppRoute.emailVerificationScreen);
      } else {
        showEasyLoadingError(message: "Signup failed");
      }
    }
  }
}
