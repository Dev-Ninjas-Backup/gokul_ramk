import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBackButton extends StatelessWidget {
  VoidCallback onTap;
  CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
