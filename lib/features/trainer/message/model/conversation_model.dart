import 'message_model.dart';

class ConversationModel {
  final String id;
  final String userId;
  final String conversationPartner;
  final String? partnerName;
  final String? partnerImage;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  ConversationModel({
    required this.id,
    required this.userId,
    required this.conversationPartner,
    this.partnerName,
    this.partnerImage,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    // Support multiple response formats
    final partnerName =
        json['partnerName'] ??
        json['name'] ??
        json['fullname'] ??
        json['receiver']?['fullname'] ??
        json['sender']?['fullname'] ??
        'Unknown User';

    final partnerImage =
        json['partnerImage'] ??
        json['profileImage'] ??
        json['images'] ??
        json['receiver']?['images'] ??
        json['sender']?['images'];

    return ConversationModel(
      id: json['id'] ?? json['_id'] ?? '',
      userId: json['userId'] ?? json['senderId'] ?? '',
      conversationPartner:
          json['conversationPartner'] ??
          json['participantId'] ??
          json['receiverId'] ??
          json['senderId'] ??
          '',
      partnerName: partnerName,
      partnerImage: partnerImage,
      lastMessage: json['lastMessage'] ?? json['message'] ?? '',
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'].toString())
          : json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : DateTime.now(),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'conversationPartner': conversationPartner,
      'partnerName': partnerName,
      'partnerImage': partnerImage,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadCount': unreadCount,
    };
  }

  @override
  String toString() =>
      'ConversationModel(id: $id, userId: $userId, conversationPartner: $conversationPartner, partnerName: $partnerName, lastMessage: $lastMessage)';
}
