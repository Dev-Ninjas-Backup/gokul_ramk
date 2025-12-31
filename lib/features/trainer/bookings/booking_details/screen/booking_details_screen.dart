import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/controller/booking_details_controller.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/widgets/bottom_reschedule_button.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/widgets/infotiile_widget.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/widgets/map.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String bookingId;

  const BookingDetailsScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingDetailsController());

    // Fetch booking details when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchBookingDetails(bookingId);
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          final booking = controller.booking.value;
          if (booking == null) {
            return Center(
              child: Text(
                'Booking not found',
                style: getTextStyle(fontSize: 16),
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarTitle(title: 'Booking Details'),
                SizedBox(height: 20),

                // User/Client Information
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  controller
                                          .userProfileImage
                                          .value
                                          ?.isNotEmpty ??
                                      false
                                  ? NetworkImage(
                                      controller.userProfileImage.value!,
                                    )
                                  : AssetImage(Imagepath.trainer)
                                        as ImageProvider,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        booking.user.fullname,
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        booking.user.email,
                        style: getTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      if (booking.user.phone != null &&
                          booking.user.phone!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            "Phone: ${booking.user.phone}",
                            style: getTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Divider(),

                Text(
                  "Session Info",
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                infoTile("Session Mode", booking.mode),
                infoTile("Booking Type", booking.bookingType ?? booking.mode),
                infoTile("Date & Time", booking.formattedDate),
                infoTile("Duration", "${booking.duration} mins"),
                infoTile(
                  "Time",
                  "${booking.scheduledTime} - ${booking.endTime}",
                ),
                infoTile("Price", "${booking.currency} ${booking.price}"),
                if (booking.advancePayment != "0" &&
                    booking.advancePayment.isNotEmpty)
                  infoTile(
                    "Advance Payment",
                    "${booking.currency} ${booking.advancePayment}",
                  ),
                if (booking.location != null && booking.location!.isNotEmpty)
                  infoTile("Location", booking.location!),
                if (booking.assignedProgram != null)
                  infoTile("Assigned Program", booking.assignedProgram!),
                infoTile("Status", booking.status),
                if (booking.meetingLink != null &&
                    booking.meetingLink!.isNotEmpty)
                  infoTile("Meeting Link", booking.meetingLink!),
                if (booking.notes != null && booking.notes!.isNotEmpty)
                  infoTile("Notes", booking.notes!),

                SizedBox(height: 20),
                Divider(),

                Text(
                  "Trainer Info",
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                infoTile("Trainer Name", booking.trainer.fullname),
                infoTile("Email", booking.trainer.email),
                if (booking.trainer.phone != null)
                  infoTile("Phone", booking.trainer.phone!),

                // SizedBox(height: 20),
                // Divider(),

                // LocationMap(latitude: 18, longitude: 18),
                // SizedBox(height: 24),

                // BottomRescheduleButton(),
                // SizedBox(height: 32),
                // GestureDetector(
                //   child: Container(
                //     height: 54,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: AppColors.primaryButtonColor,
                //     ),
                //     child: Center(
                //       child: Text(
                //         'Mark Complete',
                //         style: getTextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //           color: AppColors.secondaryButtonColor,
                //         ),
                //       ),
                //     ),
                //   ),
                //   onTap: () {
                //     controller.markComplete(bookingId);
                //   },
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
