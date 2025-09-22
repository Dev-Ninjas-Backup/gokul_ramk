import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/controller/booking_session_controller.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/model/booking_session_model.dart';

class BookingSessionListWidget extends StatelessWidget {
  final BookingSessionController controller = Get.put(
    BookingSessionController(),
  );

  BookingSessionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.sessions.length,
        itemBuilder: (context, index) {
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
                    session.name,
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
                    "Status: ${session.status.name.capitalizeFirst}",
                    style: getTextStyle(),
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: .18),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      session.sessionType,
                      style: getTextStyle(
                        color: AppColors.primaryColor.withValues(alpha: .9),
                        fontWeight: FontWeight.w500,
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
                      EasyLoading.showInfo('Chat Feature Coming soon');
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  GestureDetector(
                    onTap: session.status == SessionStatus.upcoming
                        ? onMarkComplete
                        : () {
                            EasyLoading.showInfo('Feature coming soon');
                          },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        session.status == SessionStatus.upcoming
                            ? "Mark Complete"
                            : "View Details",
                        style: getTextStyle(
                          color: Colors.white,
                          fontSize: 14,
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
