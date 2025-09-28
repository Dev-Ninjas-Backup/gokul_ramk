import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/controller/nutrition_plan_controller.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/widget/daily_preview_item.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/widget/info_widget.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/widget/weekly_item_widget.dart';

class PlanDetailScreen extends StatelessWidget {
  PlanDetailScreen({super.key});

  final NutritionPlanController controller = Get.put(NutritionPlanController());

  final String title = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final plan = controller.plan.value;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarTitle(title: title),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://www.alaskaseafood.org/wp-content/uploads/Char-Grilled-Salmon-Satay-Peanut-Tamarind-Rice-Bowl-5-Web-JPG-940x550.jpg",
                  ),
                ),
                const SizedBox(height: 16),

                /// Title
                Text(
                  plan.title,
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                /// Description
                Text(
                  plan.description,
                  style: getTextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 16),

                /// Chips
                Row(
                  children: [
                    Expanded(child: InfoWidget(text: "Duration: ${plan.duration}")),
                    const SizedBox(width: 8),
                    Expanded(child: InfoWidget(text: "Difficulty: ${plan.difficulty}")),
                  ],
                ),
                const SizedBox(height: 20),

                /// Weekly Breakdown
                Text(
                  "Weekly Breakdown-",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...plan.weeklyBreakdown.map((e) => WeeklyItemWidget(text: e)),
                const SizedBox(height: 20),

                /// Daily Preview
                Text(
                  "Daily Preview Example-",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...plan.dailyMeals.map((e) => DailyPreviewItem(text: e)),
                const SizedBox(height: 24),

                /// Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Start Plan",
                      style: getTextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        }),
      ),
    );
  }
}
