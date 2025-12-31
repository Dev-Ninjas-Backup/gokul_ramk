import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/session_screen/screen/session_list_screen.dart';
import '../controller/create_session_controller.dart';
import '../model/package_model.dart';
import '../model/program_model.dart';
import '../model/category_model.dart';

class CreateSessionScreen extends StatelessWidget {
  final controller = Get.put(CreateSessionController());

  CreateSessionScreen({super.key});

  Widget input(String label, TextEditingController ctrl, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          keyboardType: label == 'Duration' || label == 'Price'
              ? TextInputType.number
              : TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget dropdown<T>({
    required String label,
    required RxnString selected,
    required List<T> items,
    required String Function(T) labelBuilder,
    required String Function(T) idBuilder,
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
          if (items.isEmpty) return const Text('No items found');
          return DropdownButtonFormField<String>(
            initialValue: selected.value,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: idBuilder(e),
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
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Session'),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              Get.to(() => SessionListScreen());
            },
            icon: const Icon(Icons.list),
            label: const Text("Sessions"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              dropdown<PackageModel>(
                label: 'Package (optional)',
                selected: controller.selectedPackageId,
                items: controller.packages,
                labelBuilder: (PackageModel p) => p.name,
                idBuilder: (PackageModel p) => p.id,
              ),

              dropdown<ProgramModel>(
                label: 'Program (optional)',
                selected: controller.selectedProgramId,
                items: controller.programs,
                labelBuilder: (ProgramModel p) => p.name,
                idBuilder: (ProgramModel p) => p.id,
              ),

              dropdown<CategoryModel>(
                label: 'Category (required)',
                selected: controller.selectedCategoryId,
                items: controller.categories,
                labelBuilder: (CategoryModel c) => c.name,
                idBuilder: (CategoryModel c) => c.id,
              ),

              input('Title', controller.titleCtrl),
              input('Duration', controller.durationCtrl),
              input('Price', controller.priceCtrl),
              input('Description', controller.descCtrl, maxLines: 3),

              Obx(
                () => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: controller.createSession,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Create Session'),
                      ),
              ),

              const SizedBox(height: 35),
            ],
          );
        }),
      ),
    );
  }
}
