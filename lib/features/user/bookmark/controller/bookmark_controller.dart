// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/bookmark/model/bookmark_model.dart';
import 'package:gokul_ramk/features/user/bookmark/repository/bookmark_repository.dart';
import 'package:gokul_ramk/features/user/bookmark/service/bookmark_service.dart';

class BookmarkController extends GetxController {
  late BookmarkService _bookmarkService;

  final RxList<BookmarkModel> bookmarks = <BookmarkModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _bookmarkService = BookmarkService(BookmarkRepository());
    fetchBookmarks();
  }

  Future<void> fetchBookmarks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final bookmarkList = await _bookmarkService.fetchBookmarks();
      bookmarks.assignAll(bookmarkList);

      print('✅ Bookmarks loaded: ${bookmarks.length}');
    } catch (e) {
      errorMessage.value = 'Failed to load bookmarks: $e';
      print('❌ Error loading bookmarks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Legacy method for backward compatibility
  List<Map<String, dynamic>> get bookmarkList {
    return bookmarks
        .map(
          (bookmark) => {
            'id': bookmark.id,
            'userId': bookmark.userId,
            'workoutId': bookmark.workoutId,
          },
        )
        .toList();
  }
}
