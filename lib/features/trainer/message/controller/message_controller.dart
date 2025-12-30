import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../model/conversation_model.dart';
import '../model/message_model.dart';
import '../service/message_api_service.dart';
import '../service/socket_service.dart';

class MessageController extends GetxController {
  final Logger _logger = Logger();
  final MessageApiService _apiService = MessageApiService();
  final SocketService _socketService = SocketService();

  // Observable variables
  final RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  final RxList<MessageModel> currentMessages = <MessageModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMessages = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString currentReceiverId = ''.obs;
  final RxBool isSocketConnected = false.obs;
  final RxString currentUserId = ''.obs;

  late String _userId;
  late String _userToken;
  late String _baseUrl;

  @override
  void onInit() {
    super.onInit();
    _initializeSocket();
  }

  /// Initialize socket with callbacks
  void _initializeSocket() {
    _socketService.onMessageReceived = _onMessageReceived;
    _socketService.onConnectionStatusChanged = _onConnectionStatusChanged;
  }

  /// Connect to socket and fetch conversations
  Future<void> initialize({
    required String userId,
    required String userToken,
    required String baseUrl,
  }) async {
    try {
      _userId = userId;
      _userToken = userToken;
      _baseUrl = baseUrl;
      currentUserId.value = userId;

      // Connect socket
      await _socketService.connect(baseUrl, userId);
      isSocketConnected.value = true;

      // Fetch initial conversations
      await fetchConversations();
    } catch (e) {
      _logger.e('Error initializing message controller: $e');
      errorMessage.value = 'Failed to initialize messaging';
    }
  }

  /// Fetch unique conversations
  Future<void> fetchConversations() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _apiService.getUniqueConversations(
        token: _userToken,
      );
      conversations.assignAll(result);
    } catch (e) {
      _logger.e('Error fetching conversations: $e');
      errorMessage.value = 'Failed to load conversations';
    } finally {
      isLoading.value = false;
    }
  }

  /// Load conversation messages between two users
  Future<void> loadConversation(String receiverId) async {
    try {
      isLoadingMessages.value = true;
      errorMessage.value = '';
      currentReceiverId.value = receiverId;

      final result = await _apiService.getConversation(
        senderId: _userId,
        receiverId: receiverId,
        token: _userToken,
      );
      currentMessages.assignAll(result);
    } catch (e) {
      _logger.e('Error loading conversation: $e');
      errorMessage.value = 'Failed to load conversation';
    } finally {
      isLoadingMessages.value = false;
    }
  }

  /// Send message via socket
  void sendMessage(String text) {
    if (currentReceiverId.value.isEmpty || text.trim().isEmpty) {
      return;
    }

    try {
      _socketService.sendMessage(
        senderId: _userId,
        receiverId: currentReceiverId.value,
        text: text,
      );

      // Add message to local list immediately for UI
      final message = MessageModel(
        id: DateTime.now().toString(),
        senderId: _userId,
        receiverId: currentReceiverId.value,
        text: text,
        timestamp: DateTime.now(),
        isRead: false,
      );
      currentMessages.add(message);
    } catch (e) {
      _logger.e('Error sending message: $e');
      errorMessage.value = 'Failed to send message';
    }
  }

  /// Handle received message
  void _onMessageReceived(MessageModel message) {
    _logger.i('Message received in controller: $message');

    // Add to current messages if it's from the active conversation
    if (message.senderId == currentReceiverId.value ||
        message.receiverId == currentReceiverId.value) {
      currentMessages.add(message);
    }

    // Update conversation last message
    final conversationIndex = conversations.indexWhere(
      (conv) =>
          conv.conversationPartner == message.senderId ||
          conv.conversationPartner == message.receiverId,
    );

    if (conversationIndex != -1) {
      final updatedConv = conversations[conversationIndex];
      conversations[conversationIndex] = ConversationModel(
        id: updatedConv.id,
        userId: updatedConv.userId,
        conversationPartner: updatedConv.conversationPartner,
        partnerName: updatedConv.partnerName,
        partnerImage: updatedConv.partnerImage,
        lastMessage: message.text,
        lastMessageTime: message.timestamp,
        unreadCount: message.senderId != _userId
            ? updatedConv.unreadCount + 1
            : updatedConv.unreadCount,
      );
    }
  }

  /// Handle connection status change
  void _onConnectionStatusChanged(String status) {
    _logger.i('Socket connection status: $status');
    isSocketConnected.value = status == 'connected';

    if (status == 'disconnected') {
      _socketService.reconnect();
    }
  }

  /// Clear current messages when leaving conversation
  void clearCurrentMessages() {
    currentMessages.clear();
    currentReceiverId.value = '';
  }

  /// Disconnect socket
  @override
  void onClose() {
    _socketService.disconnect();
    super.onClose();
  }
}
