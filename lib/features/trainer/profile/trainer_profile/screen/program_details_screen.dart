import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/program_details_controller.dart';

class ProgramDetailsScreen extends StatefulWidget {
  final String programId;

  const ProgramDetailsScreen({super.key, required this.programId});

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  late ProgramDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProgramDetailsController());
    controller.fetchProgramDetails(widget.programId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Program Details",
          style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.error.value != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  SizedBox(height: 16),
                  Text(
                    controller.error.value ?? "An error occurred",
                    style: getTextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final program = controller.programDetails.value;

          if (program == null) {
            return Center(
              child: Text(
                "No program data available",
                style: getTextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryFontColor,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Program Image
                Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.blue.shade50,
                  child:
                      program.thumbnailUrl != null &&
                          program.thumbnailUrl!.isNotEmpty
                      ? Image.network(
                          program.thumbnailUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image,
                                size: 60,
                                color: Colors.blue.shade300,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.blue.shade300,
                          ),
                        ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Program Title
                      Text(
                        program.name,
                        style: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Price Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "\$${program.price} ${program.currency}",
                          style: getTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Quick Info Cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Duration
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Color(0xFF4CAF50),
                                    size: 28,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "${program.duration}",
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Weeks",
                                    style: getTextStyle(
                                      fontSize: 12,
                                      color: AppColors.secondaryFontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          // Participants
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: Color(0xFF4CAF50),
                                    size: 28,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "${program.count?['enrollments'] ?? 0}",
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "Enrolled",
                                    style: getTextStyle(
                                      fontSize: 12,
                                      color: AppColors.secondaryFontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          // Status
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: program.isActive
                                    ? Colors.green.shade50
                                    : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    program.isActive
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: program.isActive
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    program.isActive ? "Active" : "Inactive",
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: program.isActive
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Description Section
                      Text(
                        "About This Program",
                        style: getTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        program.description,
                        style: getTextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryFontColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24),

                      // Trainer Section
                      if (program.trainer != null) ...[
                        Text(
                          "Trainer",
                          style: getTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              // Avatar
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    (program.trainer!.fullname.isNotEmpty
                                        ? program.trainer!.fullname[0]
                                              .toUpperCase()
                                        : 'T'),
                                    style: getTextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              // Trainer Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      program.trainer!.fullname,
                                      style: getTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      program.trainer!.email,
                                      style: getTextStyle(
                                        fontSize: 12,
                                        color: AppColors.secondaryFontColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                      ],

                      // Program Details
                      Text(
                        "Program Details",
                        style: getTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildDetailRow("Duration", "${program.duration} weeks"),
                      _buildDetailRow("Category", program.categoryId),
                      if (program.sessionsPerWeek != null)
                        _buildDetailRow(
                          "Sessions Per Week",
                          "${program.sessionsPerWeek}",
                        ),
                      if (program.maxParticipants != null)
                        _buildDetailRow(
                          "Max Participants",
                          "${program.maxParticipants}",
                        ),
                      _buildDetailRow(
                        "Created",
                        program.createdAt.toString().split('.')[0],
                      ),
                      SizedBox(height: 24),

                      // Action Button
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text(
                      //             "Program enrollment coming soon!",
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Color(0xFF4CAF50),
                      //       padding: EdgeInsets.symmetric(vertical: 16),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       "Enroll Now",
                      //       style: getTextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w700,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryFontColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
