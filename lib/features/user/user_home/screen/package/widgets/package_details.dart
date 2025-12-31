import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/session_screen/screen/session_detail_screen.dart';
import 'package:gokul_ramk/features/user/user_home/screen/package/controller/user_package_details_controller.dart';
import 'package:gokul_ramk/features/user/user_home/screen/package/model/package_model.dart';


class PackageDetailsScreenUser extends StatelessWidget {
  final String packageId;

  PackageDetailsScreenUser({super.key, required this.packageId});

  final PackageDetailsController controller = Get.put(
    PackageDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    controller.fetchPackageDetails(packageId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Package Details'),
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }

          final PackageData? package = controller.package.value;
          if (package == null) {
            return const Center(child: Text('Package not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.name ?? 'Unnamed Package',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(package.description ?? 'No description available'),
                const SizedBox(height: 12),
                Text('Owner: ${package.owner?.fullname ?? 'Unknown'}'),
                Text('Email: ${package.owner?.email ?? 'N/A'}'),
                const SizedBox(height: 12),
                 Text('PurchaseCount: ${package.purchaseCount ?? 'N/A'}'),
                                 const SizedBox(height: 12),

                Text(
                  'Price: \$${package.price ?? '0.00'}',
                ),

                      Text(
                  'Discount: \$${package.discount ?? '0.00'}',
                ),
                // Text('Max Participants: ${program.maxParticipants ?? 0}'),
                                 const SizedBox(height: 20),

                Text('Active: ${package.isActive == true ? 'Yes' : 'No'}'),
                                Text('Public: ${package.isPublic == true ? 'Yes' : 'No'}'),
                                                const SizedBox(height: 12),
                Text("CreatedAt: ${package.createdAt ?? ''}"),

                const SizedBox(height: 20),

                const Text(
                  'Sessions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                package.sessions == null || package.sessions!.isEmpty
                    ? const Text('No sessions found')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: package.sessions!.length,
                        itemBuilder: (context, index) {
                          final session = package.sessions![index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => SessionDetailScreen(
                                  sessionId: session.id.toString(),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(session.title ?? 'No title'),
                                subtitle: Text(
                                  session.description ?? 'No description',
                                ),
                                trailing: Text('Price: ${session.price ?? 0}'),
                              ),
                            ),
                          );
                        },
                      ),

                const SizedBox(height: 80),
              ],
            ),
          );
        }),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30),
        child: ElevatedButton(
          onPressed: () async{
           await controller.showBuyDialog(context, packageId);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: const Text("Buy Program"),
        ),
      ),
    );
  }
}
