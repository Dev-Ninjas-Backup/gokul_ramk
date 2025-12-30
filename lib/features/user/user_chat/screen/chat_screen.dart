// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/user_chat/widget/build_image_message.dart';
import 'package:gokul_ramk/features/user/user_chat/widget/build_message.dart';
import '../controller/chat_controller.dart';
import '../widget/predefined_card.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, size: 18),
        ),
        title: Text(
          "WellFit AI",
          style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              controller.firstMsgSent.value
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          itemCount: controller.messages.length,
                          itemBuilder: (context, index) {
                            final msg = controller.messages[index];
                            final isMe = msg["isMe"];
                            if (msg["type"] == "image") {
                              return buildImageMessage(
                                isMe: isMe,
                                imageUrl: msg["text"],
                                time: controller.formatTime(msg["createdAt"]),
                              );
                            } else {
                              return buildMessage(
                                isMe: isMe,
                                text: msg["text"],
                                time: controller.formatTime(msg["createdAt"]),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          "Hi Adib 👋",
                          style: getTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "I'm your Fit Assistant. How can I help you today?",
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Predefined Cards
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  PredefinedCard(
                                    text: "Suggest a Workout",
                                    icon: Icons.fitness_center,
                                    onTap: () =>
                                        controller.insertPredefinedMessage(
                                          "Suggest a Workout",
                                        ),
                                  ),
                                  PredefinedCard(
                                    text: "Nutrition Advice",
                                    icon: Icons.restaurant,
                                    onTap: () =>
                                        controller.insertPredefinedMessage(
                                          "Nutrition Advice",
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  PredefinedCard(
                                    text: "Check My Schedule",
                                    icon: Icons.calendar_today,
                                    onTap: () =>
                                        controller.insertPredefinedMessage(
                                          "Check My Schedule",
                                        ),
                                  ),
                                  PredefinedCard(
                                    text: "Ask a Question",
                                    icon: Icons.help_outline,
                                    onTap: () =>
                                        controller.insertPredefinedMessage(
                                          "Ask a Question",
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

              controller.firstMsgSent.value ? SizedBox.shrink() : Spacer(),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () => controller.pickImage(),
                    //   child: CircleAvatar(
                    //     radius: 20,
                    //     backgroundColor: Colors.grey.shade200,
                    //     child: Icon(Icons.add),
                    //   ),
                    // ),
                    const SizedBox(width: 5),
                    if (controller.imagePath.value.isNotEmpty)
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(controller.imagePath.value),
                              width: 50,
                              height: 50,
                            ),
                          ),

                          Positioned(
                            top: -6,
                            right: -3,
                            child: GestureDetector(
                              onTap: () {
                                print('tappppped');
                                controller.imagePath.value = '';
                              },
                              child: Icon(Icons.cancel, size: 18),
                            ),
                          ),
                        ],
                      ),

                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        enabled: !controller.isLoading.value,
                        decoration: InputDecoration(
                          hintText: "Write your message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => controller.isLoading.value
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.teal,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (controller
                                    .messageController
                                    .text
                                    .isNotEmpty) {
                                  controller.firstMsgSent.value = true;
                                  controller.sendMessage(
                                    controller.messageController.text,
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.teal,
                                child: Icon(Icons.send, color: Colors.white),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
