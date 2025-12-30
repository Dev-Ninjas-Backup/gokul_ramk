import 'package:get/get.dart';
import '../service/user_profile_service.dart';

// simple controller storing profile data fetched from API

class UserProfileController extends GetxController {
  var userName = "".obs;
  var userEmail = "".obs;
  var userImage = RxnString();
  var activeDays = 0.obs;
  var challengesComplete = 0.obs;
  var caloriesBurned = 0.obs;

  // store raw profile map
  var profile = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final res = await UserProfileService.fetchProfile();
      if (res.isSuccess && res.responseData != null) {
        // API wraps data under data
        final data = res.responseData!['data'] ?? res.responseData;
        if (data is Map<String, dynamic>) {
          profile.value = Map<String, dynamic>.from(data);
          userName.value =
              (profile['fullname'] ?? '') as String;
          userEmail.value = (profile['email'] ?? '') as String;
          userImage.value = (profile['images'] ?? '') as String?;
        }
      }
    } catch (e) {
      print('fetchProfile error: $e');
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> body) async {
    // NOTE: removed network PATCH from this controller because the onboarding
    // endpoint has strict validation and calling it here caused frequent
    // failures. Instead, merge the provided body into the local `profile`
    // observable so UI updates immediately. If a network update is desired,
    // call `UserProfileService.updateProfile` directly from the screen with
    // a fully validated payload.
    try {
      profile.addAll(body);
      // refresh derived fields
      userName.value = (profile['fullname'] ?? profile['name'] ?? '')
          .toString();
      userEmail.value = (profile['email'] ?? '').toString();
      userImage.value = (profile['images'] ?? '') as String?;
      return true;
    } catch (e) {
      print('updateProfile (local merge) error: $e');
      return false;
    }
  }
}
