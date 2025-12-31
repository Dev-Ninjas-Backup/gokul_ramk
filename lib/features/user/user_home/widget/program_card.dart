import 'package:flutter/material.dart';
import 'package:gokul_ramk/features/user/user_home/model/program_model.dart';

class ProgramCard1 extends StatelessWidget {
  final Program1 program;

  const ProgramCard1({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Card(
    color: Colors.white70,
    
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.name ?? 'No Name',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            Text(program.description ?? 'No description'),

            const SizedBox(height: 6),

            // Text(
            //   'Trainer: ${program.trainer?.fullname ?? 'Unknown'}',
            // ),

            const SizedBox(height: 6),

            // Text(
            //   'Sessions: ${program.sessions?.length ?? 0}',
            // ),

            const SizedBox(height: 6),

            Text(
              'Price: \$${program.price ?? '0'} ${program.currency ?? ''}',
            ),
          ],
        ),
      ),
    );
  }
}
