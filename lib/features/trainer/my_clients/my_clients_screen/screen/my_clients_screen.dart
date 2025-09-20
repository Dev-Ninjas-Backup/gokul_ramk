import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/my_clients/my_clients_screen/controller/client_card_controller.dart';
import 'package:gokul_ramk/features/trainer/my_clients/my_clients_screen/widgets/client_card_widget.dart';

class MyClientsScreen extends StatelessWidget {
  const MyClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientCardController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'My Clients',
                    style: getTextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.secondaryButtonColor,
                    ),
                    child: Icon(
                      Icons.search,
                      size: 26,
                      color: AppColors.secondaryFontColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.trainer.length,
                    itemBuilder: (context, index) {
                      final trainer = controller.trainer[index];
                      return ClientCardWidget(trainer: trainer);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
