import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_back_button.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';

// ignore: must_be_immutable
class CustomAppBarTitle extends StatelessWidget {
  VoidCallback? onTapBack;
  final String title;
  CustomAppBarTitle({super.key, this.onTapBack, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomBackButton(
          onTap: () {
            if (onTapBack == null) {
              Get.back();
            } else {
              onTapBack!();
            }
          },
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryFontColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
