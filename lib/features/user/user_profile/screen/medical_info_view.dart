import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_profile_controller.dart';

class MedicalInfoScreen extends StatelessWidget {
  const MedicalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserProfileController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Medical Info')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final p = controller.profile;
          bool val(Object? v) => v == true;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _card(
                'Health Conditions',
                Column(
                  children: [
                    _yesNoRow('Heart Condition', val(p['heartCondition'])),
                    const SizedBox(height: 8),
                    _yesNoRow('Chest Pain', val(p['chestPain'])),
                    const SizedBox(height: 8),
                    _yesNoRow('Medication', val(p['medication'])),
                    const SizedBox(height: 12),
                    _card(
                      'Incidents',
                      Column(
                        children: [
                          _yesNoRow('Has Injuries', val(p['hasInjuries'])),
                          const SizedBox(height: 8),
                          _yesNoRow('Has Dizziness', val(p['hasDizziness'])),
                          const SizedBox(height: 8),
                          _yesNoRow('Has Surgery', val(p['hasSurgery'])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _yesNoRow(String label, bool yes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        Row(
          children: [
            Icon(
              yes ? Icons.check_circle : Icons.cancel,
              color: yes ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(
              yes ? 'Yes' : 'No',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _card(String title, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
