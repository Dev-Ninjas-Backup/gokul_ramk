import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';

class CurrentProgramWidget extends StatelessWidget {
  const CurrentProgramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      decoration: ShapeDecoration(
        color: Colors.blue[50],
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.25, color: AppColors.background),
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 05,
            offset: Offset(02, 06),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              SizedBox(
                width: 192,
                child: Text(
                  'Current Program',
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    color: AppColors.secondaryFontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                'Weight Loss with Gokul',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  color: AppColors.primaryFontColor,
                  fontSize: 20,

                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
