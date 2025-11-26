import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/user/user_community/community_groups/model/groups_model.dart';
import 'package:gokul_ramk/features/user/user_community/community_posts/model/posts_model.dart';
import 'package:gokul_ramk/features/user/user_community/community_posts/service/post_service.dart';

class UserCommunityController extends GetxController {
  final PostService service = PostService(
    client: NetworkClient(
      onUnAuthorize: () {
        EasyLoading.showError("UnAuthorized");
      },
    ),
  );

  var selectedTab = 1.obs;

  var groups = <UserCommunityGroup>[
    UserCommunityGroup(
      title: "Yoga & Mindfulness 🧘",
      imagePath: Imagepath.yogaGroup,
      members: "100k+ Members",
    ),

    UserCommunityGroup(
      title: "Strength & Bodybuilding 💪",
      imagePath: Imagepath.strengthGroup,
      members: "100k+ Members",
    ),

    UserCommunityGroup(
      title: "Weight Loss Journey 🔥",
      imagePath: Imagepath.weightLossGroup,
      members: "100k+ Members",
    ),
  ].obs;

  void toggleJoin(int index) {
    groups[index] = groups[index].copyWith(isJoined: !groups[index].isJoined);
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  var posts = <PostModel>[].obs;
  @override
  void onInit() {
    fetchPostMethod();

    super.onInit();
  }

  var isLoading = false.obs;
  void fetchPostMethod() async {
    isLoading(true);
    try {
      final postList = await service.fetchPost();

      posts.assignAll(postList);
    } catch (e) {
      debugPrint("Error is $e");
    } finally {
      isLoading(false);
    }
  }
}
