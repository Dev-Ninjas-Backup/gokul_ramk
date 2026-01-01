import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/model/meal_plan_model.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/screen/meal_plan_detail_screen.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/screen/create_meal_plan_screen.dart';

class MealPlanListScreen extends StatelessWidget {
  const MealPlanListScreen({super.key});

  Future<List<MealPlanModel>> _fetchMyPlans() async {
    final client = Get.find<NetworkClient>();
    final res = await client.getRequest(url: Urls.getMyMealPlan);
    if (res.isSuccess && res.responseData != null) {
      final data = res.responseData!['data'];
      if (data is List) {
        return data
            .map((e) => MealPlanModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Meal Plans'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<List<MealPlanModel>>(
        future: _fetchMyPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final plans = snapshot.data ?? [];
          if (plans.isEmpty) {
            return const Center(child: Text('No meal plans found'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: plans.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final p = plans[index];
              final img = p.imageUrl ?? '';
              String _normalize(String? raw) {
                if (raw == null) return '';
                final s = raw.toString();
                if (s.startsWith('http')) return s;
                final last = s.lastIndexOf('https://');
                if (last > 0) return s.substring(last);
                return s;
              }

              final imgFixed = _normalize(img);

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => MealPlanDetailScreen(planId: p.id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: imgFixed.isNotEmpty
                              ? Image.network(
                                  imgFixed,
                                  width: 92,
                                  height: 92,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Image.asset(
                                    Imagepath.trainer,
                                    width: 92,
                                    height: 92,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  Imagepath.trainer,
                                  width: 92,
                                  height: 92,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                p.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: [
                                  Chip(label: Text('${p.duration} mins')),
                                  Chip(label: Text(p.intensityLevel)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(() => CreateMealPlanScreen(plan: p));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
