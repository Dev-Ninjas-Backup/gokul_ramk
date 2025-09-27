import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/my_clients/my_clients_screen/model/client_card_model.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class ClientCardWidget extends StatelessWidget {
  final ClientCardModel trainer;

  const ClientCardWidget({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: AppColors.background,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  trainer.imageUrl,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          trainer.name,
                          style: getTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: trainer.status == "active"
                                ? Colors.green.shade100
                                : trainer.status == "paused"
                                ? Color(0XFF363636)
                                : Color(0XFF3B754B),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            trainer.status.capitalizeFirst ?? trainer.status,
                            style: getTextStyle(
                              fontSize: 12,
                              color: trainer.status == "active"
                                  ? Colors.green
                                  : trainer.status == "paused"
                                  ? Colors.white
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Current Goal: ${trainer.goal}",
                      style: getTextStyle(
                        fontSize: 14,
                        color: AppColors.secondaryFontColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Next Session: ${trainer.nextSession}",
                      style: getTextStyle(
                        fontSize: 14,
                        color: AppColors.primaryFontColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.background,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.7,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.primaryColor.withValues(alpha: 0.2),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              EasyLoading.showInfo('Chat Feature Coming Soon');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withValues(
                                  alpha: .2,
                                ),
                                border: Border.all(
                                  color: AppColors.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Message",
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor.withValues(
                                    alpha: .9,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.clientProfileScreen);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "View Profile",
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textFieldFillColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
