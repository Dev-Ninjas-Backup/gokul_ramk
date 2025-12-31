// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../controller/package_details_controller.dart';

class PackageDetailsScreen extends StatelessWidget {
  final String packageId;

  PackageDetailsScreen({super.key, required this.packageId}) {
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

    // Register PackageDetailsController
    if (!Get.isRegistered<PackageDetailsController>()) {
      Get.put(PackageDetailsController());
    }

    // Fetch package details immediately
    Future.delayed(Duration.zero, () {
      Get.find<PackageDetailsController>().fetchPackageDetails(packageId);
    });
  }

  late final PackageDetailsController controller =
      Get.find<PackageDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Package Details",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed('/trainer/allPackagesScreen');
            },
            child: Text(
              "See All",
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

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchPackageDetails(packageId),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final package = controller.packageDetails.value;
        if (package == null) {
          return Center(
            child: Text(
              "No package found",
              style: getTextStyle(color: Colors.grey),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Package Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.name,
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      package.description,
                      style: getTextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoBox(
                          label: "Price",
                          value: "\$${package.price.toStringAsFixed(2)}",
                          backgroundColor: Colors.green[50]!,
                        ),
                        _buildInfoBox(
                          label: "Duration",
                          value: "${package.duration} days",
                          backgroundColor: Colors.orange[50]!,
                        ),
                        _buildInfoBox(
                          label: "Status",
                          value: package.isActive ? "Active" : "Inactive",
                          backgroundColor: package.isActive
                              ? Colors.green[50]!
                              : Colors.red[50]!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Trainer Information
              Text(
                "Trainer Information",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            package.owner.fullname
                                .substring(0, 1)
                                .toUpperCase(),
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package.owner.fullname,
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                package.owner.email,
                                style: getTextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Programs Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Programs Included",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "${package.programs.length}",
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              if (package.programs.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "No programs in this package",
                      style: getTextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: package.programs.length,
                  itemBuilder: (context, index) {
                    final programItem = package.programs[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.purple[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.fitness_center,
                                color: Colors.purple[600],
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    programItem.program.name,
                                    style: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Included in package",
                                    style: getTextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              SizedBox(height: 24),

              // Dates Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Created",
                          style: getTextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _formatDate(package.createdAt),
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 1, height: 40, color: Colors.grey[300]),
                    Column(
                      children: [
                        Text(
                          "Updated",
                          style: getTextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _formatDate(package.updatedAt),
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoBox({
    required String label,
    required String value,
    required Color backgroundColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: getTextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: getTextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Delete Package',
            style: getTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this package? This action cannot be undone.',
            style: getTextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close dialog
              },
              child: Text(
                'Cancel',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Close dialog
                controller.deletePackage(
                  controller.packageDetails.value?.id ?? '',
                );
              },
              child: Text(
                'Delete',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
