import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import '../model/conversation_model.dart';
import '../model/message_model.dart';

class MessageApiService {
  final Logger _logger = Logger();

  /// Get unique conversations (users who started message)
  /// Parses the API response which contains messages with sender/receiver objects
  /// Extracts unique conversation partners based on the current user
  Future<List<ConversationModel>> getUniqueConversations({
    required String token,
    required String currentUserId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(Urls.uniqueConversations),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      _logger.i('Get conversations response code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        // Extract messages from API response
        List<dynamic> messages = [];
        if (decodedData is Map && decodedData['data'] != null) {
          messages = decodedData['data'] as List<dynamic>;
        } else if (decodedData is List) {
          messages = decodedData;
        }

        _logger.i('Total messages received: ${messages.length}');

        // Build unique conversations from messages
        // Extract unique conversation partners
        final Map<String, ConversationModel> uniqueConversations = {};

        for (var messageData in messages) {
          final message = messageData as Map<String, dynamic>;
          final senderId = message['senderId'] ?? '';
          final receiverId = message['receiverId'] ?? '';
          final sender = message['sender'] as Map<String, dynamic>? ?? {};
          final receiver = message['receiver'] as Map<String, dynamic>? ?? {};

          // Determine the conversation partner
          late String partnerId;
          late Map<String, dynamic> partnerData;

          if (senderId == currentUserId) {
            // I am the sender, partner is receiver
            partnerId = receiverId;
            partnerData = receiver;
          } else {
            // I am the receiver, partner is sender
            partnerId = senderId;
            partnerData = sender;
          }

          // Add or update conversation
          uniqueConversations[partnerId] = ConversationModel(
            id: message['id'] ?? '',
            userId: currentUserId,
            conversationPartner: partnerId,
            partnerName: partnerData['fullname'] ?? 'Unknown User',
            partnerImage: partnerData['images'],
            lastMessage: message['message'] ?? '',
            lastMessageTime: message['updatedAt'] != null
                ? DateTime.parse(message['updatedAt'].toString())
                : DateTime.now(),
            unreadCount: 0,
          );
        }

        final conversationList = uniqueConversations.values.toList();
        _logger.i(
            'Parsed unique conversations count: ${conversationList.length}');
        return conversationList;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception(
          'Failed to fetch conversations: ${response.statusCode}',
        );
      }
    } catch (e) {
      _logger.e('Error fetching conversations: $e');
      rethrow;
    }
  }

  /// Get conversation messages between two users
  Future<List<MessageModel>> getConversation({
    required String senderId,
    required String receiverId,
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(Urls.conversation(senderId, receiverId)),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      _logger.i('Get conversation response code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Handle different response formats
        List<dynamic> messages = [];
        if (data is List) {
          messages = data;
        } else if (data is Map && data['messages'] != null) {
          messages = data['messages'] as List<dynamic>;
        } else if (data is Map && data['data'] != null) {
          messages = data['data'] as List<dynamic>;
        }

        return messages
            .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to fetch conversation: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error fetching conversation: $e');
      rethrow;
    }
  }
}
