import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/widgets/bottom_reschedule_button.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/widgets/infotiile_widget.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/widgets/map.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarTitle(title: 'Booking Details'),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(Imagepath.trainer),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Alex Carter",
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Goal: Weight Loss",
                        style: getTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "alex@carter.com | +1 234 567 890",
                        style: getTextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),
              Divider(),

              Text(
                "Session Info",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              infoTile("Session Type", "Personal Training – Strength"),
              infoTile("Date & Time", "Sept 3, 2025, 6:00 PM – 7:00 PM"),
              infoTile("Duration", "60 mins"),
              infoTile("Mode", "In-person"),
              infoTile("Assigned Program", "8-Week Strength Builder"),

              SizedBox(height: 20),
              Divider(),

              LocationMap(latitude: 18, longitude: 18),

              SizedBox(height: 24),

              BottomRescheduleButton(),
              SizedBox(height: 32),
              GestureDetector(
                child: Container(
                  height: 54,

                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryButtonColor,
                  ),
                  child: Center(
                    child: Text(
                      'Mark Complete',
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryButtonColor,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
