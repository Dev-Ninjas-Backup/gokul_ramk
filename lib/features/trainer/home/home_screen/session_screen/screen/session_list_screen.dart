import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/session_list_controller.dart';
import '../service/session_service.dart';
import '../model/session_model.dart';
import 'edit_session_screen.dart';
import 'session_detail_screen.dart';

class SessionListScreen extends StatelessWidget {
  final controller = Get.put(SessionListController());

  SessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sessions'),
        backgroundColor: Colors.white,
        elevation: 0,
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
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final SessionModel s = controller.sessions[index];
            return _buildSessionCard(s);
          },
        );
      }),
    );
  }

  // Custom Card using Row and Column to prevent overflow
  Widget _buildSessionCard(SessionModel s) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Get.to(() => SessionDetailScreen(sessionId: s.id)),
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    s.title,
                    style: getTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s.description,
                    style: getTextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(
                icon: Icons.edit_outlined,
                color: Colors.blue,
                onTap: () => Get.to(() => EditSessionScreen(sessionId: s.id)),
              ),
              const SizedBox(height: 8),
              _buildIconButton(
                icon: Icons.delete_outline,
                color: Colors.red,
                onTap: () => _confirmDelete(s),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Reusable Icon Button
  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  // Delete Confirmation Dialog
  void _confirmDelete(SessionModel s) {
    Get.defaultDialog(
      title: 'Delete Session',
      middleText: 'Are you sure you want to delete "${s.title}"?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        Get.back(); // close dialog
        final res = await SessionService.deleteSessionById(s.id);
        if (res.isSuccess) {
          Get.snackbar('Success', 'Session deleted successfully');
          controller.fetchSessions(page: controller.page.value);
        } else {
          Get.snackbar(
            'Error',
            res.errorMessage ?? 'Delete failed',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
    );
  }
}
