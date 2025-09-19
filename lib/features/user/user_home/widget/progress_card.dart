import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final double progress;

  const ProgressCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "You're ${(progress * 100).toInt()}% to today's goal 🚀Keep it up!",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.green,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text("${(progress * 100).toInt()}%"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
