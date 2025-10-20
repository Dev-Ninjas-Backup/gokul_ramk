import 'dart:async';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/features/auth/onboarding/screen/onboarding_screen.dart';

class SplashController extends GetxController {
SharedPreferencesHelperController pref=Get.put(SharedPreferencesHelperController());
  var currentIndex = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startDotAnimation();

    Future.delayed(Duration(seconds: 3), () {


      Get.off(
        () => OnboardingScreen(),
        transition: Transition.fade,
        duration: Duration(milliseconds: 600),
      );
    });
  }

  void _startDotAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      currentIndex.value = (currentIndex.value + 1) % 4;
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
