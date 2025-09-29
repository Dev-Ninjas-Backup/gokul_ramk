import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/controller/book_trainer_controller.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/widgets/duration_widget.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/widgets/start_time_list.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/widgets/stat_container.dart';

class BookTrainerScreen extends StatelessWidget {
  BookTrainerScreen({super.key});

  final BookTrainerController controller = Get.put(BookTrainerController());
  final String arguments = Get.arguments ?? '';

  @override
  Widget build(BuildContext context) {
    bool formMytrainer = arguments == 'myTrainer';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                CustomAppBarTitle(title:formMytrainer ?'Reschedule' : 'Book Trainer'),
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
                    "Select Days For a Month",
                    style: getTextStyle(
                      color: Color(0xFF2D2D2D),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              isExpanded: true,
                              value: controller.selectedTrainingDays.value,
                              icon: const Icon(
                                Icons.arrow_drop_down_rounded,
                              ), // custom icon here
                              items: controller.trainingDaysOptions.map((
                                int day,
                              ) {
                                return DropdownMenuItem<int>(
                                  value: day,
                                  child: Text("$day days in a week"),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.trainingDayForMonthSelected.value = true;
                                if (value != null) {
                                  controller.selectedTrainingDays.value = value;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                SizedBox(height: 10),

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
                  child: Text(formMytrainer ? 'Reschedule' :'Confirm Booking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
