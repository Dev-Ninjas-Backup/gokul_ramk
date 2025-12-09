

// import 'package:get/get.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:gokul_ramk/core/endpoint/end_points.dart';
// import 'package:gokul_ramk/features/user/notification/model/user_notification_model.dart';
// import '../../../../core/services/network_service/network_client.dart';

// class NotificationController extends GetxController {
//   final NetworkClient client = NetworkClient(
//     onUnAuthorize: () {
//       EasyLoading.showError("UnAuthorized");
//     },
//   );

//   RxList<UserNotificationModel> notifications = <UserNotificationModel>[].obs;
//   RxBool isLoading = false.obs;
//   RxString selectedCategory = "all".obs;

// var categories = ["all", "community", "order", "booking", "system"].obs;

//   @override
//   void onInit() {
//     getNotifications();
//     super.onInit();
//   }

//   /// Fetch notifications by category
//   Future<void> getNotifications() async {
//     isLoading.value = true;

//     final url = "${Urls.baseUrl}/notifications?category=${selectedCategory.value}";

//     try {
//       final response = await client.getRequest(url: url);

//       if (response.isSuccess &&
//           (response.statusCode == 200 || response.statusCode == 201)) {
//         final List data = response.responseData!['notifications'] ?? [];

//         notifications.value =
//             data.map((json) => UserNotificationModel.fromJson(json)).toList();
//       } else {
//         EasyLoading.showError("Failed to load notifications");
//       }
//     } catch (e) {
//       EasyLoading.showError("Error: $e");
//     }

//     isLoading.value = false;
//   }

//   /// Change category
//   void changeCategory(String cat) {
//     selectedCategory.value = cat;
//     getNotifications();
//   }

//   /// Mark a notification as read
//   Future<void> markAsRead(String id) async {
//     final index = notifications.indexWhere((n) => n.id == id);
//     if (index == -1) return;

//     // Optimistic UI update
//     final oldValue = notifications[index].isRead ?? false;
//     notifications[index].isRead = true;
//     notifications.refresh();

//     final url = "${Urls.baseUrl}/notifications/$id/read";

//     try {
//       final response = await client.putRequest(url: url, body: {});
//       if (!(response.isSuccess &&
//           (response.statusCode == 200 || response.statusCode == 201))) {
//         // rollback if failed
//         notifications[index].isRead = oldValue;
//         notifications.refresh();
//         EasyLoading.showError("Failed to mark as read");
//       }
//     } catch (e) {
//       notifications[index].isRead = oldValue;
//       notifications.refresh();
//       EasyLoading.showError("Error: $e");
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/features/user/notification/model/user_notification_model.dart';
import '../../../../core/services/network_service/network_client.dart';

class NotificationController extends GetxController {
  final NetworkClient client = NetworkClient(
    onUnAuthorize: () {
      EasyLoading.showError("UnAuthorized");
    },
  );

  RxList<UserNotificationModel> notifications = <UserNotificationModel>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedCategory = "all".obs;

  // Tracks which notification is expanded
  RxMap<String, bool> expandedMap = <String, bool>{}.obs;

  var categories = ["all", "community", "order", "booking", "system"].obs;

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  /// Fetch notifications by category
  Future<void> getNotifications() async {
    isLoading.value = true;

    final url = "${Urls.baseUrl}/notifications?category=${selectedCategory.value}";

    try {
      final response = await client.getRequest(url: url);

      if (response.isSuccess &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        final List data = response.responseData!['notifications'] ?? [];
        notifications.value =
            data.map((json) => UserNotificationModel.fromJson(json)).toList();
      } else {
        EasyLoading.showError("Failed to load notifications");
      }
    } catch (e) {
      EasyLoading.showError("Error: $e");
    }

    isLoading.value = false;
  }

  /// Change category
  void changeCategory(String cat) {
    selectedCategory.value = cat;
    getNotifications();
  }

  /// Toggle See more / See less
  void toggleExpanded(String id) {
    expandedMap[id] = !(expandedMap[id] ?? false);
  }

  /// Mark a notification as read
  Future<void> markAsRead(String id) async {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index == -1) return;

    // Optimistic UI update
    final oldValue = notifications[index].isRead ?? false;
    notifications[index].isRead = true;
    notifications.refresh();

    final url = "${Urls.baseUrl}/notifications/$id/read";

    try {
      final response = await client.putRequest(url: url, body: {});
      if (!(response.isSuccess &&
          (response.statusCode == 200 || response.statusCode == 201))) {
        // rollback if failed
        notifications[index].isRead = oldValue;
        notifications.refresh();
        EasyLoading.showError("Failed to mark as read");
      }
    } catch (e) {
      notifications[index].isRead = oldValue;
      notifications.refresh();
      EasyLoading.showError("Error: $e");
    }
  }
}
