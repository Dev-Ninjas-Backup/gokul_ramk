import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/about_me_widget.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/my_product_widget.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/programs_offer_widgets.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/sales_balance_widget.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/widgets/trainer_profile_card_widget.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBarTitle(title: 'Trainer Profile'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
