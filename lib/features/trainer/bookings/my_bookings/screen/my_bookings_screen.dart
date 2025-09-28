import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/widgets/booking_session_list_widget.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'My Bookings',
                    style: getTextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.sort_rounded,
                    color: AppColors.primaryFontColor,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Expanded(child: BookingSessionListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
