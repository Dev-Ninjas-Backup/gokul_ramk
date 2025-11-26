import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_screen/controller/meal_controller.dart';

class MealCreateScreen extends StatelessWidget {
  MealCreateScreen({super.key});

  final controller = Get.put(MealController());

  final TextEditingController vitaminCtrl = TextEditingController();
  final TextEditingController ingredientCtrl = TextEditingController();
  final TextEditingController prepCtrl = TextEditingController();

  Widget buildTextField(String label, Function(String) onChange) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: onChange,
    );
  }

  Widget buildNumberField(String label, Function(int) onChange) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (v) => onChange(int.tryParse(v) ?? 0),
    );
  }

  Widget buildListInput({
    required String label,
    required RxList<String> list,
    required TextEditingController ctrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: TextField(
                controller: ctrl,
                decoration: const InputDecoration(
                  hintText: "Enter item",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.blue),
              onPressed: () {
                if (ctrl.text.isNotEmpty) {
                  list.add(ctrl.text);
                  ctrl.clear();
                }
              },
            ),
          ],
        ),

        const SizedBox(height: 6),

        Obx(
          () => Column(
            children: list
                .map(
                  (v) => Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(v),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => list.remove(v),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildImagePicker() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Meal Image",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Preview
          controller.pickedImage.value != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    controller.pickedImage.value!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: const Center(child: Text("No Image Selected")),
                ),

          const SizedBox(height: 10),

          ElevatedButton.icon(
            onPressed: () => controller.pickImage(),
            icon: const Icon(Icons.photo),
            label: const Text("Pick Image"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Meal"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),

      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildTextField("Title", (v) => controller.title.value = v),
                    const SizedBox(height: 12),

                    buildTextField(
                      "Description",
                      (v) => controller.description.value = v,
                    ),
                    const SizedBox(height: 12),

                    /// ⭐ Image Picker Section
                    buildImagePicker(),
                    const SizedBox(height: 20),

                    buildNumberField(
                      "Calories",
                      (v) => controller.calories.value = v,
                    ),
                    const SizedBox(height: 12),

                    buildNumberField(
                      "Protein",
                      (v) => controller.protein.value = v,
                    ),
                    const SizedBox(height: 12),

                    buildNumberField(
                      "Carbs",
                      (v) => controller.carbs.value = v,
                    ),
                    const SizedBox(height: 12),

                    buildNumberField("Fat", (v) => controller.fat.value = v),

                    const SizedBox(height: 20),

                    buildListInput(
                      label: "Vitamins",
                      list: controller.vitamins,
                      ctrl: vitaminCtrl,
                    ),
                    const SizedBox(height: 16),

                    buildListInput(
                      label: "Ingredients",
                      list: controller.ingredients,
                      ctrl: ingredientCtrl,
                    ),
                    const SizedBox(height: 16),

                    buildListInput(
                      label: "Preparation Steps",
                      list: controller.preparation,
                      ctrl: prepCtrl,
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: () => controller.createMeal(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        "Create Meal",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 35),
                  ],
                ),
              ),
      ),
    );
  }
}
