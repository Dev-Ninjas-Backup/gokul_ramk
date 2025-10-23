// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/show_easy_loading_error.dart';
import 'package:gokul_ramk/core/services/auth_service.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/features/auth/forgot_password/widget/success_dialog.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final authServiceController = Get.put(AuthServiceController());
  final SharedPreferencesHelperController sharedPreferencesHelperController =
      Get.put(SharedPreferencesHelperController());

  RxBool smsSelected = false.obs;
  final pinController = TextEditingController();

  final newPasswordController = TextEditingController();
  RxBool isNewPassObsecure = false.obs;
  final newPassConfirmController = TextEditingController();
  RxBool isNewPassConfirmObsecure = false.obs;

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

  bool validateNewPassword(String password, String confirmPassword) {
    if (password.isEmpty) {
      EasyLoading.show(status: "Password cannot be empty");
      return false;
    } else if (password.length < 8) {
      EasyLoading.show(status: "Password must be at least 8 characters");
      return false;
    } else if (confirmPassword.isEmpty) {
      EasyLoading.show(status: "Confirm password cannot be empty");
      return false;
    } else if (password != confirmPassword) {
      EasyLoading.show(status: "Passwords do not match");
      return false;
    }
    return true;
  }

  Future<void> forgotPasswordMethod() async {
    try {
      EasyLoading.show();

      final email = await sharedPreferencesHelperController
          .getEmailOrPhoneValue();

      if (email == null ||
          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        showEasyLoadingError(
          message: 'No valid email found for password reset.',
        );
        return;
      }

      final response = await authServiceController.requestForgotPassword(
        email: email,
      );
      if (response.isSuccess) {
        Get.toNamed(AppRoute.forgotPassVerifyOtpScreen);
      } else {
        showEasyLoadingError(
          message: 'Failed to request password reset. Please try again.',
        );
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  //password verify method
  Future<void> verityOtpdMethod() async {
    try {
      EasyLoading.show();

      final email = await sharedPreferencesHelperController
          .getEmailOrPhoneValue();

      final response = await authServiceController.requestVerifyOtp(
        email: email.toString(),
        otp: pinController.text,
      );
      if (response.isSuccess) {
        Get.toNamed(AppRoute.createNewPasswordScreen);
      } else {
        showEasyLoadingError(
          message: 'Failed to request password reset. Please try again.',
        );
      }
    } catch (e) {
      throw Exception("Error : $e");
    } finally {
      EasyLoading.dismiss();
    }
  }



  Future<void> resetPasswordMethod( BuildContext context) async {
    try {
      final email = await sharedPreferencesHelperController
          .getEmailOrPhoneValue();

      final newPassword = newPasswordController.text.trim();
      final confirmPassword = newPassConfirmController.text.trim();

      if (validateNewPassword(newPassword, confirmPassword)) {
        final response = await authServiceController.requestResetPassword(
          email: email.toString(),
          newPassword: newPassword,
        );

        if (response.isSuccess && response.statusCode==200||response.statusCode==201) {
          EasyLoading.showSuccess("${response.responseData!['message']}");
          await SuccessDialog.show(context);
        } else if(response.statusCode==400)
        
        
        {
          EasyLoading.showError("${response.responseData!['message']}");
        }
      }
    } catch (e) {
      EasyLoading.showError("Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
