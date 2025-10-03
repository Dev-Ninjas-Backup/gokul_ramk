import 'package:get/get.dart';

class UserHomeController extends GetxController {
  RxBool joinedHitProgram = false.obs;

  var progress = 0.65.obs; // 65% progress

  final List<Map<String, dynamic>> workoutList = [
    {
      "title": "Full Body Stretching",
      "subtitle": "10 minutes | Intermediate",
      "image":
          "https://images.pexels.com/photos/3823039/pexels-photo-3823039.jpeg",
      "isBookmarked": true,
    },
    {
      "title": "Yoga",
      "subtitle": "15 minutes | Basic",
      "image":
          "https://images.pexels.com/photos/3823037/pexels-photo-3823037.jpeg",
      "isBookmarked": false,
    },
  ];

  final List<Map<String, dynamic>> highlightList = [
    {
      "title": "Full Body Burn 🔥",
      "subtitle": "20 min | Intermediate",
      "buttonText": "Start Now",
      "image":
          "https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg",
    },
    {
      "title": "Try this: Quinoa Salad 🥗",
      "subtitle": "For post-workout recovery",
      "buttonText": "Order Now",
      "image":
          "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
    },
  ];

  var selectedCategory = "All Workouts".obs;

  final categories = [
    "All Workouts",
    "Yoga",
    "Intense Gym",
    "Focus Training",
    "Full Body",
  ];

  final stats = {
    "Steps": "5,320 / 8,000",
    "Workout Time": "32 min",
    "Calories Burned": "420 kcal",
  };

  final RxInt currentSliderIndex = 0.obs;

  void updateSliderIndex(int index) {
    currentSliderIndex.value = index;
  }

  final List<String> imageUrls = [
    'https://www.mlchc.org/sites/default/files/styles/max_650x650/public/2022-03/nutrition_image2.jpg',
    'https://www.weljii.com/wp-content/uploads/2024/06/apr-1.jpg',
  ];

  var selectedFeaturedWorkout = "All Workouts".obs;

  final filters = ["All Workouts", "Online", "In person", "Hybrid"];

  RxString duration = "4 weeks".obs;
  RxString type = "Fat Burn".obs;
  RxString description =
      "This 30-day program combines HIIT, strength training, and nutrition guidance to help you burn fat and boost stamina."
          .obs;

  RxList workoutSchedule = [
    "Day 1: Full Body HIIT - 20 min | Burn calories",
    "Day 3: Upper Body Strength - Push & pull focus",
    "Day 5: Core & Flexibility - Improve balance",
  ].obs;
}
