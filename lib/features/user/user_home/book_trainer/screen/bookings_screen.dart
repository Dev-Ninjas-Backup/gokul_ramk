import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/controller/book_trainer_controller.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/widgets/duration_widget.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/widgets/start_time_list.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/widgets/stat_container.dart';
import 'package:gokul_ramk/features/user/user_home/book_trainer/service/booking_service.dart';
import 'package:gokul_ramk/routes/app_routes.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BookTrainerScreen extends StatelessWidget {
  BookTrainerScreen({super.key});

  final BookTrainerController controller = Get.put(BookTrainerController());
  final dynamic arguments = Get.arguments;

  // local controllers for extra inputs
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController assignedProgramController =
      TextEditingController();

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
                CustomAppBarTitle(
                  title: formMytrainer ? 'Reschedule' : 'Book Trainer',
                  onTapBack: () {
                    Get.toNamed(AppRoute.bookTrainerScreen);
                  },
                ),
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
                SizedBox(height: 16),

                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "Select Days Per Week",
                //     style: getTextStyle(
                //       color: Color(0xFF2D2D2D),
                //       fontSize: 18,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10),
                // Obx(() {
                //   return Container(
                //     width: double.maxFinite,
                //     padding: EdgeInsets.symmetric(horizontal: 10),
                //     decoration: BoxDecoration(
                //       color: Colors.grey.withValues(alpha: 0.1),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: DropdownButtonHideUnderline(
                //             child: DropdownButton<int>(
                //               isExpanded: true,
                //               value: controller.selectedTrainingDays.value,
                //               icon: const Icon(
                //                 Icons.arrow_drop_down_rounded,
                //               ), // custom icon here
                //               items: controller.trainingDaysOptions.map((
                //                 int day,
                //               ) {
                //                 return DropdownMenuItem<int>(
                //                   value: day,
                //                   child: Text("$day days in a week"),
                //                 );
                //               }).toList(),
                //               onChanged: (value) {
                //                 controller.trainingDayForMonthSelected.value =
                //                     true;
                //                 if (value != null) {
                //                   controller.selectedTrainingDays.value = value;
                //                 }
                //               },
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   );
                // }),

                //SizedBox(height: 10),
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
                const SizedBox(height: 16),

                // Mode selection for booking
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mode",
                    style: getTextStyle(
                      color: Color(0xFF2D2D2D),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.mode.value,
                        items: ['ONLINE', 'ONSITE', 'OFFSIDE']
                            .map(
                              (m) => DropdownMenuItem(value: m, child: Text(m)),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) controller.mode.value = v;
                        },
                      ),
                    ),
                  ),
                ),

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

                // Location
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Notes
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                    labelText: 'Notes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),

                // Assigned Program (optional)
                TextField(
                  controller: assignedProgramController,
                  decoration: InputDecoration(
                    labelText: 'Assigned Program (optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                SizedBox(height: 24),
                StatContainer(),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    // Determine trainerId from arguments
                    String? trainerId;
                    if (arguments is String && arguments != 'myTrainer') {
                      trainerId = arguments;
                    } else if (arguments is Map &&
                        arguments['trainerId'] != null) {
                      trainerId = arguments['trainerId'].toString();
                    }

                    if (trainerId == null || trainerId.isEmpty) {
                      EasyLoading.showError('Trainer not specified');
                      return;
                    }

                    // convert selectedStartTime like "09:00 AM" -> "09:00" (24h naive conversion)
                    String convertTo24(String t) {
                      if (t.isEmpty) return '';
                      final parts = t.split(' ');
                      if (parts.length == 1) return parts[0];
                      final time = parts[0];
                      final ampm = parts[1].toUpperCase();
                      final hm = time.split(':');
                      int hour = int.tryParse(hm[0]) ?? 0;
                      final min = hm.length > 1 ? hm[1] : '00';
                      if (ampm == 'PM' && hour < 12) hour += 12;
                      if (ampm == 'AM' && hour == 12) hour = 0;
                      final hh = hour.toString().padLeft(2, '0');
                      return '$hh:$min';
                    }

                    final body = {
                      'trainerId': trainerId,
                      'mode': controller.mode.value,
                      'duration': controller.duration.value,
                      'scheduledDate': controller.scheduledDate,
                      'scheduledTime': convertTo24(
                        controller.selectedStartTime,
                      ),
                      'location': locationController.text,
                      'notes': notesController.text,
                      'assignedProgram': assignedProgramController.text,
                    };

                    final res = await BookingService.createBooking(body);

                    // Try to extract API message and data (which may be a URL)
                    String apiMessage = 'Booking created';
                    String? dataUrl;
                    try {
                      final resp = res.responseData;
                      if (resp is Map<String, dynamic>) {
                        if (resp.containsKey('message')) {
                          apiMessage =
                              resp['message']?.toString() ?? apiMessage;
                        }
                        if (resp.containsKey('data') && resp['data'] is String) {
                          dataUrl = resp['data'];
                        }
                      }
                    } catch (_) {}

                    if (res.isSuccess) {
                      EasyLoading.showSuccess(apiMessage);
                      if (dataUrl != null && dataUrl.isNotEmpty) {
                        try {
                          final launched = await launchUrlString(dataUrl);
                          if (!launched) {
                            EasyLoading.showError('Could not open provided link');
                          }
                        } catch (e) {
                          EasyLoading.showError('Could not open provided link');
                        }
                      }
                      Get.back();
                    } else {
                      EasyLoading.showError('Could not open provided link');
                    }
                  },
                  child: Text(formMytrainer ? 'Reschedule' : 'Confirm Booking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
