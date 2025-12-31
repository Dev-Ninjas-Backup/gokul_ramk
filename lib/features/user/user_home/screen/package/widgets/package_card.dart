import 'package:flutter/material.dart';
import 'package:gokul_ramk/features/user/user_home/screen/package/model/package_model.dart';

class PackageCard1 extends StatelessWidget {
  final PackageData package;

  const PackageCard1({super.key, required this.package});

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
              package.name ?? 'No Name',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            Text(package.description ?? 'No description'),

            const SizedBox(height: 6),

            // Text(
            //   'Trainer: ${program.trainer?.fullname ?? 'Unknown'}',
            // ),
            const SizedBox(height: 6),

            // Text(
            //   'Sessions: ${program.sessions?.length ?? 0}',
            // ),
            const SizedBox(height: 6),

            Text('Price: \$${package.price ?? '0.00'} '),
          ],
        ),
      ),
    );
  }
}
