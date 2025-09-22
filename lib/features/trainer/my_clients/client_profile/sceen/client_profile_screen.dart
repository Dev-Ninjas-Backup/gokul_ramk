import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/widgets/current_program_widget.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/widgets/progress_header_widget.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/widgets/progress_section.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/widgets/recent_activity_section.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back_outlined, size: 32),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    SizedBox(width: 96),

                    Text(
                      'Client Profile',
                      style: getTextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                CircleAvatar(
                  backgroundImage: AssetImage(Imagepath.trainer),
                  radius: 60,
                ),
                SizedBox(height: 14),
                Text(
                  'Alex Carter',
                  style: getTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryFontColor,
                  ),
                ),

                Text(
                  'alex@carter.com | +1 234 567 890',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryFontColor,
                  ),
                ),

                SizedBox(height: 12),
                CurrentProgramWidget(),
                SizedBox(height: 12),
                ProgressHeaderWidget(),
                SizedBox(height: 12),
                ProgressSection(),
                SizedBox(height: 12),
                RecentActivitySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
