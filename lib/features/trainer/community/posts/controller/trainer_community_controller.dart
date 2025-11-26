import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/community/groups/model/groups_model.dart';
import 'package:gokul_ramk/features/trainer/community/posts/model/posts_model.dart';
import 'package:gokul_ramk/features/trainer/community/posts/repository/post_repository.dart';

class CommunityController extends GetxController {
  var selectedTab = 0.obs;

  // Posts pagination
  late PostRepository postRepository;
  var posts = <PostModel>[].obs;
  var isLoadingPosts = false.obs;
  var currentPage = 1;
  var postsPerPage = 10;
  var hasMorePosts = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize PostRepository with NetworkClient
    final networkClient = Get.find<NetworkClient>();
    postRepository = PostRepository(networkClient: networkClient);
    loadMorePosts();
  }

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

  // Load more posts with pagination
  Future<void> loadMorePosts() async {
    if (isLoadingPosts.value || !hasMorePosts.value) return;

    isLoadingPosts.value = true;
    try {
      final newPosts = await postRepository.getPosts(
        page: currentPage,
        limit: postsPerPage,
        sortBy: 'createdAt',
      );

      if (newPosts.isEmpty) {
        hasMorePosts.value = false;
      } else {
        posts.addAll(newPosts);
        currentPage++;
      }
    } catch (e) {
      print('Error loading posts: $e');
      hasMorePosts.value = false;
    } finally {
      isLoadingPosts.value = false;
    }
  }

  // Refresh posts (clear and reload from page 1)
  Future<void> refreshPosts() async {
    posts.clear();
    currentPage = 1;
    hasMorePosts.value = true;
    await loadMorePosts();
  }
}
