import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:logger/logger.dart';
import '../model/message_model.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;
  final Logger _logger = Logger();

  // Stream controllers for messages
  late Function(MessageModel) onMessageReceived;
  late Function(String) onConnectionStatusChanged;

  SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  /// Initialize socket connection
  Future<void> connect(String baseUrl, String userId) async {
    try {
      socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'userId': userId})
            .disableAutoConnect()
            .build(),
      );

      // Connection event listeners
      socket.onConnect((_) {
        _logger.i('Socket connected');
        onConnectionStatusChanged?.call('connected');
      });

      socket.onConnectError((error) {
        _logger.e('Connection error: $error');
        onConnectionStatusChanged?.call('error');
      });

      socket.onDisconnect((_) {
        _logger.i('Socket disconnected');
        onConnectionStatusChanged?.call('disconnected');
      });

      // Listen for incoming messages
      socket.on('receive_message', (data) {
        _logger.i('Message received: $data');
        final message = MessageModel.fromJson({
          'id': data['id'] ?? '',
          'senderId': data['senderId'] ?? '',
          'receiverId': data['receiverId'] ?? '',
          'text': data['message'] ?? data['text'] ?? '',
          'timestamp': DateTime.now().toIso8601String(),
          'isRead': false,
        });
        onMessageReceived?.call(message);
      });

      socket.connect();
    } catch (e) {
      _logger.e('Socket connection error: $e');
      rethrow;
    }
  }

  /// Send message through socket
  void sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) {
    try {
      socket.emit('send_message', {
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
      });
      _logger.i('Message sent: senderId=$senderId, receiverId=$receiverId');
    } catch (e) {
      _logger.e('Error sending message: $e');
    }
  }

  /// Disconnect socket
  void disconnect() {
    try {
      socket.disconnect();
      _logger.i('Socket disconnected');
    } catch (e) {
      _logger.e('Error disconnecting: $e');
    }
  }

  /// Check if socket is connected
  bool isConnected() {
    return socket.connected;
  }

  /// Reconnect socket
  void reconnect() {
    try {
      if (socket.disconnected) {
        socket.connect();
        _logger.i('Socket reconnected');
      }
    } catch (e) {
      _logger.e('Error reconnecting: $e');
    }
  }
}
