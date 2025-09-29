import 'package:get/get.dart';

class UserNavBarController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }


  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      currentIndex.value = Get.arguments as int;
    }
  }
}
