import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../controller/create_package_controller.dart';
import 'all_packages_screen.dart';

class CreatePackageScreen extends StatelessWidget {
  CreatePackageScreen({super.key}) {
    // Register NetworkClient if not already registered
    if (!Get.isRegistered<NetworkClient>()) {
      Get.put(
        NetworkClient(
          onUnAuthorize: () {
            Get.snackbar("Session Expired", "Logging you out...");
            Get.offAllNamed('/login');
          },
        ),
      );
    }

    // Register CreatePackageController
    if (!Get.isRegistered<CreatePackageController>()) {
      Get.put(CreatePackageController());
    }
  }

  late final CreatePackageController controller =
      Get.find<CreatePackageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Create Package",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => AllPackagesScreen());
            },
            child: Text(
              "View All",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Package Name
              Text(
                "Package Name",
                style: getTextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintText: "Enter package name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                "Description",
                style: getTextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter package description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Expiry Date
              Text(
                "Expiry Date",
                style: getTextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.expiresInDateController,
                decoration: InputDecoration(
                  hintText: "YYYY-MM-DD (e.g., 2025-12-31)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 30)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    controller.expiresInDateController.text =
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00.000Z";
                  }
                },
              ),
              const SizedBox(height: 16),

              // Discount
              Text(
                "Discount (%)",
                style: getTextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.discountController,
                decoration: InputDecoration(
                  hintText: "Enter discount percentage",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Active Status
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isActive.value,
                      onChanged: (value) {
                        controller.isActive.value = value ?? false;
                      },
                    ),
                  ),
                  Text(
                    "Is Active",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Public Status
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isPublic.value,
                      onChanged: (value) {
                        controller.isPublic.value = value ?? false;
                      },
                    ),
                  ),
                  Text(
                    "Is Public",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sessions Selection
              Text(
                "Select Sessions",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (controller.sessionList.isEmpty)
                Center(
                  child: Text(
                    "No sessions available",
                    style: getTextStyle(color: Colors.grey),
                  ),
                )
              else
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.sessionList.length,
                    itemBuilder: (context, index) {
                      final session = controller.sessionList[index];

                      // Format dates
                      String formatDate(dynamic date) {
                        if (date == null) return "N/A";
                        try {
                          if (date is String) {
                            return DateTime.parse(
                              date,
                            ).toString().split(' ')[0];
                          }
                          return "N/A";
                        } catch (e) {
                          return "N/A";
                        }
                      }

                      return Obx(() {
                        final isSelected = controller.selectedSessionIds
                            .contains(session.id);
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            session.title,
                                            style: getTextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Duration: ${session.duration} mins • Price: \$${session.price}",
                                            style: getTextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Checkbox(
                                      value: isSelected,
                                      onChanged: (value) {
                                        controller.toggleSessionSelection(
                                          session.id,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Start: ${formatDate(session.startDate)}",
                                        style: getTextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "End: ${formatDate(session.endDate)}",
                                        style: getTextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              const SizedBox(height: 24),

              // Create Button
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isCreating.value
                        ? null
                        : () {
                            controller.createPackage();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isCreating.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            "Create Package",
                            style: getTextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }
}
