class Urls {
  static const String baseUrl = 'https://gokul-server.onrender.com';

  static const String logIn = '$baseUrl/auth/login';
  static const String signUp = '$baseUrl/auth/signup';
  //for testing it will be change
  static const String forgotPassword='https://allowed-causal-ladybug.ngrok-free.app/auth/forgot-password';
  static const String verifyotp='$baseUrl/auth/verify-otp';
  static const String resetPassword='$baseUrl/auth/reset-password';
}