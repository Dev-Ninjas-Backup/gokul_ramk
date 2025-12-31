import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/program_details_controller.dart';

class TrainerProgramDetailsScreen extends StatelessWidget {
  final String programId;

  TrainerProgramDetailsScreen({super.key, required this.programId}) {
    if (!Get.isRegistered<NetworkClient>()) {
      Get.put(
        NetworkClient(
          onUnAuthorize: () {
            Get.snackbar("Session Expired", "Logging you out...");
            Get.offAllNamed('/login');
          },
        ),
      );
    }
    Get.put(TrainerProgramDetailsController());
  }

  late final TrainerProgramDetailsController controller =
      Get.find<TrainerProgramDetailsController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchProgramDetails(programId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Program Details",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: getTextStyle(fontSize: 14, color: Colors.red),
            ),
          );
        }

        final program = controller.program.value;
        if (program == null) {
          return const Center(child: Text('Program not found'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  program.thumbnailUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Program Name
              Text(
                program.name,
                style: getTextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Difficulty Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(program.difficulty),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  program.difficulty,
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // // Trainer Information
              // Text(
              //   "Trainer",
              //   style: getTextStyle(
              //     fontSize: 14,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
              // const SizedBox(height: 8),
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //     color: Colors.blue[50],
              //     border: Border.all(color: Colors.blue[100]!),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: program.trainer != null
              //       ? Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               program.trainer!.fullname,
              //               style: getTextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.black,
              //               ),
              //             ),
              //             const SizedBox(height: 4),
              //             Text(
              //               'Email: ${program.trainer!.email}',
              //               style: getTextStyle(
              //                 fontSize: 12,
              //                 color: Colors.grey[600] ?? Colors.grey,
              //               ),
              //             ),
              //             if (program.trainer!.phone != null)
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 4),
              //                 child: Text(
              //                   'Phone: ${program.trainer!.phone}',
              //                   style: getTextStyle(
              //                     fontSize: 12,
              //                     color: Colors.grey[600] ?? Colors.grey,
              //                   ),
              //                 ),
              //               ),
              //           ],
              //         )
              //       : Text(
              //           'Trainer information not available',
              //           style: getTextStyle(
              //             fontSize: 12,
              //             color: Colors.grey[600] ?? Colors.grey,
              //           ),
              //         ),
              // ),
              // const SizedBox(height: 20),

              // // Difficulty Badge
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 12,
              //     vertical: 6,
              //   ),
              //   decoration: BoxDecoration(
              //     color: _getDifficultyColor(program.difficulty),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Text(
              //     program.difficulty,
              //     style: getTextStyle(
              //       fontSize: 12,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 16),

              // Description
              Text(
                "Description",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                program.description,
                style: getTextStyle(
                  fontSize: 13,
                  color: Colors.grey[700] ?? Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // Video Section
              Text(
                "Program Video",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  try {
                    final url = Uri.parse(program.videoUrl);

                    await launchUrl(url, mode: LaunchMode.platformDefault);
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      'Failed to open video: ${e.toString()}',
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.video_library, color: Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          program.videoUrl,
                          style: getTextStyle(fontSize: 12, color: Colors.blue),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Price and Details Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: getTextStyle(
                          fontSize: 12,
                          color: Colors.grey[600] ?? Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${program.price}",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Max Participants",
                        style: getTextStyle(
                          fontSize: 12,
                          color: Colors.grey[600] ?? Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        program.maxParticipants.toString(),
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enrollments",
                        style: getTextStyle(
                          fontSize: 12,
                          color: Colors.grey[600] ?? Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        program.enrollments.toString(),
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Status and Currency Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status",
                        style: getTextStyle(
                          fontSize: 12,
                          color: Colors.grey[600] ?? Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            program.isActive
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 16,
                            color: program.isActive ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            program.isActive ? "Active" : "Inactive",
                            style: getTextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: program.isActive
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Currency",
                        style: getTextStyle(
                          fontSize: 12,
                          color: Colors.grey[600] ?? Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        program.currency,
                        style: getTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Created Date
              Text(
                "Created",
                style: getTextStyle(
                  fontSize: 12,
                  color: Colors.grey[600] ?? Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                program.createdAt,
                style: getTextStyle(fontSize: 13, color: Colors.black),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toUpperCase()) {
      case 'BEGINNER':
        return Colors.green;
      case 'INTERMEDIATE':
        return Colors.orange;
      case 'ADVANCED':
        return Colors.red;
      default:
        return Colors.grey[600] ?? Colors.grey;
    }
  }
}
