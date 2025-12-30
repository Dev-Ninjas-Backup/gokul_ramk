import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:logger/logger.dart';
import '../model/message_model.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;
  final Logger _logger = Logger();

  // Callbacks for messages
  late Function(MessageModel) onMessageReceived;
  late Function(String) onConnectionStatusChanged;

  SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  /// Initiate socket connection with userId
  /// Similar to initiateSocket in TypeScript
  Future<void> initiateSocket(String baseUrl, String userId) async {
    try {
      socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'userId': userId})
            .disableAutoConnect()
            .build(),
      );

      _setupListeners();
      socket.connect();
    } catch (e) {
      _logger.e('Socket initiation error: $e');
      rethrow;
    }
  }

  /// Setup all socket event listeners
  void _setupListeners() {
    // Connection event listeners
    socket.onConnect((_) {
      _logger.i('Socket connected with ID: ${socket.id}');
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
      try {
        final message = MessageModel.fromJson({
          'id': data['id'] ?? '',
          'senderId': data['senderId'] ?? '',
          'receiverId': data['receiverId'] ?? '',
          'text': data['message'] ?? data['text'] ?? '',
          'timestamp': data['timestamp'] ?? DateTime.now().toIso8601String(),
          'isRead': data['isRead'] ?? false,
        });
        onMessageReceived?.call(message);
      } catch (e) {
        _logger.e('Error parsing received message: $e');
      }
    });
  }

  /// Send message through socket
  /// Similar to sendMessage in React
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
      _logger.i(
        'Message emitted: senderId=$senderId, receiverId=$receiverId, text=$text',
      );
    } catch (e) {
      _logger.e('Error sending message: $e');
      rethrow;
    }
  }

  /// Reconnect socket
  void reconnect() {
    try {
      if (!socket.connected) {
        socket.connect();
        _logger.i('Socket reconnecting...');
      }
    } catch (e) {
      _logger.e('Error reconnecting: $e');
    }
  }

  /// Disconnect socket
  void disconnect() {
    try {
      if (socket.connected) {
        socket.disconnect();
        _logger.i('Socket disconnected');
      }
    } catch (e) {
      _logger.e('Error disconnecting: $e');
    }
  }

  /// Check if socket is connected
  bool isConnected() {
    return socket.connected;
  }
}
