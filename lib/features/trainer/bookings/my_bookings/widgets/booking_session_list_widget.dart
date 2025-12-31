import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/bookings/booking_details/screen/booking_details_screen.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/controller/booking_session_controller.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/model/booking_session_model.dart';
import 'package:gokul_ramk/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingSessionListWidget extends StatelessWidget {
  final BookingSessionController controller = Get.put(
    BookingSessionController(),
  );

  BookingSessionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingSessions.value && controller.sessions.isEmpty) {
        return Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        );
      }

      if (controller.sessions.isEmpty) {
        return Center(
          child: Text('No bookings yet', style: getTextStyle(fontSize: 16)),
        );
      }

      return ListView.builder(
        itemCount:
            controller.sessions.length +
            (controller.hasMoreSessions.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.sessions.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: GestureDetector(
                onTap: controller.loadMoreSessions,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Load More',
                    style: getTextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }

          final session = controller.sessions[index];
          return BookingSessionCard(
            session: session,
            onMarkComplete: () => controller.markComplete(index),
            onMarkConfirm: (id) => controller.markConfirm(id),
          );
        },
      );
    });
  }
}

class BookingSessionCard extends StatefulWidget {
  final BookingSessionModel session;
  final VoidCallback onMarkComplete;
  final Function(String) onMarkConfirm;

  const BookingSessionCard({
    super.key,
    required this.session,
    required this.onMarkComplete,
    required this.onMarkConfirm,
  });

  @override
  State<BookingSessionCard> createState() => _BookingSessionCardState();
}

class _BookingSessionCardState extends State<BookingSessionCard> {
  String? userProfileImage;
  bool isLoadingImage = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfileImage();
  }

  Future<void> _fetchUserProfileImage() async {
    try {
      final networkClient = Get.find<NetworkClient>();
      final token = await networkClient.sharedPreferencesHelper.getAccessToken();
      
      final response = await http.get(
        Uri.parse(Urls.getUserProfile(widget.session.user.id)),
        headers: {
          'Authorization': token ?? '',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData is Map && decodedData['data'] != null) {
          final userData = decodedData['data'] as Map<String, dynamic>;
          final images = userData['images'] as String?;
          if (images != null && images.isNotEmpty) {
            setState(() {
              userProfileImage = images;
              isLoadingImage = false;
            });
          } else {
            setState(() {
              isLoadingImage = false;
            });
          }
        }
      } else {
        setState(() {
          isLoadingImage = false;
        });
      }
    } catch (e) {
      print('Error fetching user profile image: $e');
      setState(() {
        isLoadingImage = false;
      });
    }
  }

  String _getUserName() {
    return widget.session.user.fullname;
  }

  String _getSessionType() {
    return widget.session.mode.toUpperCase();
  }

  String _getFormattedStatus() {
    String status = widget.session.status.replaceAll('_', ' ');
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => BookingDetailsScreen(bookingId: widget.session.id));
      },
      child: Card(
        shadowColor: AppColors.primaryColor,
        color: AppColors.background,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: isLoadingImage || userProfileImage == null
                        ? AssetImage(Imagepath.trainer)
                        : NetworkImage(userProfileImage!) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getUserName(),
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Date & Time: ${widget.session.formattedDate}",
                      style: getTextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Status: ${_getFormattedStatus()}",
                      style: getTextStyle(),
                    ),
                    SizedBox(height: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: .18),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getSessionType(),
                        style: getTextStyle(
                          color: AppColors.primaryColor.withValues(alpha: .9),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'message') {
                    Get.toNamed(
                      AppRoute.messageDetailScreen,
                      arguments: {
                        'conversationId': widget.session.user.id,
                        'partnerId': widget.session.user.id,
                        'partnerName': widget.session.user.fullname,
                        'partnerImage': null,
                      },
                    );
                  } else if (value == 'complete') {
                    widget.onMarkComplete();
                  } else if (value == 'confirm') {
                    widget.onMarkConfirm(widget.session.id);
                  } else if (value == 'details') {
                    Get.to(() => BookingDetailsScreen(bookingId: widget.session.id));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'message',
                    child: Row(
                      children: [
                        Icon(Icons.message, size: 18),
                        SizedBox(width: 8),
                        Text('Message'),
                      ],
                    ),
                  ),
                  if (widget.session.status.toUpperCase() == 'PENDING')
                    PopupMenuItem(
                      value: 'confirm',
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, size: 18),
                          SizedBox(width: 8),
                          Text('Mark Confirm'),
                        ],
                      ),
                    ),
                  if (widget.session.status.toUpperCase() == 'PENDING' ||
                      widget.session.status.toUpperCase() == 'CONFIRMED')
                    PopupMenuItem(
                      value: 'complete',
                      child: Row(
                        children: [
                          Icon(Icons.done_all, size: 18),
                          SizedBox(width: 8),
                          Text('Mark Complete'),
                        ],
                      ),
                    ),
                  // if (widget.session.status.toUpperCase() != 'PENDING' &&
                  //     widget.session.status.toUpperCase() != 'CONFIRMED')
                  PopupMenuItem(
                    value: 'details',
                    child: Row(
                      children: [
                        Icon(Icons.info, size: 18),
                        SizedBox(width: 8),
                        Text('View Details'),
                      ],
                    ),
                  ),
                ],
                icon: Icon(Icons.more_vert, color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
