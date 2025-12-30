import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_profile_controller.dart';

class FitnessInfoScreen extends StatelessWidget {
  const FitnessInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserProfileController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Fitness Info')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final p = controller.profile;
          final goals = (p['goals'] is List)
              ? List<String>.from(p['goals'])
              : <String>[];
          final specs = (p['specializations'] is List)
              ? List<String>.from(p['specializations'])
              : <String>[];
          final height = p['height']?.toString() ?? '-';
          final weight = p['weight']?.toString() ?? '-';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (goals.isNotEmpty) ...[
                const Text(
                  'Goals',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: goals.map((g) => Chip(label: Text(g))).toList(),
                ),
                const SizedBox(height: 12),
              ],

              if (specs.isNotEmpty) ...[
                const Text(
                  'Specializations',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: specs.map((s) => Chip(label: Text(s))).toList(),
                ),
                const SizedBox(height: 12),
              ],

              _infoRow('Height', height),
              const SizedBox(height: 8),
              _infoRow('Weight', weight),
            ],
          );
        }),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(value, style: const TextStyle(color: Colors.black87)),
      ],
    );
  }
}
