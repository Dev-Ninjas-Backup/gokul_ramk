import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_profile_controller.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserProfileController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final p = controller.profile;
          String _value(Object? v) => v == null ? '-' : v.toString();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _card(
                'Basic Information',
                Column(
                  children: [
                    _infoRow('Full name', _value(p['fullname'])),
                    const SizedBox(height: 12),
                    _infoRow('Nationality', _value(p['nationality'])),
                    const SizedBox(height: 12),
                    _infoRow('City', _value(p['city'])),
                    const SizedBox(height: 12),
                    _infoRow('Gender', _value(p['gender'])),
                    const SizedBox(height: 12),
                    _infoRow('Age', _value(p['age'])),
                  ],
                ),
              ),
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
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _card(String title, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
