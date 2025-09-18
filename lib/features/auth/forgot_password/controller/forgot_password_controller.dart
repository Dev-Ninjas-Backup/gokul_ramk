import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool smsSelected = false.obs;
  final pinController = TextEditingController();

  var secondsRemaining = 30.obs; // countdown starts from 30 seconds
  var enableResend = false.obs;
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
}
