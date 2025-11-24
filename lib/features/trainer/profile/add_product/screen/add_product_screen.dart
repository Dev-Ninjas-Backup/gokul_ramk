import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/widgets/ingredient_input_widget.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/widgets/key_benefit_input_widget.dart';
import '../controller/add_product_controller.dart';
import '../widgets/product_images_widget.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            CustomAppBarTitle(title: 'Add New Product'),
            const SizedBox(height: 20),

            /// Product Images Section
            ProductImagesSection(controller: controller),

            SizedBox(height: 30),

            /// Product Info
            Text(
              "Product Info",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Product Name",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(),
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Product Category",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoadingCategories.value) {
                return const SizedBox(
                  height: 50,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.categories.isEmpty) {
                return Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'No categories available',
                    style: getTextStyle(color: Colors.red),
                  ),
                );
              }

              return DropdownButtonFormField<String>(
                initialValue: controller.selectedCategory.value?.id,
                items: controller.categories
                    .map(
                      (c) => DropdownMenuItem(value: c.id, child: Text(c.name)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    final selectedCat = controller.categories.firstWhereOrNull(
                      (c) => c.id == value,
                    );
                    controller.selectedCategory.value = selectedCat;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Select a category',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              );
            }),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Price",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: controller.priceController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Ingredients",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            IngredientsInputWidget(),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Key Benefits",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            KeyBenefitsInputWidget(),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Stock Quantity",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: controller.stockController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Description",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: controller.descriptionController,
              decoration: InputDecoration(),
              maxLines: 3,
            ),

            SizedBox(height: 50),

            /// Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.postCreateProduct();
                },
                child: Text(
                  "Submit for Review",
                  style: getTextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            Text(
              "Your product will be reviewed by our team before it appears in the store. ",
              style: getTextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
