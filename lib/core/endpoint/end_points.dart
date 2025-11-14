class Urls {
  // static const String baseUrl = 'https://gokul-server.onrender.com';
  static const String baseUrl = 'https://wellfitsync.com';

  static const String logIn = '$baseUrl/auth/login';
  static const String signUp = '$baseUrl/auth/signup';
  static const String verifyEmail = '$baseUrl/auth/verify-email';
  static const String resendOtp = '$baseUrl/auth/resend-otp';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';
  static const String verifyotp = '$baseUrl/auth/verify-otp';
  static const String resetPassword = '$baseUrl/auth/reset-password';

  static const String createNewProductUrl = '$baseUrl/product/create-product';



  //trainer post
  static const String trainerPost='$baseUrl/post';
  //user onboarding(tell us about yourseft)
  static const String tellAboutOnboarding="$baseUrl/user/onbording-step/me";
  static const String userProfile="$baseUrl/user/profile/me";
}
