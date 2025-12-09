// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:gokul_ramk/core/services/network_service/network_client.dart';
// import 'package:gokul_ramk/core/endpoint/end_points.dart';
// import 'package:gokul_ramk/features/user/notification/model/user_notification_model.dart';

// class NotificationService {
//   final NetworkClient client = NetworkClient(
//     onUnAuthorize: () {
//       EasyLoading.showError("UnAuthorized");
//     },
//   );

//   Future<List<UserNotificationModel>> fetchNotifications() async {
//     final url = "${Endpoint.baseUrl}/notifications";

//     final response = await client.getRequest(url: url);

//     if (response.isSuccess) {
//       final List list = response.responseData?['notifications'] ?? [];

//       return list.map((e) => UserNotificationModel.fromJson(e)).toList();
//     }

//     return [];
//   }

//   Future<bool> markAsRead(String id) async {
//     final url = "${Endpoint.baseUrl}/notifications/$id/read";

//     final response = await client.postRequest(url: url, body: {});

//     return response.isSuccess;
//   }
// }
