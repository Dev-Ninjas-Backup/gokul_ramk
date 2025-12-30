import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ChatService {
  final Logger _logger = Logger();

  /// Send message to AI chat endpoint using multipart/form-data
  Future<Map<String, dynamic>> sendMessage({
    required String userId,
    required String userToken,
    required String message,
    File? audioFile,
  }) async {
    try {
      final url = Uri.parse("https://wellfitsync.com/ai/api/chat");

      // Create multipart request
      var request = http.MultipartRequest('POST', url);

      // Add headers
      request.headers['Authorization'] = userToken;

      // Add form fields
      request.fields['user_id'] = userId;
      request.fields['user_token'] = userToken;
      request.fields['message'] = message;

      // Only add audio file if it exists
      if (audioFile != null && audioFile.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath('audio', audioFile.path),
        );
        _logger.i('Audio file added: ${audioFile.path}');
      }

      _logger.i('Sending message to AI: $message');
      _logger.i('Request URL: ${url.toString()}');
      _logger.i('User ID: $userId');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      _logger.i('Chat API response code: ${response.statusCode}');
      _logger.i('Chat API response body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(responseBody);
        return decodedData;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized - Invalid token');
      } else {
        throw Exception(
          'Failed to send message: ${response.statusCode} - $responseBody',
        );
      }
    } catch (e) {
      _logger.e('Error sending message: $e');
      rethrow;
    }
  }
}
