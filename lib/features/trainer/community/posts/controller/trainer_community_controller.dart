import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/community/groups/model/groups_model.dart';
import 'package:gokul_ramk/features/trainer/community/posts/model/posts_model.dart';

class CommunityController extends GetxController {
  var selectedTab = 1.obs;

  var groups = <CommunityGroup>[
    CommunityGroup(
      title: "Yoga & Mindfulness 🧘",
      imagePath: Imagepath.yogaGroup,
      members: "100k+ Members",
    ),

    CommunityGroup(
      title: "Strength & Bodybuilding 💪",
      imagePath: Imagepath.strengthGroup,
      members: "100k+ Members",
    ),

    CommunityGroup(
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

  var posts = <PostModel>[
    PostModel(
      name: "Ricardo Vela",
      username: "@ricvela",
      role: "user",
      imageUrl:
          "https://media.self.com/photos/5b7c4e71ecbb7f4c41c77335/4:3/w_1920%2Cc_limit/triangle-pose-beginner-yoga.jpg",
      likes: 100,
      comments: 100,
      caption:
          "Lorem ipsum dolor sit amet consectetur. Neque interdum ornare elementum elit pulvinar molestie.",
      timeAgo: "10 minutes ago",
    ),
    PostModel(
      name: "Ricardo Vela",
      username: "@ricvela",
      role: "trainer",
      imageUrl:
          "https://media.self.com/photos/5b7c4e71ecbb7f4c41c77335/4:3/w_1920%2Cc_limit/triangle-pose-beginner-yoga.jpg",
      likes: 100,
      comments: 100,
      caption:
          "Lorem ipsum dolor sit amet consectetur. Neque interdum ornare elementum elit pulvinar molestie.",
      timeAgo: "10 minutes ago",
    ),
  ].obs;
}
