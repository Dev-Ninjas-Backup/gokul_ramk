
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/notification/model/user_notification_model.dart';


class UserNotificationController extends GetxController {
  var notifications = <UserNotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    notifications.value = [
      UserNotificationModel(
        title: "Congratulations!",
        subtitle: "You've been exercising for 3 hours",
        timeAgo: "5 mins ago",
        category: "Today",
        icon: "🏋️", 
      ),
      UserNotificationModel(
        title: "New Workout is Available!",
        subtitle: "Check now & practice",
        timeAgo: "15 mins ago",
        category: "Today",
        icon: "💪",
      ),
      UserNotificationModel(
        title: "Yoga Online Session is Live!",
        subtitle: "Check now & practice",
        timeAgo: "20 mins ago",
        category: "Today",
        icon: "🎯",
      ),
      UserNotificationModel(
        title: "Congratulations!",
        subtitle: "You've been exercising for 3 hours",
        timeAgo: "5 mins ago",
        category: "Yesterday",
        icon: "🏋️",
      ),
      UserNotificationModel(
        title: "Congratulations!",
        subtitle: "You've been exercising for 3 hours",
        timeAgo: "5 mins ago",
        category: "Last week",
        icon: "🏋️",
      ),
    ];
  }
}
