import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gokul_ramk/features/auth/onboarding/screen/onboarding_screen.dart';
import '../features/auth/splash/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = '/onboardingScreen';

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
  ];
}
