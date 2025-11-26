import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_screen/screen/create_meal_screen.dart';
import 'package:gokul_ramk/features/trainer/program/screen/create_program.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../widgets/client_card.dart';
import '../widgets/session_card.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Good morning, Gokul 👋",
                  style: getTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                IconButton(
                  icon: Image.asset(
                    IconPath.notificationIcon,
                    width: 24, // adjust size
                    height: 24,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "You have 3 sessions today and 2 new requests.",
              style: getTextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                statCard("Active Clients", "12 Active"),
                statCard("Upcoming Sessions", "3 Today"),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                statCard("Pending Requests", "2 New"),
                statCard("Earnings This Month", "\$1250"),
              ],
            ),

            SizedBox(height: 24),

            // Sessions
            Text(
              "Upcoming Sessions",
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            sessionCard(
              "Today, 10:00 AM",
              "Yoga Session with Sarah",
              Colors.blue[50]!,
            ),
            SizedBox(height: 10),
            sessionCard(
              "Today, 2:00 PM",
              "Strength Training with John",
              Colors.green[50]!,
            ),

            SizedBox(height: 24),

            // Clients
            Text(
              "Client Highlights",
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: clientCard("Alex Carter")),
                SizedBox(width: 12),
                Expanded(child: clientCard("Alex Carter")),
              ],
            ),

            SizedBox(height: 24),

            // Create Program
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create Program",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Design a structured training plan tailored for your clients.",

                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(CreateProgramScreen());
                    },
                    child: Text("Start Now"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12,),
                       // Create meal
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create Meal",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(MealCreateScreen());
                    },
                    child: Text("Start Now"),
                  ),
                ],
              ),
            ),            SizedBox(height: 12,),

                                  // Create meal
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create Meal Plan",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                    //  Get.to(CreateProgramScreen());
                    },
                    child: Text("Start Now"),
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
