import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/session/controller/session_controller.dart';

class TopTrainerItem extends StatelessWidget {
  final SessionController controller;
  final int index;

  //final TrainerTabModel trainer;
  const TopTrainerItem({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        (controller.topTrainers[index].images != null &&
            controller.topTrainers[index].images!.isNotEmpty)
        ? controller.topTrainers[index].images!
        : "";

            final specialty = controller.topTrainers[index].specializations.isNotEmpty
        ? controller.topTrainers[index].specializations.first
        : "No specialization";

    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey.shade200,
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 70,
              height: 70,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 35);
              },
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          controller.topTrainers[index].fullname,
          style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          specialty,
          style: getTextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
