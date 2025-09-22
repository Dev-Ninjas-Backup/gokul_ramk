import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/session/trainers_tab/model/trainer_tab_model.dart';

class TopTrainerItem extends StatelessWidget {
  final TrainerTabModel trainer;
  const TopTrainerItem({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 35, backgroundImage: NetworkImage(trainer.image)),
        const SizedBox(height: 6),
        Text(
          trainer.name,
          style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          trainer.role,
          style: getTextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
