import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class TrainerProfileHeaderWidget extends StatelessWidget {
  final String imageUrl, name, location;

  const TrainerProfileHeaderWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 5,
            color: Colors.grey.shade100,
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 45, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(height: 12),
          Text(
            name,
            style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(location, style: getTextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
