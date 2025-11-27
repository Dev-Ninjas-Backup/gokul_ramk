import 'package:get/get.dart';

import 'package:gokul_ramk/features/auth/forgot_password/screen/create_password_screen.dart';
import 'package:gokul_ramk/features/auth/signup/more_trainer_information/screen/tell_about_trainer_screen.dart';
import 'package:gokul_ramk/features/auth/signup/screen/email_verify_otp_screen.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/screen/booking_details_screen.dart';

import 'package:gokul_ramk/features/trainer/bottom_navbar/screen/custom_navbar.dart';

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
import 'package:gokul_ramk/features/trainer/community/events/screen/create_event_screen.dart';
import 'package:gokul_ramk/features/trainer/community/challenges/screen/create_challenge_screen.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/screen/home_screen.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/sceen/client_profile_screen.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/screen/add_product_screen.dart';
import 'package:gokul_ramk/features/trainer/profile/product_details/screen/product_details_screen.dart';
import 'package:gokul_ramk/features/user/shop/cart/screen/cart_screen.dart';
import 'package:gokul_ramk/features/user/shop/categories/screen/categories_screen.dart';
import 'package:gokul_ramk/features/user/shop/product_detail/screen/product_detail_screen.dart';
import 'package:gokul_ramk/features/user/shop/screen/shop_screen.dart';
import 'package:gokul_ramk/features/user/shop/shipping/screen/order_confirmation_screen.dart';
import 'package:gokul_ramk/features/user/shop/shipping/screen/review_order_screen.dart';
import 'package:gokul_ramk/features/user/shop/shipping/screen/shipping_information_screen.dart';
import 'package:gokul_ramk/features/user/user_chat/screen/chat_screen.dart';
import 'package:gokul_ramk/features/user/user_community/community_challenges/screen/challenge_complete_screen.dart';
import 'package:gokul_ramk/features/user/user_community/community_groups/screen/create_group.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/screen/bookings_screen.dart';
import 'package:gokul_ramk/features/user/bookmark/screen/user_bookmark_screen.dart';
import 'package:gokul_ramk/features/user/bottom_navbar/screen/user_custom_navbar.dart';
import 'package:gokul_ramk/features/user/notification/screen/usere_notification_screen.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/screen/meal_detail_screen.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/screen/plan_detail_screen.dart';
import 'package:gokul_ramk/features/user/session/screen/session_screen.dart';
import 'package:gokul_ramk/features/user/user_home/screen/program_detail_screen.dart';
import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/screen/view_trainer_profile_screen.dart';
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
  static String trainerTellAboutScreen = '/signUp/trainerTellAboutScreen';
  static String emailVerificationScreen = '/signup/emailVerificationScreen';

  //User
  static String userNavBarScreen = "/user/userNavBarScreen";
  static String userNotificationScreen = "/user/userNotificationScreen";
  static String userBookmarkScreen = "/user/userBookmarkScreen";
  static String viewTrainerProfileScreen = "/user/viewTrainerProfileScreen";
  static String bookTrainerScreen = "/user/bookTrainerScreen";
  static String userSessionsScreen = "/user/userSessionsScreen";
  static String mealDetailScreen = "/user/mealDetailScreen";
  static String planDetailScreen = "/user/planDetailScreen";
  static String categoriesScreen = "/user/shop/categoriesScreen";
  static String productDetailScreen = "/user/shop/productDetailScreen";
  static String userCartScreen = "/user/shop/userCartScreen";
  static String reviewOrderScreen = "/user/shop/reviewOrderScreen";
  static String userShopScreen = "/user/shop";
  static String userChatScreen = "/user/userChatScreen";
  static String completeChallengeScreen = "/user/completeChallengeScreen";
  static String userCreateGroupScreen = "/user/community/userCreateGroupScreen";
  static String programDetailScreen = "/user/home/programDetailScreen";
  static String orderConfirmationScreen = "/user/shop/orderConfirmationScreen";
  static String shippingInformationScreen =
      "/user/shop/shippingInformationScreen";

  // Trainer
  static String trainerHomeScreen = "/trainer/trainerHomeScreen";
  static String trainerNavBarScreen = "/trainer/trainerNavBarScreen";
  static String clientProfileScreen = "/clientProfileScreen";
  static String bookingDetailsScreen = "/bookingDetailsScreen";
  static String addProducts = "/addProducts";
  static String productDetails = "/productDetails";
  static String createEvent = '/tainer/createEvent';
  static String createChallenge = '/trainer/createChallenge';

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getloginScreen() => loginScreen;
  static String getsignUpScreen() => signUpScreen;
  static String getemailVerificationScreen() => emailVerificationScreen;
  static String getforgotPasswordScreen() => forgotPasswordScreen;
  static String getforgotPassVerifyOtpScreen() => forgotPassVerifyOtpScreen;

  static String getcreateNewPasswordScreen() => createNewPasswordScreen;
  static String gettellUsAboutYourselfScreen1() => tellUsAboutYourselfScreen1;
  static String gettellUsAboutYourselfScreen2() => tellUsAboutYourselfScreen2;
  static String gettellUsAboutYourGoalsScreen() => tellUsAboutYourGoalsScreen;
  static String gettellUsAboutYourTrainingScreen() =>
      tellUsAboutYourTrainingScreen;
  static String getconsentAgreementScreen() => consentAgreementScreen;
  static String getTrainerTellAboutScreen() => trainerTellAboutScreen;
  static String getProgramDetailScreen() => programDetailScreen;
  static String getCreateEvent() => createEvent;
  static String getCreateChallenge() => createChallenge;

  //user
  static String getUserNavBarScreen() => userNavBarScreen;
  static String getUserNotificationScreen() => userNotificationScreen;
  static String getUserBookmarkScreen() => userBookmarkScreen;
  static String getViewTrainerProfileScreen() => viewTrainerProfileScreen;
  static String getbookTrainerScreen() => bookTrainerScreen;
  static String getClientProfileScreen() => clientProfileScreen;
  static String getUserSessionsScreen() => userSessionsScreen;
  static String getBookingDetailsScreen() => bookingDetailsScreen;

  static String getMealDetailScreen() => mealDetailScreen;
  static String getPlanDetailScreen() => planDetailScreen;
  static String getCategoriesScreen() => categoriesScreen;

  static String getCompleteChallengeScreen() => completeChallengeScreen;

  static String getProductDetailScreen() => productDetailScreen;
  static String getUserCartScreen() => userCartScreen;
  static String getShippingInformationScreen() => shippingInformationScreen;
  static String getReviewOrderScreen() => reviewOrderScreen;
  static String getOrderConfirmationScreen() => orderConfirmationScreen;
  static String getUserShopScreen() => userShopScreen;
  static String getUserChatScreen() => userChatScreen;
  static String getUserCreateGroupScreen() => userCreateGroupScreen;
  static String getAddProducts() => addProducts;
  static String getProductDetails() => productDetails;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignupScreen()),
    GetPage(name: emailVerificationScreen, page: () => EmailVerifyOtpScreen()),
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
    GetPage(name: trainerTellAboutScreen, page: () => TellAboutTrainerScreen()),

    //User
    GetPage(name: userNavBarScreen, page: () => UserNavBarScreen()),
    GetPage(
      name: userNotificationScreen,
      page: () => UsereNotificationScreen(),
    ),
    GetPage(name: userBookmarkScreen, page: () => UserBookmarkScreen()),
    GetPage(
      name: viewTrainerProfileScreen,
      page: () => ViewTrainerProfileScreen(),
    ),
    GetPage(name: bookTrainerScreen, page: () => BookTrainerScreen()),
    GetPage(name: userSessionsScreen, page: () => SessionsScreen()),
    GetPage(name: mealDetailScreen, page: () => MealDetailScreen()),
    GetPage(name: planDetailScreen, page: () => PlanDetailScreen()),
    GetPage(name: categoriesScreen, page: () => CategoriesScreen()),
    GetPage(name: productDetailScreen, page: () => ProductDetailScreen()),
    GetPage(name: userCartScreen, page: () => CartScreen()),
    GetPage(name: reviewOrderScreen, page: () => ReviewOrderScreen()),
    GetPage(
      name: orderConfirmationScreen,
      page: () => OrderConfirmationScreen(),
    ),
    GetPage(name: userShopScreen, page: () => ShopScreen()),
    GetPage(
      name: shippingInformationScreen,
      page: () => ShippingInformationScreen(),
    ),
    GetPage(name: userChatScreen, page: () => ChatScreen()),
    GetPage(name: programDetailScreen, page: () => ProgramDetailsScreen()),
    GetPage(name: userCreateGroupScreen, page: () => UserCreateGroupScreen()),
    GetPage(
      name: completeChallengeScreen,
      page: () => ChallengeCompleteScreen(),
    ),

    // Trainer
    GetPage(name: trainerNavBarScreen, page: () => NavBarScreen()),
    GetPage(name: trainerHomeScreen, page: () => HomeScreen()),
    GetPage(name: clientProfileScreen, page: () => ClientProfileScreen()),
    GetPage(
      name: bookingDetailsScreen,
      page: () {
        final bookingId = Get.parameters['bookingId'] ?? '';
        return BookingDetailsScreen(bookingId: bookingId);
      },
    ),
    GetPage(name: addProducts, page: () => AddProductScreen()),
    GetPage(name: productDetails, page: () => ProductDetailsScreen()),
    GetPage(name: createEvent, page: () => CreateEventScreen()),
    GetPage(name: createChallenge, page: () => CreateChallengeScreen()),
  ];
}
