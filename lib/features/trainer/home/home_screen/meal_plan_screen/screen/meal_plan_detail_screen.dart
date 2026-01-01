import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class MealPlanDetailScreen extends StatelessWidget {
  final String planId;
  const MealPlanDetailScreen({super.key, required this.planId});

  Future<Map<String, dynamic>> _fetchDetail() async {
    final client = Get.find<NetworkClient>();
    final url = '${Urls.getMealDetails}/$planId';
    final res = await client.getRequest(url: url);

    if (res.isSuccess && res.responseData != null) {
      final data = res.responseData!['data'];
      return Map<String, dynamic>.from(data);
    }
    throw Exception(res.errorMessage ?? 'Failed to load plan');
  }

  String _normalizeImage(String? raw) {
    if (raw == null) return '';
    if (raw.startsWith('http')) return raw;
    final last = raw.lastIndexOf('https://');
    return last > 0 ? raw.substring(last) : raw;
  }

  Widget _sectionCard(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _list(List items) {
    if (items.isEmpty) {
      return Text('No data available', style: getTextStyle(color: Colors.grey));
    }

    return Column(
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, size: 18, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(child: Text(e.toString(), style: getTextStyle())),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final plan = snapshot.data!;
          final img = _normalizeImage(
            plan['image']?.toString() ?? plan['imageUrl']?.toString(),
          );

          return CustomScrollView(
            slivers: [
              /// IMAGE HEADER + BACK BUTTON
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        img,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Image.asset(Imagepath.trainer, fit: BoxFit.cover),
                      ),

                      /// Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.65),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),

                      /// Custom Back Button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 12,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.55),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),

                      /// Title
                      Positioned(
                        left: 16,
                        bottom: 20,
                        right: 16,
                        child: Text(
                          plan['title'] ?? '',
                          style: getTextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// CONTENT
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    /// Info chips
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: [
                          Chip(
                            avatar: const Icon(Icons.schedule, size: 18),
                            label: Text(plan['duration'] ?? ''),
                          ),
                          Chip(
                            avatar: const Icon(Icons.fitness_center, size: 18),
                            label: Text(plan['intensityLevel'] ?? ''),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    _sectionCard(
                      'Description',
                      Text(plan['description'] ?? '', style: getTextStyle()),
                    ),

                    _sectionCard(
                      'Goal',
                      Text(plan['goal'] ?? '', style: getTextStyle()),
                    ),

                    _sectionCard(
                      'Weekly Breakdown',
                      _list(plan['weeklyBreakdown'] ?? []),
                    ),

                    _sectionCard(
                      'Daily Examples',
                      _list(plan['dailyExamples'] ?? []),
                    ),

                    const SizedBox(height: 30),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
