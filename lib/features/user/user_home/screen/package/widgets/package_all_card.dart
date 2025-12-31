import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/user_home/controller/user_home_controller.dart';
import 'package:gokul_ramk/features/user/user_home/screen/package/widgets/package_card.dart';
import 'package:gokul_ramk/features/user/user_home/screen/package/widgets/package_details.dart';
// Make sure this is your ProgramCard1 widget

class AllPackageScreenUser extends StatelessWidget {
  AllPackageScreenUser({super.key});

  final UserHomeController controller = Get.find<UserHomeController>();

  @override
  Widget build(BuildContext context) {
    // Fetch programs when the screen loads

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('All Package'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          // Loading state
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // No programs
          if (controller.packageAll1.isEmpty) {
            return const Center(child: Text('No package found'));
          }

          // Programs list
          return ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: controller.packageAll1.length,
            itemBuilder: (context, index) {
              final package = controller.packageAll1[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => PackageDetailsScreenUser(
                        packageId: package.id.toString(),
                      ),
                    );
                  },

                  child: PackageCard1(package: package),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
