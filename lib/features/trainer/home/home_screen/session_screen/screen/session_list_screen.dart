import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/session_list_controller.dart';
import '../service/session_service.dart';
import '../model/session_model.dart';
import 'edit_session_screen.dart';

class SessionListScreen extends StatelessWidget {
  final controller = Get.put(SessionListController());

  SessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.sessions.isEmpty) {
          return const Center(child: Text('No sessions found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.sessions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final SessionModel s = controller.sessions[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withValues(alpha: 0.1),
                //     blurRadius: 4,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child: ListTile(
                title: Text(
                  s.title,
                  style: getTextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(s.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Get.to(() => EditSessionScreen(sessionId: s.id));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Delete Session',
                          middleText: 'Confirm delete this session?',
                          textCancel: 'Cancel',
                          textConfirm: 'Delete',
                          confirmTextColor: Colors.white,
                          onConfirm: () async {
                            Get.back();
                            final res = await SessionService.deleteSessionById(
                              s.id,
                            );
                            if (res.isSuccess) {
                              Get.snackbar('Success', 'Session deleted');
                              controller.fetchSessions(
                                page: controller.page.value,
                              );
                            } else {
                              Get.snackbar(
                                'Error',
                                res.errorMessage ?? 'Delete failed',
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
