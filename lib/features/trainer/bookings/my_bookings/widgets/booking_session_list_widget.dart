import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/screen/booking_details_screen.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/controller/booking_session_controller.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/model/booking_session_model.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class BookingSessionListWidget extends StatelessWidget {
  final BookingSessionController controller = Get.put(
    BookingSessionController(),
  );

  BookingSessionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingSessions.value && controller.sessions.isEmpty) {
        return Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        );
      }

      if (controller.sessions.isEmpty) {
        return Center(
          child: Text('No bookings yet', style: getTextStyle(fontSize: 16)),
        );
      }

      return ListView.builder(
        itemCount:
            controller.sessions.length +
            (controller.hasMoreSessions.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.sessions.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: GestureDetector(
                onTap: controller.loadMoreSessions,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Load More',
                    style: getTextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }

          final session = controller.sessions[index];
          return BookingSessionCard(
            session: session,
            onMarkComplete: () => controller.markComplete(index),
          );
        },
      );
    });
  }
}

class BookingSessionCard extends StatelessWidget {
  final BookingSessionModel session;
  final VoidCallback onMarkComplete;

  const BookingSessionCard({
    super.key,
    required this.session,
    required this.onMarkComplete,
  });

  String _getUserName() {
    return session.user.fullname;
  }

  String _getSessionType() {
    return session.mode.toUpperCase();
  }

  String _getFormattedStatus() {
    String status = session.status.replaceAll('_', ' ');
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.primaryColor,
      color: AppColors.background,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(Imagepath.trainer),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getUserName(),
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Date & Time: ${session.formattedDate}",
                    style: getTextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Status: ${_getFormattedStatus()}",
                    style: getTextStyle(),
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: .18),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getSessionType(),
                      style: getTextStyle(
                        color: AppColors.primaryColor.withValues(alpha: .9),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 120,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.userChatScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Message",
                        style: getTextStyle(
                          color: AppColors.primaryFontColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  GestureDetector(
                    onTap:
                        session.status.toUpperCase() == 'PENDING' ||
                            session.status.toUpperCase() == 'CONFIRMED'
                        ? onMarkComplete
                        : () {
                            Get.to(
                              () => BookingDetailsScreen(bookingId: session.id),
                            );
                          },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        session.status.toUpperCase() == 'PENDING' ||
                                session.status.toUpperCase() == 'CONFIRMED'
                            ? "Mark Complete"
                            : "View Details",
                        style: getTextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
