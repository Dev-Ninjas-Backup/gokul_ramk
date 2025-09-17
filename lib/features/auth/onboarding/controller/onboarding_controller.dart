import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';

class OnboardingController extends GetxController {
  RxInt pageNumber = 0.obs;
  List<String> pageTitleList = [
    'Your Fitness Journey Starts Here',
    'Personalized Workouts & Nutrition',
    'Stay Connected & Engaged',
  ];

  List<String> pageSubTitleList = [
    'Track workouts, connect with trainers, and stay motivated',
    'Get workouts and meal plans tailored to your goals',
    'Join challenges, connect with peers, and celebrate achievements',
  ];

  List<String> buttonTextList = ['Next', 'Next', 'Get Started'];

  List<String> headingImagePathList = [
    Imagepath.onboarding1,
    Imagepath.onboarding2,
    Imagepath.onboarding3,
  ];

  List<String> pageBarImagePathList = [
    Imagepath.pageBar1,
    Imagepath.pageBar2,
    Imagepath.pageBar3,
  ];
}
