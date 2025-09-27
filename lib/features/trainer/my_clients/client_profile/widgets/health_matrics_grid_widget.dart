import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/controller/health_metrics_controller.dart';

class HealthMetricsGrid extends StatelessWidget {
  final MetricsController controller = Get.put(MetricsController());

  HealthMetricsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 28,
        childAspectRatio: 1.2,
        padding: EdgeInsets.all(6),
        children: controller.metrics.map((item) {
          return MetricCard(item: item);
        }).toList(),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final MetricItem item;

  const MetricCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  item.icon,
                  height: 24,
                  width: 24,
                  color: item.color,
                ),
              ),
              Spacer(),
            ],
          ),

          SizedBox(height: 2),

          Text(
            item.label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),

          Obx(
            () => Text(
              item.value.value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
