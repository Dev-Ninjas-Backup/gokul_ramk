import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/user/bookmark/controller/bookmark_controller.dart';
import 'package:gokul_ramk/features/user/bookmark/widget/bookmark_widget.dart';

class UserBookmarkScreen extends StatelessWidget {
  UserBookmarkScreen({super.key});

  final BookmarkController controller = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              CustomAppBarTitle(title: 'My Bookmarks'),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  }

                  if (controller.bookmarks.isEmpty) {
                    return const Center(child: Text('No bookmarks found'));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: controller.bookmarks.length,
                    itemBuilder: (context, index) {
                      final bookmark = controller.bookmarks[index];
                      final workout = bookmark.workoutDetails;

                      return BookmarkWidget(
                        title: workout?.name ?? 'Unknown Workout',
                        subtitle:
                            '${workout?.duration ?? 0} min | ${workout?.difficulty ?? 'N/A'}',
                        image:
                            workout?.coverImage ??
                            'https://via.placeholder.com/150',
                        isBookmarked: true,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
