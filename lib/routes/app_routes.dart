import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";

  static String getSplashScreen() => splashScreen;

  static List<GetPage> routes = [
    // GetPage(name: splashScreen, page: () => const SplashScreen()),
  ];
}
