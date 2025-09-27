import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isObsecure = false.obs;
  RxBool isChecked = false.obs;

  Timer? _timer; // store the timer reference

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => checkUserConnection(),
    );
  }

  Future<void> checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (Get.isDialogOpen == true) {
          Get.back(); // close dialog if internet is back
        }
      }
    } on SocketException catch (_) {
      if (Get.isDialogOpen != true) {
        Get.dialog(
          barrierDismissible: false,
          Dialog(
            child: Container(
              padding: EdgeInsets.all(26),
              child: const Text('No internet connection!'),
            ),
          ),
        );
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel(); // ✅ cancel the timer
    super.onClose();
  }


}
