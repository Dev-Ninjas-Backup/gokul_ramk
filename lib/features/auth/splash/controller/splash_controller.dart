import 'dart:async';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/features/auth/onboarding/screen/onboarding_screen.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class SplashController extends GetxController {
  SharedPreferencesHelperController pref = Get.put(
    SharedPreferencesHelperController(),
  );
  var currentIndex = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startDotAnimation();

    Future.delayed(Duration(seconds: 3), () async{


    final isLoggedIn = await pref.checkLogin();
    final role = await pref.getSelectedRole();

      if (isLoggedIn == true) {
        if (role == "USER") {
          Get.offAllNamed(AppRoute.userNavBarScreen);
        } else {
          Get.offAllNamed(AppRoute.trainerNavBarScreen);
        }
      } else {
        Get.off(
          () => OnboardingScreen(),
          transition: Transition.fade,
          duration: Duration(milliseconds: 600),
        );
      }

      // Get.off(
      //   () => OnboardingScreen(),
      //   transition: Transition.fade,
      //   duration: Duration(milliseconds: 600),
      // );
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
