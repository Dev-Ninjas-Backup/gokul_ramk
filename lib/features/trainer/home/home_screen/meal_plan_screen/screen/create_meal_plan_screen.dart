import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/controller/meal_plan_controller.dart';

class CreateMealPlanScreen extends StatelessWidget {
  final controller = Get.put(CreateMealPlanController());

  CreateMealPlanScreen({super.key});

  Widget input(String label, TextEditingController ctrl, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  /// ------------------------ FIXED ADD LIST ------------------------
  Widget singleAddList({
    required String title,
    required TextEditingController inputCtrl,
    required RxList<String> items,
  }) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,),
          const SizedBox(height: 6),

          // TextField + Add Button in Column
          Column(
            children: [
              TextField(
                controller: inputCtrl,
                decoration: InputDecoration(
                  hintText: "Enter text",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  if (inputCtrl.text.trim().isNotEmpty) {
                    items.add(inputCtrl.text.trim());
                    inputCtrl.clear();
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Show list items
          ...items.map(
            (e) => Card(
              child: ListTile(
                title: Text(e),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => items.remove(e),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  /// ------------------------ IMAGE PICKER ------------------------
  Widget imagePicker() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Meal Image",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          ElevatedButton.icon(
            onPressed: controller.pickImage,
            icon: const Icon(Icons.image),
            label: const Text("Pick Image"),
          ),
          const SizedBox(height: 10),

          controller.pickedImagePath.isEmpty
              ? const Center(child: Text("No image selected"))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(controller.pickedImagePath.value),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// ------------------------ MEAL DROPDOWN FIXED ------------------------
  Widget mealsDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        /// Only the dropdown needs to observe data
        Obx(() {
          if (controller.meals.isEmpty) {
            return const Text("No meals found");
          }

          return DropdownButtonFormField<String>(
            // ignore: deprecated_member_use
            value: controller.selectedMealId.value,
            items: controller.meals
                .map((m) => DropdownMenuItem(value: m.id, child: Text(m.title)))
                .toList(),
            onChanged: (v) => controller.selectedMealId.value = v,
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

  /// ------------------------ UI ------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Meal Plan'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            input("Title", controller.titleCtrl),
            input("Description", controller.descCtrl, maxLines: 3),
            input("Goal", controller.goalCtrl),
            input("Duration", controller.durationCtrl),
            input("Intensity Level", controller.intensityCtrl),
            input("Protein Example", controller.proteinCtrl),

            singleAddList(
              title: "Weekly Breakdown",
              inputCtrl: controller.weeklyInput,
              items: controller.weeklyItems,
            ),

            singleAddList(
              title: "Daily Examples",
              inputCtrl: controller.dailyInput,
              items: controller.dailyItems,
            ),

            mealsDropdown(),
            imagePicker(),

            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.createPlan,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Create Plan'),
                    ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
