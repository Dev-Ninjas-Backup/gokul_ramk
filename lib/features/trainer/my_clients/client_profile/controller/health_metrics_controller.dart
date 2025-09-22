import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';

class MetricItem {
  final String icon;
  final String label;
  RxString value;
  final Color color;

  MetricItem({
    required this.icon,
    required this.label,
    required String value,
    required this.color,
  }) : value = value.obs;
}

class MetricsController extends GetxController {
  var metrics = <MetricItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    metrics.value = [
      MetricItem(
        icon: IconPath.weight,
        label: "Weight",
        value: "72 kg",
        color: Color(0XFF438656),
      ),
      MetricItem(
        icon: IconPath.sleep,
        label: "Sleep",
        value: "8h 20m",
        color: Color(0XFF438656),
      ),
    ];
  }

  void updateWeight(String newValue) {
    metrics[0].value.value = newValue;
  }
}
