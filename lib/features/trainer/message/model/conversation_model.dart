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
    return ConversationModel(
      id: json['id'] ?? json['_id'] ?? '',
      userId: json['userId'] ?? '',
      conversationPartner:
          json['conversationPartner'] ?? json['participantId'] ?? '',
      partnerName: json['partnerName'] ?? json['name'],
      partnerImage: json['partnerImage'] ?? json['profileImage'],
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'].toString())
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
