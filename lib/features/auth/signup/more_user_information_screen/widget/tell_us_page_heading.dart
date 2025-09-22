import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

// ignore: must_be_immutable
class TellUsPageHeading extends StatelessWidget {
  TellUsPageHeading({super.key, this.title = 'Tell Us About Yourself'});

  String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            'Skip',
            style: getTextStyle(
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title!,
              style: getTextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
