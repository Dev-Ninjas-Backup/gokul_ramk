import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadDummyMessages();
  }

  final TextEditingController messageController = TextEditingController();
  final RxString selectedMessage = ''.obs;
  var imagePath = '';
  RxBool firstMsgSent = false.obs;

  var messages = <Map<String, dynamic>>[].obs;

  void sendMessage(String text) {
    messages.add({
      "isMe": true,     
      "type": "text",
      "text": text,
      "createdAt": DateTime.now().toString(),
    });
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
      imagePath = image.path;
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

  void loadDummyMessages() {
    messages.assignAll([
      {
        "isMe":false,
        "type": "text",
        "text": "Hey! How are you?",
        "createdAt": DateTime.now().subtract(Duration(minutes: 10)).toString(),
      },
      {
        "isMe": false,
        "type": "text",
        "text": "I'm good, thanks! What about you?",
        "createdAt": DateTime.now().subtract(Duration(minutes: 8)).toString(),
      },
      {
        "isMe": false,
        "type": "image",
        "text": "https://picsum.photos/200/200",
        "createdAt": DateTime.now().subtract(Duration(minutes: 5)).toString(),
      },
    ]);
  }
}
