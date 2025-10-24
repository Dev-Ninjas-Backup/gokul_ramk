// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/show_easy_loading_error.dart';
import 'package:gokul_ramk/features/auth/sservice/auth_service.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class LoginController extends GetxController {
  AuthServiceController authServiceController = Get.put(
    AuthServiceController(),
  );
  SharedPreferencesHelperController sharedPreferencesHelperController = Get.put(
    SharedPreferencesHelperController(),
  );
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
    _timer?.cancel();
    super.onClose();
  }

  bool validateLogin() {
    final emailOrPhone = emailController.text.trim();
    final password = passwordController.text.trim();

    if (emailOrPhone.isEmpty) {
      showEasyLoadingError(message: 'Please enter email or phone');
      return false;
    }

    if (password.isEmpty) {
      showEasyLoadingError(message: 'Please enter password');
      return false;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^\d{8,15}$');
    if (!emailRegex.hasMatch(emailOrPhone) &&
        !phoneRegex.hasMatch(emailOrPhone)) {
      showEasyLoadingError(
        message: 'Please enter a valid email or phone number',
      );
      return false;
    }

    if (password.length < 8) {
      showEasyLoadingError(message: 'Password must be at least 8 characters');
      return false;
    }

    return true;
  }

  Future<void> loginMethod() async {
    Map<String, dynamic> emailOrPhone = {};
    if (emailController.text.contains("@")) {
      emailOrPhone = {"email": emailController.text};
    } else {
      emailOrPhone = {"phone": emailController.text};
    }
    if (validateLogin()) {
    
      final NetworkResponse response = await authServiceController.login(
        emailOrphone: emailOrPhone,
        password: passwordController.text,
      );
      if (response.isSuccess == true) {
        final access_token = response.responseData?["data"]["access_token"];
        final role = response.responseData?["data"]["user"]["role"];

        await sharedPreferencesHelperController.saveToken(access_token);
        await sharedPreferencesHelperController.saveSelectedRole(role);

        if (role == "TRAINER") {
          Get.offAllNamed(AppRoute.trainerNavBarScreen);
        } else {
          Get.offAllNamed(AppRoute.userNavBarScreen);
        }

        // Get.toNamed(AppRoute.loginScreen);
      } else {
        showEasyLoadingError(message: "LogIn failed");
      }
    }
  }
}
