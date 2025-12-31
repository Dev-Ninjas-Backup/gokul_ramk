import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/screen/create_meal_plan_screen.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_screen/screen/create_meal_screen.dart';
import 'package:gokul_ramk/features/trainer/program/screen/create_program.dart';
import 'package:gokul_ramk/features/trainer/workout/screen/create_workout_screen.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/screen/create_exercise_screen.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/screen/exercise_list_screen.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/session_screen/screen/create_session_screen.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/session_screen/screen/session_list_screen.dart';
import 'package:gokul_ramk/features/trainer/package/screen/create_package_screen.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/icon_path.dart';
// import '../widgets/client_card.dart';
import '../widgets/session_card.dart';
import '../widgets/stat_card.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
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
            Obx(
              () => Text(
                "You have ${controller.upcomingSessionsCount.value} sessions today and ${controller.pendingCount.value} new requests.",
                style: getTextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => statCard(
                    "Active Clients",
                    "${controller.confirmedCount.value} Active",
                  ),
                ),
                Obx(
                  () => statCard(
                    "Upcoming Sessions",
                    "${controller.upcomingSessionsCount.value} Today/Tomorrow",
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pending requests now fetched from API
                Obx(
                  () => statCard(
                    "Pending Requests",
                    "${controller.pendingCount.value} New",
                  ),
                ),
                Obx(
                  () => statCard(
                    "Available Balance",
                    "\$${controller.availableBalance.value.toStringAsFixed(2)}",
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Sessions
            Text(
              "Upcoming Sessions",
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Obx(() {
              final recent = controller.recentSessions();
              if (recent.isEmpty) {
                // fallback to previous hardcoded cards
                return sessionCard(
                  "No upcoming sessions",
                  "You have no upcoming sessions.",
                  Colors.blue[50]!,
                );
              }

              final colors = [
                Colors.blue[50]!,
                Colors.green[50]!,
                Colors.orange[50]!,
                Colors.purple[50]!,
              ];
              return Column(
                children: List.generate(recent.length.clamp(0, 2), (i) {
                  final s = recent[i];
                  final time = controller.formatSessionDate(s);
                  final title =
                      s['title']?.toString() ??
                      s['name']?.toString() ??
                      'Session';
                  final bg = colors[i % colors.length];
                  return Column(
                    children: [
                      sessionCard(time, title, bg),
                      SizedBox(height: 10),
                    ],
                  );
                }),
              );
            }),

            SizedBox(height: 24),

            // Clients
            // Text(
            //   "Client Highlights",
            //   style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 12),
            // Row(
            //   children: [
            //     Expanded(child: clientCard("Alex Carter")),
            //     SizedBox(width: 12),
            //     Expanded(child: clientCard("Alex Carter")),
            //   ],
            // ),

            // SizedBox(height: 24),

            // Workouts package
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Workouts package",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Bundle multiple workout package for your clients.",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => CreateWorkoutScreen());
                    },
                    child: Text("Start Now"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
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
                      Get.to(() => CreateProgramScreen());
                    },
                    child: Text("Start Now"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Create Package
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create Package",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Bundle multiple sessions into a package for your clients.",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => CreatePackageScreen());
                    },
                    child: Text("Start Now"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
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
                      Get.to(() => MealCreateScreen());
                    },
                    child: Text("Start Now"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create New Exercise",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(CreateExerciseScreen());
                    },
                    child: Text("Start Now"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "View Exercises",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Browse and edit all exercises.",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ExerciseListScreen());
                    },
                    child: Text("Open"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),

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
                      Get.to(() => CreateMealPlanScreen());
                    },
                    child: Text("Start Now"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create Session",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Create a new training session",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => CreateSessionScreen());
                    },
                    child: Text("Open"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "View Sessions",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Browse and manage sessions.",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => SessionListScreen());
                    },
                    child: Text("Open"),
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
