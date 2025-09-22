import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/session/controller/session_controller.dart';
import 'package:gokul_ramk/features/user/session/sessions_tab/widget/sessions_widget.dart';

class SessionsTab extends StatelessWidget {
  SessionsTab({super.key});

  final SessionController controller = Get.put(SessionController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.workoutList.length,
      itemBuilder: (context, index) {
        final workout = controller.workoutList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SessionsWidget(
            title: workout['title'],
            subtitle: workout['subtitle'],
            image: workout['image'],
            isBookmarked: workout['isBookmarked'] ?? false,
            isOnlineSession: workout['isOnlineSession'] ?? false,
            onTapBookMark: () {},
            onTapButton: () {},
          ),
        );
      },
    );
  }
}
