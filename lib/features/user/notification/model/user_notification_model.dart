// class UserNotificationModel {
//   String? id;
//   String? userId;
//   String? actorId;
//   String? type;
//   String? category;
//   String? priority;
//   String? title;
//   String? message;
//   String? actionUrl;
//   String? imageUrl;
//   bool? isRead;

//   DateTime? expiresAt;
//   DateTime createdAt;   // MUST be non-null
//   DateTime updatedAt;

//   UserNotificationModel({
//     this.id,
//     this.userId,
//     this.actorId,
//     this.type,
//     this.category,
//     this.priority,
//     this.title,
//     this.message,
//     this.actionUrl,
//     this.imageUrl,
//     this.isRead,
//     this.expiresAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory UserNotificationModel.fromJson(Map<String, dynamic> json) {
//     return UserNotificationModel(
//       id: json['id'],
//       userId: json['userId'],
//       actorId: json['actorId'],
//       type: json['type'],
//       category: json['category'],
//       priority: json['priority'],
//       title: json['title'],
//       message: json['message'],
//       actionUrl: json['actionUrl'],
//       imageUrl: json['imageUrl'],
//       isRead: json['isRead'] ?? false,

//       // nullable
//       expiresAt: json['expiresAt'] != null
//           ? DateTime.tryParse(json['expiresAt'])
//           : null,

//       // non-null → fallback DateTime.now()
//       createdAt: DateTime.tryParse(json['createdAt'] ?? "") ?? DateTime.now(),
//       updatedAt: DateTime.tryParse(json['updatedAt'] ?? "") ?? DateTime.now(),
//     );
//   }
// }


class UserNotificationModel {
  String? id;
  String? userId;
  String? actorId;
  String? type;
  String? category;
  String? priority;
  String? title;
  String? message;
  String? actionUrl;
  String? imageUrl;
  bool? isRead;
  DateTime? expiresAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserNotificationModel({
    this.id,
    this.userId,
    this.actorId,
    this.type,
    this.category,
    this.priority,
    this.title,
    this.message,
    this.actionUrl,
    this.imageUrl,
    this.isRead,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserNotificationModel.fromJson(Map<String, dynamic> json) {
    return UserNotificationModel(
      id: json['id'],
      userId: json['userId'],
      actorId: json['actorId'],
      type: json['type'],
      category: json['category'],
      priority: json['priority'],
      title: json['title'],
      message: json['message'],
      actionUrl: json['actionUrl'],
      imageUrl: json['imageUrl'],
      isRead: json['isRead'],
      expiresAt: DateTime.tryParse(json['expiresAt'] ?? ""),
      createdAt: DateTime.tryParse(json['createdAt'] ?? ""),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ""),
    );
  }
}
