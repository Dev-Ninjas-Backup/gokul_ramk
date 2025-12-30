import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import '../controller/message_controller.dart';

class MessageDetailScreen extends StatefulWidget {
  const MessageDetailScreen({super.key});

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  late final MessageController controller;
  final TextEditingController _messageController = TextEditingController();
  late ScrollController _scrollController;
  late String _partnerId;
  late String _partnerName;
  String? _partnerImage;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Get or create the MessageController
    if (Get.isRegistered<MessageController>()) {
      controller = Get.find<MessageController>();
    } else {
      controller = Get.put(MessageController());
      _initializeController();
    }

    // Get arguments from navigation
    final args = Get.arguments as Map<String, dynamic>?;
    _partnerId = args?['partnerId'] ?? '';
    _partnerName = args?['partnerName'] ?? 'User';
    _partnerImage = args?['partnerImage'];

    // Load conversation messages
    if (_partnerId.isNotEmpty) {
      controller.loadConversation(_partnerId).then((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _initializeController() async {
    try {
      // Get token and userId from SharedPreferences
      final SharedPreferencesHelperController sharedPref = Get.put(
        SharedPreferencesHelperController(),
      );

      final userToken = await sharedPref.getAccessToken();
      final userId = await sharedPref.getUserId();
      final baseUrl = 'https://wellfitsync.com';

      if (userToken != null && userId != null) {
        await controller.initialize(
          userId: userId,
          userToken: userToken,
          baseUrl: baseUrl,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to initialize messaging: $e')),
        );
      }
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      controller.sendMessage(_messageController.text.trim());
      _messageController.clear();
      // Scroll to bottom after sending message
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _partnerName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Obx(
              () => Text(
                controller.isSocketConnected.value ? 'Online' : 'Offline',
                style: TextStyle(
                  fontSize: 12,
                  color: controller.isSocketConnected.value
                      ? Colors.green
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: Obx(
              () => controller.isLoadingMessages.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.currentMessages.isEmpty
                  ? Center(
                      child: Text(
                        'No messages yet\nStart a conversation!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: controller.currentMessages.length,
                      itemBuilder: (context, index) {
                        final message = controller.currentMessages[index];
                        final isOwn =
                            message.senderId == controller.currentUserId.value;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Align(
                            alignment: isOwn
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isOwn
                                    ? Colors.blue[600]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.text,
                                    style: TextStyle(
                                      color: isOwn
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatMessageTime(message.timestamp),
                                    style: TextStyle(
                                      color: isOwn
                                          ? Colors.white70
                                          : Colors.grey[600],
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          // Message input
          Container(
            padding: EdgeInsets.fromLTRB(
              16,
              12,
              16,
              16 + MediaQuery.of(context).viewInsets.bottom,
            ),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type message...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
