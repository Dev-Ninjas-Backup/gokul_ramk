import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/user_home/controller/program_details_controller_user.dart';
import 'package:gokul_ramk/features/user/user_home/model/program_model.dart';


class ProgramDetailsScreenUser extends StatelessWidget {
  final String programId;

  ProgramDetailsScreenUser({super.key, required this.programId});

  final ProgramDetailsController controller =
      Get.put(ProgramDetailsController());

  @override
  Widget build(BuildContext context) {
    // Fetch program details
    controller.fetchProgramDetails(programId);

    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
        title: const Text('Program Details'),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }

          final Program1? program = controller.program.value;
          if (program == null) {
            return const Center(child: Text('Program not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  program.name ?? 'Unnamed Program',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(program.description ?? 'No description available'),
                const SizedBox(height: 12),
                Text('Trainer: ${program.trainer?.fullname ?? 'Unknown'}'),
                Text('Email: ${program.trainer?.email ?? 'N/A'}'),
                const SizedBox(height: 12),
                Text('Difficulty: ${program.difficulty ?? 'N/A'}'),
                Text(
                    'Price: ${program.price ?? '0'} ${program.currency ?? ''}'),
                Text('Max Participants: ${program.maxParticipants ?? 0}'),
                Text('Active: ${program.isActive == true ? 'Yes' : 'No'}'),
                const SizedBox(height: 20),
                const Text(
                  'Sessions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                program.sessions == null || program.sessions!.isEmpty
                    ? const Text('No sessions found')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: program.sessions!.length,
                        itemBuilder: (context, index) {
                          final session = program.sessions![index];
                          return Card(
                          color: Colors.white70,
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(session.title ?? 'No title'),
                              subtitle: Text(session.description ?? 'No desc'),
                              trailing: Text(
                                  'Price: ${session.price?.toString() ?? '0'}'),
                            ),
                          );
                        },
                      ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
