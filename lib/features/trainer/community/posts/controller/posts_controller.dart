import 'package:get/get.dart';

import '../../../../../core/utils/constants/imagepath.dart';
import '../../groups/model/groups_model.dart';

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
}
