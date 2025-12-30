import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/edit_session_controller.dart';

class EditSessionScreen extends StatelessWidget {
  final String sessionId;
  final controller = Get.put(EditSessionController());

  EditSessionScreen({super.key, required this.sessionId});

  Widget input(String label, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget dropdownList({
    required String label,
    required RxnString selected,
    required List items,
    required String Function(dynamic) labelBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          if (items.isEmpty) return const Text('No items');
          return DropdownButtonFormField<String>(
            value: selected.value,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: (e.id ?? e['id']).toString(),
                    child: Text(labelBuilder(e)),
                  ),
                )
                .toList(),
            onChanged: (v) => selected.value = v,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.init(sessionId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Session'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value)
            return const Center(child: CircularProgressIndicator());
          return Column(
            children: [
              dropdownList(
                label: 'Package (optional)',
                selected: controller.selectedPackageId,
                items: controller.packages,
                labelBuilder: (e) => e.name ?? '',
              ),
              dropdownList(
                label: 'Program (optional)',
                selected: controller.selectedProgramId,
                items: controller.programs,
                labelBuilder: (e) => e.name ?? '',
              ),
              dropdownList(
                label: 'Category (required)',
                selected: controller.selectedCategoryId,
                items: controller.categories,
                labelBuilder: (e) => e.name ?? '',
              ),
              input('Title', controller.titleCtrl),
              input('Description', controller.descCtrl),
              ElevatedButton(
                onPressed: controller.updateSession,
                child: const Text('Update Session'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
