import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import '../service/chat_service.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // loadDummyMessages();
    initializeUser();
  }

  final TextEditingController messageController = TextEditingController();
  final RxString selectedMessage = ''.obs;
  var imagePath = ''.obs;
  RxBool firstMsgSent = false.obs;
  var messages = <Map<String, dynamic>>[].obs;

  // User authentication data
  var userId = ''.obs;
  var userToken = ''.obs;
  RxBool isLoading = false.obs;

  final ChatService _chatService = ChatService();
  final SharedPreferencesHelperController _sharedPref = Get.put(
    SharedPreferencesHelperController(),
  );

  /// Initialize user credentials from SharedPreferences
  Future<void> initializeUser() async {
    try {
      final id = await _sharedPref.getUserId();
      final token = await _sharedPref.getAccessToken();

      if (id != null) userId.value = id;
      if (token != null) userToken.value = token;
    } catch (e) {
      print('Error initializing user: $e');
    }
  }

  /// Send message with AI API call
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    // Add user message immediately to UI
    messages.add({
      "isMe": true,
      "type": "text",
      "text": text,
      "createdAt": DateTime.now().toString(),
    });

    messageController.clear();
    isLoading.value = true;

    try {
      // Validate credentials
      if (userId.isEmpty || userToken.isEmpty) {
        await initializeUser();
        if (userId.isEmpty || userToken.isEmpty) {
          EasyLoading.showError('User not authenticated. Please login again.');
          return;
        }
      }

      // Call AI API
      final response = await _chatService.sendMessage(
        userId: userId.value,
        userToken: userToken.value,
        message: text,
        audioFile: null, // No audio file being sent currently
      );

      // Handle response - extract AI message
      String aiResponse = '';

      // Try different response formats
      if (response['reply'] != null && response['reply'] is Map) {
        // Handle reply object format: reply.response
        final replyMap = response['reply'] as Map<String, dynamic>;
        if (replyMap['response'] != null) {
          aiResponse = replyMap['response'].toString();
        }
      } else if (response['message'] != null && response['message'] is String) {
        aiResponse = response['message'].toString();
      } else if (response['data'] != null &&
          response['data']['message'] != null) {
        aiResponse = response['data']['message'].toString();
      } else if (response['text'] != null) {
        aiResponse = response['text'].toString();
      }

      // Fallback if no response found
      if (aiResponse.isEmpty) {
        aiResponse = 'I understood your message. How can I help further?';
      }

      // Add AI response to messages
      messages.add({
        "isMe": false,
        "type": "text",
        "text": aiResponse,
        "createdAt": DateTime.now().toString(),
      });
    } catch (e) {
      print('Error sending message: $e');
      EasyLoading.showError('Failed to send message. Please try again.');

      // Add error message
      messages.add({
        "isMe": false,
        "type": "text",
        "text": 'Sorry, I encountered an error. Please try again.',
        "createdAt": DateTime.now().toString(),
      });
    } finally {
      isLoading.value = false;
    }
  }

  void sendImageMessage() {
    messages.add({
      "type": "image",
      "isMe": true,
      "text": "https://picsum.photos/200/200?random=3",
      "createdAt": DateTime.now().toString(),
    });
  }

  // Insert predefined text into the textfield
  void insertPredefinedMessage(String text) {
    messageController.text = text;
    messageController.selection = TextSelection.fromPosition(
      TextPosition(offset: messageController.text.length),
    );
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
      // You can handle upload or show preview here
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  String formatTime(String createdAt) {
    final time = DateTime.tryParse(createdAt);
    return time != null
        ? "${time.hour}:${time.minute.toString().padLeft(2, '0')}"
        : "";
  }

  // void loadDummyMessages() {
  //   messages.assignAll([
  //     {
  //       "isMe": false,
  //       "type": "text",
  //       "text": "Hey! How are you?",
  //       "createdAt": DateTime.now().subtract(Duration(minutes: 10)).toString(),
  //     },
  //     {
  //       "isMe": false,
  //       "type": "text",
  //       "text": "I'm good, thanks! What about you?",
  //       "createdAt": DateTime.now().subtract(Duration(minutes: 8)).toString(),
  //     },
  //     {
  //       "isMe": false,
  //       "type": "image",
  //       "text": "https://picsum.photos/200/200",
  //       "createdAt": DateTime.now().subtract(Duration(minutes: 5)).toString(),
  //     },
  //   ]);
  // }
}
