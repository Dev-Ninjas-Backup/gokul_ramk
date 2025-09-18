import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:gokul_ramk/features/auth/forgot_password/screen/create_password_screen.dart';

import 'package:gokul_ramk/features/bottom_navbar/screen/custom_navbar.dart';

import 'package:gokul_ramk/features/auth/forgot_password/screen/forgot_pass_verify_otp_screen.dart';
import 'package:gokul_ramk/features/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:gokul_ramk/features/auth/login/screen/login_screen.dart';
import 'package:gokul_ramk/features/auth/onboarding/screen/onboarding_screen.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/screen/consent_agrement_screen.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/screen/tell_about_training.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/screen/tell_about_your_goals.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/screen/tell_us_about_yourself_screen1.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/screen/tell_us_about_yourself_screen2.dart';
import 'package:gokul_ramk/features/auth/signup/screen/signup_screen.dart';
import '../features/auth/splash/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = '/onboardingScreen';
  static String loginScreen = '/loginScreen';
  static String signUpScreen = '/signUpScreen';
  static String forgotPasswordScreen = '/forgotPasswordScreen';
  static String forgotPassVerifyOtpScreen = '/forgotPassVerifyOtpScreen';

  static String createNewPasswordScreen = '/createNewPasswordScreen';
  static String tellUsAboutYourselfScreen1 =
      '/signup/tellUsAboutYourselfScreen1';
  static String tellUsAboutYourselfScreen2 =
      '/signup/tellUsAboutYourselfScreen2';
  static String tellUsAboutYourGoalsScreen =
      '/signup/tellUsAboutYourGoalsScreen';
  static String tellUsAboutYourTrainingScreen =
      '/signup/tellUsAboutYourTrainingScreen';
  static String consentAgreementScreen = '/signUp/consentAgreementScreen';



  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getloginScreen() => loginScreen;
  static String getsignUpScreen() => signUpScreen;
  static String getforgotPasswordScreen() => forgotPasswordScreen;
  static String getforgotPassVerifyOtpScreen() => forgotPassVerifyOtpScreen;

  static String getcreateNewPasswordScreen() => createNewPasswordScreen;
  static String gettellUsAboutYourselfScreen1() => tellUsAboutYourselfScreen1;
  static String gettellUsAboutYourselfScreen2() => tellUsAboutYourselfScreen2;
  static String gettellUsAboutYourGoalsScreen() => tellUsAboutYourGoalsScreen;
  static String gettellUsAboutYourTrainingScreen() =>
      tellUsAboutYourTrainingScreen;
  static String getconsentAgreementScreen() => consentAgreementScreen;


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

    GetPage(name: createNewPasswordScreen, page: () => CreatePasswordScreen()),
    GetPage(
      name: tellUsAboutYourselfScreen1,
      page: () => TellUsAboutYourselfScreen1(),
    ),
    GetPage(
      name: tellUsAboutYourselfScreen2,
      page: () => TellUsAboutYourselfScreen2(),
    ),
    GetPage(
      name: tellUsAboutYourGoalsScreen,
      page: () => TellUsAboutYourGoalsScreen(),
    ),
    GetPage(
      name: tellUsAboutYourTrainingScreen,
      page: () => TellUsAboutTrainingScreen(),
    ),
    GetPage(name: consentAgreementScreen, page: () => ConsentAgrementScreen()),


    // home
    GetPage(name: trainerHomeScreen, page: () => NavBarScreen()),
    GetPage(name: trainerHomeScreen, page: () => HomeScreen()),

  ];
}
