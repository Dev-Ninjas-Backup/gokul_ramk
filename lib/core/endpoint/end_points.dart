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
  static const String productCategories = '$baseUrl/product-category';
  static const String getProducts = '$baseUrl/product';

  //trainer post
  static const String trainerPost = '$baseUrl/post';
  //user onboarding(tell us about yourseft)
  static const String tellAboutOnboarding = "$baseUrl/user/onbording-step/me";
  static const String userProfile = "$baseUrl/user/profile/me";
  static const String trainerProfile = "$baseUrl/trainer";
  //categories/workout
  static const String categories = "$baseUrl/categories";
  static const String workOuts = "$baseUrl/workouts";
  static const String featureWorkout = "$baseUrl/workouts/feature-workouts";
  //user shop
  static const String productcategories = "$baseUrl/product-category";
  static const String products = "$baseUrl/product";

  //user get post
  static const String getPost = "$baseUrl/post";

  //trainer meal plan
  static const String createMeal = "$baseUrl/meal-plan/create-meal";
  static const String uploadFile = "$baseUrl/upload";
  static const String uploadMultiple = "$baseUrl/upload/multiple";
  static const String createMealPlan = "$baseUrl/meal-plan/create-plan";
  static const String getMeal = "$baseUrl/meal-plan/meal";
  static const String getMealPlan = "$baseUrl/meal-plan/plan";

  // Post comments endpoints
  static String getPostComments(String postId) => "$getPost/$postId/comment";
  static String addPostComment(String postId) => "$getPost/$postId/comment";

  // Group endpoints
  static const String createGroup = "$baseUrl/group";
  static const String getGroups = "$baseUrl/group";
  static String joinGroup(String groupId) => "$baseUrl/group/$groupId/join";
  static String leaveGroup(String groupId) => "$baseUrl/group/$groupId/leave";

  // Trainer endpoints
  static const String trainerProfileMe = "$baseUrl/trainer";

  // Events endpoints
  static const String createEvent = "$baseUrl/events";
  static const String getEvents = "$baseUrl/events";
  static String joinEvent(String eventId) => "$baseUrl/events/$eventId/join";

  //trainer
  static const String getTrainer = "$baseUrl/trainer/all-trainers";

  // Bookings endpoints
  static const String getBookings = "$baseUrl/bookings";
  static const String getTopTrainer="$baseUrl/trainer/top-trainers";
}
