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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.bookmarkList.length,
                  itemBuilder: (context, index) {
                    final item = controller.bookmarkList[index];
                    return BookmarkWidget(
                      title: item['title'],
                      subtitle: item['subtitle'],
                      image: item['image'],
                      isBookmarked: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
