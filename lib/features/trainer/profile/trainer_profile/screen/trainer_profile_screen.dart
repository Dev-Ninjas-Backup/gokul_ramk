import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/about_me_widget.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/my_product_widget.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/programs_offer_widgets.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/sales_balance_widget.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/trainer_profile_card_widget.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

import '../controller/trainer_profile_controller.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferencesHelperController sharedPreferencesHelperController =
        Get.put(SharedPreferencesHelperController());
    final TrainerProfileController trainerProfileController =
        Get.isRegistered<TrainerProfileController>()
        ? Get.find<TrainerProfileController>()
        : Get.put(TrainerProfileController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () async {
                      EasyLoading.show(status: 'Loading...');
                      await trainerProfileController.fetchTrainerProfile();
                      EasyLoading.dismiss();
                      final trainer =
                          trainerProfileController.trainerProfileData.value;
                      Get.toNamed(
                        AppRoute.trainerTellAboutScreen,
                        arguments: [
                          trainer?.fullname ?? "",
                          trainer?.images ?? "",
                          trainer?.bio ?? "",
                          trainer?.specializations ?? [],
                        ],
                      );
                    },

                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[400],
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TrainerProfileCardWidget(),
                SizedBox(height: 16),
                AboutMeWidget(),
                SizedBox(height: 16),
                ProgramsOfferedWidget(),
                SizedBox(height: 12),
                MyProductsWidget(),
                SizedBox(height: 12),
                SalesAndBalanceWidget(),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    sharedPreferencesHelperController.clearAllData();
                    Get.offAllNamed(AppRoute.loginScreen);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Logout'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
