import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/bookings/reschedule/calender/controller/reschedule_contrller.dart';
import 'package:gokul_ramk/features/trainer/bookings/reschedule/widget/duration_widget.dart';
import 'package:gokul_ramk/features/trainer/bookings/reschedule/widget/start_time_list.dart';
import 'package:gokul_ramk/features/trainer/bookings/reschedule/widget/stat_container.dart';


class RescheduleScreen extends StatelessWidget {
  RescheduleScreen({super.key});

  final RescheduleContrller controller = Get.put(RescheduleContrller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                CustomAppBarTitle(title: 'Reschedule'),
                SizedBox(
                  height: 400,
                  child: CalendarCarousel(
                    iconColor: Colors.black,
                    todayButtonColor: Colors.transparent,
                    todayBorderColor: Colors.transparent,
                    selectedDayBorderColor: Colors.transparent,
                    thisMonthDayBorderColor: Colors.transparent,
                    customDayBuilder:
                        (
                          bool isSelectable,
                          int index,
                          bool isSelectedDay,
                          bool isToday,
                          bool isPrevMonthDay,
                          TextStyle textStyle,
                          bool isNextMonthDay,
                          bool isThisMonthDay,
                          DateTime day,
                        ) {
                          bool isSelected = controller.selectedDates.any(
                            (d) =>
                                d.year == day.year &&
                                d.month == day.month &&
                                d.day == day.day,
                          );

                          if (isSelected) {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          if (isToday) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }

                          return null; // Use default rendering
                        },
                    onDayPressed: (date, events) {
                      controller.onDateSelected(date);
                    },
                    daysHaveCircularBorder: false,
                    weekdayTextStyle: TextStyle(color: Colors.black),
                    weekendTextStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 36),

                // Obx(
                //   () => Padding(
                //     padding: EdgeInsets.all(16.0),
                //     child: Text(
                //       controller.selectedDatesText,
                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Start Time",
                    style: getTextStyle(
                      color: Color(0xFF2D2D2D),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                StartTimeList(),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Duration",
                    style: getTextStyle(
                      color: Color(0xFF2D2D2D),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DurationWidget(),
                SizedBox(height: 24),
                StatContainer(),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Reschedule'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
