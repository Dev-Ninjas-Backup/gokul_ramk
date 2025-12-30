import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import '../model/conversation_model.dart';
import '../model/message_model.dart';

class MessageApiService {
  final Logger _logger = Logger();

  /// Get unique conversations (users who started message)
  Future<List<ConversationModel>> getUniqueConversations({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(Urls.uniqueConversations),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );

      _logger.i('Get conversations response code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        // Handle different response formats
        List<dynamic> conversations = [];
        if (decodedData is List) {
          conversations = decodedData;
        } else if (decodedData is Map) {
          // Try different response wrapper keys
          if (decodedData['data'] != null) {
            conversations = decodedData['data'] as List<dynamic>;
          } else if (decodedData['conversations'] != null) {
            conversations = decodedData['conversations'] as List<dynamic>;
          } else if (decodedData['result'] != null) {
            conversations = decodedData['result'] as List<dynamic>;
          } else {
            conversations = [];
          }
        }

        _logger.i('Parsed conversations count: ${conversations.length}');
        return conversations
            .map(
              (json) =>
                  ConversationModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
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
