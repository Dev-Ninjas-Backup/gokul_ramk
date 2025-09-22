import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

class ProfileInfoCard extends StatelessWidget {
  final double rating;
  final int clients;

  const ProfileInfoCard({
    super.key,
    required this.rating,
    required this.clients,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "⭐ $rating",
                style: getTextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 6),
              Text("Average Rating"),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              InfoItem(icon: Icons.verified, text: "Certified Trainer"),
              InfoItem(icon: Icons.timer, text: "5+ Years Experience"),
              InfoItem(icon: Icons.group, text: "200+ Clients"),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 18),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}
