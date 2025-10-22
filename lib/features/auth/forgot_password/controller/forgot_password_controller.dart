import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/show_easy_loading_error.dart';
import 'package:gokul_ramk/core/services/auth_service.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
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

  Future<void> forgotPasswordMethod() async {
    try {
EasyLoading();

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
        showEasyLoadingError(message: "loading....");
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

//   //password verify method
//   Future<void> verifyOtpMethod()async{
//    final email2 = await sharedPreferencesHelperController
//           .getEmailOrPhoneValue();
// final response = await authServiceController.requestVerifyOtp(email: email2, otp: "otp");  
//   try {

    
//   } catch (e) {
//   throw Exception("Error: $e");
    
//   }
  
//   }
}
