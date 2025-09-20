import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/get_random_color.dart';
import 'package:gokul_ramk/features/user/user_home/controller/user_home_controller.dart';
import 'package:gokul_ramk/features/user/user_home/widget/catrgory_button.dart';
import 'package:gokul_ramk/features/user/user_home/widget/featured_workout_card.dart';
import 'package:gokul_ramk/features/user/user_home/widget/highlight_card.dart';
import 'package:gokul_ramk/features/user/user_home/widget/home_carousel_slider.dart';
import 'package:gokul_ramk/features/user/user_home/widget/neutrition_card.dart';
import 'package:gokul_ramk/features/user/user_home/widget/progress_card.dart';
import 'package:gokul_ramk/features/user/user_home/widget/stats_card.dart';
import 'package:gokul_ramk/features/user/user_home/widget/workout_card.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});
  final UserHomeController controller = Get.put(UserHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good morning, Adib 👋",
                          style: getTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Ready to crush your goals today?",
                          style: getTextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.userNotificationScreen);
                      debugPrint("Notification tapped");
                    },

                    child: Icon(Icons.notifications_none),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Book tapped");
                    },
                    child: Icon(Icons.bookmark_border),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Featured Workouts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Workouts",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("See all", style: getTextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.workoutList.length,
                  itemBuilder: (context, index) {
                    final workout = controller.workoutList[index];
                    return WorkoutCard(
                      title: workout['title'],
                      subtitle: workout['subtitle'],
                      image: workout['image'],
                      isBookmarked: workout['isBookmarked'] ?? false,
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Today's Highlights
              Text(
                "Today's Highlights",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                itemCount: controller.highlightList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = controller.highlightList[index];
                  return HighlightCard(
                    title: item['title'],
                    subtitle: item['subtitle'],
                    buttonText: item['buttonText'],
                    buttonColor: getRandomDeepColor(),
                    image: item['image'],
                    onTap: () {},
                  );
                },
              ),

              // Progress & Activity
              Text(
                "Today's Progress & Activity",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Obx(() => ProgressCard(progress: controller.progress.value)),

              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.stats.entries
                      .map((e) => StatsCard(title: e.key, value: e.value))
                      .toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explore Workouts",
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("See all", style: getTextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 12),
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.categories
                        .map(
                          (cat) => CategoryButton(
                            label: cat,
                            isSelected:
                                controller.selectedCategory.value == cat,
                            onTap: () =>
                                controller.selectedCategory.value = cat,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // explore Workouts
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.workoutList.length,
                itemBuilder: (context, index) {
                  final workout = controller.workoutList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: WorkoutCard(
                      large: true,
                      title: workout['title'],
                      subtitle: workout['subtitle'],
                      image: workout['image'],
                      isBookmarked: workout['isBookmarked'] ?? false,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                "Health & Nutrition",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              NeutritionCard(),

              const SizedBox(height: 16),

              HomeCarouselSlider(controller: controller),

              Text(
                "Featured Trainers",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Trainer cards row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 260,
                        child: FeaturedWorkoutCard(
                          imageUrl:
                              "https://img.mensxp.com/media/content/2018/Dec/signs-your-nutrition-guru-or-gym-trainer-doesn-rsquo-t-know-anything-about-fitness1400-1544774850.jpg",
                          name: "Trainer ${index + 1}",
                          tagline: "Helping you push past limits.",
                          specialty: "Strength & Conditioning",
                          onTapViewProfile: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Featured Workouts",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 5,
                    children: controller.filters.map((filter) {
                      final isSelected =
                          controller.selectedFeaturedWorkout.value == filter;
                      return CategoryButton(
                        label: filter,
                        isSelected: isSelected,
                        onTap: () =>
                            controller.selectedFeaturedWorkout.value = filter,
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // featured Workouts
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.workoutList.length,
                itemBuilder: (context, index) {
                  final workout = controller.workoutList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: WorkoutCard(
                      large: true,
                      title: workout['title'],
                      subtitle: workout['subtitle'],
                      image: workout['image'],
                      isBookmarked: workout['isBookmarked'] ?? false,
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    colors: [Color(0xFF7BCA91), Color(0xFF3CA0C7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Join the Community & Challenges',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '20,000+ members pushing their limits together.',
                      style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        '+ Join Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
