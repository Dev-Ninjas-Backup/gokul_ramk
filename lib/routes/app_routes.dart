import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gokul_ramk/core/common/widgets/custom_navbar.dart';
import 'package:gokul_ramk/features/auth/forgot_password/screen/forgot_pass_verify_otp_screen.dart';
import 'package:gokul_ramk/features/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:gokul_ramk/features/auth/login/screen/login_screen.dart';
import 'package:gokul_ramk/features/auth/onboarding/screen/onboarding_screen.dart';
import 'package:gokul_ramk/features/auth/signup/screen/signup_screen.dart';
import '../features/auth/splash/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = '/onboardingScreen';
  static String loginScreen = '/loginScreen';
  static String signUpScreen = '/signUpScreen';
  static String forgotPasswordScreen = '/forgotPasswordScreen';
  static String forgotPassVerifyOtpScreen = '/forgotPassVerifyOtpScreen';

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getloginScreen() => loginScreen;
  static String getsignUpScreen() => signUpScreen;
  static String getforgotPasswordScreen() => forgotPasswordScreen;
  static String getforgotPassVerifyOtpScreen() => forgotPassVerifyOtpScreen;

  // home
  static String trainerHomeScreen = "/trainer/homeScreen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignupScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(
      name: forgotPassVerifyOtpScreen,
      page: () => ForgotPassVerifyOtpScreen(),
    ),

    // home
    GetPage(name: trainerHomeScreen, page: () => HomeScreen()),
  ];
}
