import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/widgets/current_program_widget.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/widgets/health_matrics_grid_widget.dart';
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
                CustomAppBarTitle(title: 'Client Profile'),

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

                SizedBox(height: 12),
                CurrentProgramWidget(),
                SizedBox(height: 12),
                ProgressHeaderWidget(),
                SizedBox(height: 12),
                ProgressSection(),
                SizedBox(height: 12),
                RecentActivitySection(),
                SizedBox(height: 12),
                HealthMetricsGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
