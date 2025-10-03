import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/community/events/controller/event_controller.dart';

import '../../../program/widgets/text_field.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key});

  final EventsController controller = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarTitle(title: 'Create Event'),
              const SizedBox(height: 16),
              Text(
                "Thumbnail",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 40, color: Colors.grey),
                      SizedBox(height: 6),
                      Text(
                        "Click here to upload thumbnail image",
                        style: getTextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // ✅ Program Info
              Text(
                "Event Info",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),
              Text(
                "Event Name",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Program Name
              buildTextField("Enter event name"),
              SizedBox(height: 20),
              Text(
                "Description",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Description
              buildTextField(
                "Write a description about this event",
                maxLines: 3,
              ),

              const SizedBox(height: 20),
              Text(
                'Event Type',
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedOption.value,
                    hint: Text('Add event type'),
                    underline: SizedBox.shrink(),
                    icon: Icon(Icons.arrow_drop_down, size: 18),
                    items: controller.options
                        .map(
                          (filter) => DropdownMenuItem(
                            value: filter,
                            child: Text(
                              filter,
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.fontColor,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedOption.value = value;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Event Location",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Program Name
              buildTextField(
                "Enter event location",
                suffixIcon: Icons.location_on_outlined,
              ),

              SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[50],
                      ),

                      onPressed: () {},
                      child: Text(
                        "Cancel",
                        style: getTextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // spacing
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF148CBB),
                      ),
                      onPressed: () {},
                      child: Text("Send Request"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
